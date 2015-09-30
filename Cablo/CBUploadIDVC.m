//
//  CBUploadIDVC.m
//  Cablo
//
//  Created by Rohit Yadav on 16/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBUploadIDVC.h"
#import "CBSocialTableHeaderView.h"
#import "CBTableFooterView.h"
#import "CBAccountManager.h"
#import "CBToggleBtnCell.h"
#import "CBToast.h"
#import "CBError.h"
#import "CBButtonCell.h"

@interface CBUploadIDVC()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,CBToggleBtnCellDelegate>{
    NSMutableArray *selectedArray;
    UIImage *govtIdImage;
}

@property (nonatomic, strong) CBSocialTableHeaderView *tableHeader;
@property (nonatomic, strong) CBTableFooterView *footer;

@end

@implementation CBUploadIDVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableHeader = [[CBSocialTableHeaderView alloc]init];
//    [self.tableHeader setTitleForLabel:NSLocalizedString(@"fb_or_manual",@"")];
//    self.tableHeader.clipsToBounds = YES;
    selectedArray = [[NSMutableArray alloc]init];
    
    self.footer = [[CBTableFooterView alloc]initWithFrame:CGRectZero];
    self.footer.footerMode = CBFooterModeAllComponents;
    [self.footer.button addTarget:self action:@selector(finishTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self updateFooterViewCurrentState];
    
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    CGSize size = self.view.bounds.size;
//    self.tableHeader.frame = (CGRect){0.0,0.0,size.width, 120.0};
//    self.tableView.tableHeaderView = self.tableHeader;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupNavigationBar -
- (void)setupNavigationBar{
    self.title = @"Upload";
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 125.0;
    }
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"uploadCell";
    static NSString *buttonCellIdentifier = @"buttonCell";
    NSInteger row = indexPath.row;
    if (row == 4) {
        CBButtonCell *cell = (CBButtonCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellIdentifier];
        if (cell == nil) {
            cell = [[CBButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttonCellIdentifier];
        }
        cell.tag = row;
        [cell.button setTitle:NSLocalizedString(@"select_image", @"") forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(selectImageTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.defaultTextLabel setText:NSLocalizedString(@"upload_id_footer_note", @"")];
        return cell;
    }
    else{
        CBToggleBtnCell *uploadIdCell = (CBToggleBtnCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (uploadIdCell == nil) {
            uploadIdCell = [[CBToggleBtnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        uploadIdCell.tag = row;
        uploadIdCell.delegate = self;
        [uploadIdCell setTitleTextforIndex:row];
        NSNumber *currentRow = [NSNumber numberWithInteger:row];
        if ([selectedArray containsObject:currentRow]) {
            [uploadIdCell setTogglebtnSelected:YES];
        }
        else
            [uploadIdCell setTogglebtnSelected:NO];
        
        return uploadIdCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *row = [NSNumber numberWithInteger:indexPath.row];
    if ([selectedArray containsObject:row]){
        [selectedArray removeObject:row];
    }
    else
    {
        [selectedArray removeAllObjects];
        [selectedArray addObject:row];
    }
    [self.tableView reloadData];
}

#pragma mark - footer methods -
- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"finish", @"") forState:UIControlStateNormal];
    
    [self.footer.button setEnabled:YES];
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - IBActions -
- (IBAction)selectImageTapped:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"alert_title", @"") message:NSLocalizedString(@"image_actionsheet_message", @"") preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel_btn", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *openCamera = [UIAlertAction actionWithTitle:NSLocalizedString(@"camera", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openCamera];
            }];
    
            UIAlertAction *openGallery = [UIAlertAction actionWithTitle:NSLocalizedString(@"gallery", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openGallery];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:openGallery];
            [alertController addAction:openCamera];
    
            [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)finishTapped:(id)sender
{
    [[CBAccountManager sharedManager]createUserForParameters:self.params andGovtIdImage:govtIdImage withCompletionHandler:^(bool success, CBError *error) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [[CBToast shared]showToastMessage:error.messageText];
        }
    }];
}

#pragma mark - open camera -
- (void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [[CBToast shared]showToastMessage:NSLocalizedString(@"camera_not_available", @"")];
    }
    else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)openGallery {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        [[CBToast shared]showToastMessage:NSLocalizedString(@"gallery_not_available", @"")];
    }
    else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
     govtIdImage = info[UIImagePickerControllerEditedImage];
    self.footer.textLabel.text = NSLocalizedString(@"image_selected_message", @"");
    [self.footer refreshFooter];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Cell delegate -
- (void)toggleBtnForIndexPath:(NSInteger)index
{
    
}




@end
