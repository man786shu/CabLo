//
//  CBSocialLoginVC.m
//  Cablo
//
//  Created by Rohit Yadav on 10/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//


#import "CBSocialLoginVC.h"
#import "CBProfessionalInfoVC.h"
#import "CBSocialTableHeaderView.h"
#import "CBTableFooterView.h"
#import "CBTextField.h"
#import "CBTextfieldCell.h"
#import "AppDelegate.h"
#import "CBUtility.h"
#import "CBStyle.h"
#import "CBToast.h"
#import "CBAccountManager.h"
#import "CBDatePickerView.h"
#import "CBPickerView.h"
#import "CBProfileImgCell.h"

@interface CBSocialLoginVC () < UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, CBDatePickerViewDelegate, CBPickerViewDelegate>{
    NSDictionary *fbAccountInfo;
}
@property (nonatomic, strong) CBSocialTableHeaderView *tableHeader;
@property (nonatomic, strong) CBTableFooterView *footer;
@property (nonatomic, strong) CBDatePickerView *birthdatePicker;
@property (nonatomic, strong) CBPickerView *pickerView;
@property (nonatomic, strong) NSString *firstName, *lastName,*fullname, *gender, *picture, *email, *dob;
@property (nonatomic, strong) UIImage *profileImg;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation CBSocialLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableHeader = [[CBSocialTableHeaderView alloc]init];
    [self.tableHeader setTitleForButton:NSLocalizedString(@"fb_login",@"")];
    [self.tableHeader.button addTarget:self action:@selector(fbBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeader setTitleForLabel:NSLocalizedString(@"fb_or_manual",@"")];
    self.tableHeader.clipsToBounds = YES;
    
    self.footer = [[CBTableFooterView alloc]initWithFrame:CGRectZero];
    self.footer.footerMode = CBFooterModeAllComponents;
    [self.footer.button addTarget:self action:@selector(submitTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self updateFooterViewCurrentState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGSize size = self.view.bounds.size;
    self.tableHeader.frame = (CGRect){0.0,0.0,size.width, 120.0};
    self.tableView.tableHeaderView = self.tableHeader;
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasources and Delegates -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"VerifyProductOTPCell";
   // static NSString *profileImgCellIdentifier = @"profileImgCell";
//    if (indexPath.row == 0) {
//        CBProfileImgCell *cell = (CBProfileImgCell *)[tableView dequeueReusableCellWithIdentifier:profileImgCellIdentifier];
//        if (!cell) {
//            cell = [[CBProfileImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:profileImgCellIdentifier];
//        }
//        if (self.profileImg) {
//            [cell setProfileImg:self.profileImg];
//        }
//        return cell;
//    }
//    else{
        CBTextfieldCell *cell = (CBTextfieldCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[CBTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.textfield.delegate = self;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textfield.tag = row;
        cell.textfield.delegate = self;
        [cell.textfield setText:[self cellTitleForIndex:row]];
        [cell.textfield setPlaceholder:[self cellPlaceholderForIndex:row]];
        cell.clipsToBounds = YES;
        return cell;
    //}
}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == 0) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"alert_title", @"") message:NSLocalizedString(@"image_actionsheet_message", @"") preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }];
//        UIAlertAction *openCamera = [UIAlertAction actionWithTitle:NSLocalizedString(@"camera", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self openCamera];
//        }];
//        
//        UIAlertAction *openGallery = [UIAlertAction actionWithTitle:NSLocalizedString(@"gallery", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self openGallery];
//        }];
//        [alertController addAction:cancelAction];
//        [alertController addAction:openGallery];
//        [alertController addAction:openCamera];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 150.0;
//    }
//    else
        return [CBTextfieldCell heightForCell];
}

- (NSString *)cellPlaceholderForIndex:(NSInteger)row
{
    NSString * headerTitle = nil;
    if (row == 0){
        headerTitle = NSLocalizedString(@"enter_email", @"");
    }
    else if (row == 1){
        headerTitle = NSLocalizedString(@"enter_first_name", @"");
    }
    else if (row == 2){
        headerTitle = NSLocalizedString(@"enter_last_name", @"");
    }
    else if (row == 3){
        headerTitle = NSLocalizedString(@"gender", @"");
    }
    else if (row == 4){
        headerTitle = NSLocalizedString(@"dob", @"");
    }
    return headerTitle;
}

- (NSString *)cellTitleForIndex:(NSInteger)row{
    if (row == 0) {
        return _email;
    }
    else if (row == 1){
        return _firstName;
    }
    else if (row == 2){
        return _lastName;
    }
    else if (row == 3){
        return _gender;
    }
    else
        return _dob;
}


- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"next", @"") forState:UIControlStateNormal];
    //self.footer.textLabel.text = NSLocalizedString(@"add_registration_footer_note", @"");
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - IBActions -
- (IBAction)submitTapped:(id)sender{
    [self.view endEditing:YES];
    if ([self validateData]) {
        [self createParamDict];
        CBProfessionalInfoVC *professionalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CBProfessionalInfoVC"];
        professionalVC.params = self.params;
        [self.navigationController pushViewController:professionalVC animated:YES];
    }
}

- (IBAction)fbBtnTapped:(id)sender{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [login
     logInWithReadPermissions: @[@"public_profile"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error || result.isCancelled) {
             NSLog(@"Error : %@",error);
         }
         else {
             NSString *token = [[FBSDKAccessToken currentAccessToken] tokenString];
             NSLog(@"Token : %@",token);
             NSDictionary *params = @{@"fields":@"email, name, birthday, bio, address, gender, first_name, last_name, age_range, picture"};
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:params tokenString:token version:@"v2.4" HTTPMethod:@"GET"];
             
                         [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                          {
                              fbAccountInfo = (NSDictionary *)result;
                              NSString *fbToken = [[FBSDKAccessToken currentAccessToken] tokenString];
                              _firstName = [result valueForKey:@"first_name"];
                              _email = [result valueForKey:@"email"];
                              _lastName = [result valueForKey:@"last_name"];
                              _gender = [result valueForKey:@"gender"];
                              
                             // NSDictionary *ageRangeDict = [result valueForKey:@"age_range"];
                             // NSString *ageRange = [ageRangeDict valueForKey:@"min"];
                             
                              NSDictionary *pictureDict = [result valueForKey:@"picture"];
                              NSDictionary *dataDict = [pictureDict valueForKey:@"data"];
                              _picture = [dataDict valueForKey:@"url"];
                            
                              //NSString *userID = [result valueForKey:@"id"];
                               _fullname = nil;
                              if (_firstName.length > 0 && _lastName.length > 0) {
                                  self.fullname = [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
                              }
                              else if (_firstName.length > 0) {
                                  _fullname = _firstName;
                              }
                              else if (_lastName.length > 0) {
                                  _fullname = _lastName;
                              }
             
                              if (_fullname == nil) {
                                  _fullname = [result valueForKey:@"name"];
                              }
             
                              if (error || _fullname.length == 0 || _email.length == 0 || fbToken.length == 0) {
                                  //[CBUtility showDefaultAlertWithMessage:NSLocalizedString(@"fb_login_error_msg", "")];
                                  //[CBUtility hideHUD];
                                  return ;
                              }
                              [self.tableView reloadData];
                              //fbAccountInfo = [[NSMutableDictionary alloc]init];
                              //[fbAccountInfo ]
         }];
        }
     }];
}

#pragma mark - CBDatePickerDelegats -
- (void)didTapCancelButton
{
    [self.view endEditing:YES];
    //[self removePickerView];
}

- (void)didTapDoneButton
{
    NSDate *dateOfBirth = self.birthdatePicker.datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
    _dob = [dateFormat stringFromDate:dateOfBirth];
    [self.view endEditing:YES];
    [self.tableView reloadData];
}

#pragma mark - CBPickerViewDelegate - 
- (void)pickerViewCancelTapped
{
    [self.view endEditing:YES];
}

- (void)pickerViewDoneTapped:(NSString *)selectedGender
{
    _gender = selectedGender;
    [self.view endEditing:YES];
    [self.tableView reloadData];
}


#pragma mark - UITextfield delegates -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 4) {
        self.birthdatePicker = [[CBDatePickerView alloc]initWithFrame:CGRectZero];
        self.birthdatePicker.delegate = self;
        CGSize size = self.view.bounds.size;
        [self.birthdatePicker setFrame:(CGRect){0,0, size.width, 250}];
        textField.inputView = self.birthdatePicker;
    }
    else if (textField.tag == 3){
        self.pickerView = [[CBPickerView alloc]initWithFrame:CGRectZero];
        self.pickerView.delegate = self;
        CGSize size = self.view.bounds.size;
        [self.pickerView setFrame:(CGRect){0,0, size.width, 250}];
        textField.inputView = self.pickerView;
    }
        [textField reloadInputViews];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self makeNextTfFirstResponder:textField.tag];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self didTapReturn:textField];
}

- (void)makeNextTfFirstResponder:(NSInteger)index
{
    CBTextfieldCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(index+1) inSection:0]];
    if ([nextCell isKindOfClass:[CBTextfieldCell class]]) {
        [nextCell.textfield becomeFirstResponder];
    }
    else
        [self.view endEditing:YES];
}

- (void)didTapReturn:(UITextField *)txf
{
    CBTextField *textfield = (CBTextField *)txf;
    if (textfield.tag == 0) {
        _email = textfield.text;
    }
    else if (textfield.tag == 1){
        _firstName = textfield.text;
    }
    else if (textfield.tag == 2){
        _lastName = textfield.text;
    }
}

#pragma mark - validate data - 
- (BOOL)validateData
{
    if (_email.length <= 0 || _firstName.length <= 0 || _lastName.length <= 0 || _dob.length <= 0 || _gender.length <= 0) {
        [[CBToast shared] showToastMessage:NSLocalizedString(@"enter_all_details", @"")];
        return false;
    }
    else if (![self NSStringIsValidEmail:_email]){
        [[CBToast shared] showToastMessage:NSLocalizedString(@"invalid_email", @"")];
        return false;
    }
    return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
    self.profileImg = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - setup dictionary - 
- (void) createParamDict{
    self.params = [NSMutableDictionary new];
   // [self.params setObject:self.firstName forKey:@"firstName"];
   // [self.params setObject:self.lastName forKey:@"lastName"];
    [self.params setValue:self.fullname forKey:@"name"];
    [self.params setValue:self.userMobileNumber forKey:@"phone_number"];
    [self.params setValue:self.email forKey:@"email_id"];
    [self.params setValue:self.gender forKey:@"gender"];
    [self.params setValue:self.dob forKey:@"dateOfBirth"];
//    if (self.picture) {
//        [self.params setValue:self.picture forKey:@"profile_image"];
//    }
}

@end
