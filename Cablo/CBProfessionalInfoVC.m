//
//  CBProfessionalInfoVC.m
//  Cablo
//
//  Created by Rohit Yadav on 16/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBProfessionalInfoVC.h"
#import "CBSocialTableHeaderView.h"
#import "CBTextfieldCell.h"
#import "CBTextField.h"
#import "CBTableFooterView.h"
#import "CBUploadIDVC.h"
#import "LinkedInHelper.h"
#import "CBConstants.h"
#import "CBToast.h"

@interface CBProfessionalInfoVC ()<UITextFieldDelegate>{
    NSDictionary *linkedInAccountInfo;
}

@property (nonatomic, strong) CBSocialTableHeaderView *tableHeader;
@property (nonatomic, strong) CBTableFooterView *footer;
@property (nonatomic, strong) NSString *companyName, *designation;

@end

@implementation CBProfessionalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableHeader = [[CBSocialTableHeaderView alloc]init];
    [self.tableHeader setTitleForButton:NSLocalizedString(@"linkedIn_login",@"")];
    [self.tableHeader.button addTarget:self action:@selector(linkedInBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeader setTitleForLabel:NSLocalizedString(@"linkedin_or_manual",@"")];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"VerifyProductOTPCell";
    CBTextfieldCell *cell = (CBTextfieldCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CBTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textfield.delegate = self;
        
    }
    cell.textfield.tag = row;
    cell.textfield.delegate = self;
    [cell.textfield setPlaceholder:[self cellPlaceholderForIndex:row]];
    [cell.textfield setText:[self cellTitleForIndex:row]];
    cell.clipsToBounds = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CBTextfieldCell heightForCell];
}

- (NSString *)cellPlaceholderForIndex:(NSInteger)row
{
    NSString * headerTitle = nil;
    if (row == 0){
        headerTitle = NSLocalizedString(@"company_name", @"");
    }
    else if (row == 1){
        headerTitle = NSLocalizedString(@"designation", @"");
    }
    else{
        headerTitle = nil;
    }
    return headerTitle;
}

- (NSString *)cellTitleForIndex:(NSInteger)row{
    if (row == 0) {
        return _companyName;
    }
    else
        return _designation;
}

#pragma mark - IBActions -
- (IBAction)submitTapped:(id)sender{
    if ([self validateData]) {
        [self addFieldsToDict];
        CBUploadIDVC *uploadVC = [self.storyboard instantiateViewControllerWithIdentifier:kUploadIDVC];
        uploadVC.params = self.params;
        [self.navigationController pushViewController:uploadVC animated:YES];
    }
}

- (IBAction)linkedInBtnTapped:(UIButton *)sender {
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    // If user has already connected via linkedin in and access token is still valid then
    // No need to fetch authorizationCode and then accessToken again!
    
//    if (linkedIn.isValidToken) {
//        linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@", first_name, last_name];
//        // So Fetch member info by elderyly access token
//        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
//            // Whole User Info
//            NSLog(@"user Info : %@", userInfo);
//        } failUserInfo:^(NSError *error) {
//            NSLog(@"error : %@", error.userInfo.description);
//        }];
//    } else {
    
        linkedIn.cancelButtonText = @"Close"; // Or any other language But Default is Close
        
        NSArray *permissions = @[@(BasicProfile),
                                 @(EmailAddress),
                                 @(Share),
                                 @(CompanyAdmin)];
        
        linkedIn.showActivityIndicator = YES;
        
        [linkedIn requestMeWithSenderViewController:self
                                           clientId:@"77liszw25dyo4l"
                                       clientSecret:@"QypZjRDOQbGqETms"
                                        redirectUrl:@"http://www.iappstreet.com"
                                        permissions:permissions
                                              state:@""
                                    successUserInfo:^(NSDictionary *userInfo) {
                                        
                                        // Whole User Info
                                        NSLog(@"user Info : %@", userInfo);
                                        linkedInAccountInfo = userInfo;
                                        // You can also fetch user's those informations like below
                                        NSLog(@"job title : %@",     [LinkedInHelper sharedInstance].title);
                                        self.designation = [LinkedInHelper sharedInstance].title;
                                        NSLog(@"company Name : %@",  [LinkedInHelper sharedInstance].companyName);
                                        self.companyName = [LinkedInHelper sharedInstance].companyName;
                                        NSLog(@"email address : %@", [LinkedInHelper sharedInstance].emailAddress);
                                        NSLog(@"Photo Url : %@",     [LinkedInHelper sharedInstance].photo);
                                        NSLog(@"Industry : %@",      [LinkedInHelper sharedInstance].industry);
                                        [self.tableView reloadData];
                                    }
                                  failUserInfoBlock:^(NSError *error) {
                                      NSLog(@"error : %@", error.userInfo.description);
                                  }
         ];
    //}
}

#pragma mark - footer view -
- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"submit", @"") forState:UIControlStateNormal];
    //self.footer.textLabel.text = NSLocalizedString(@"add_registration_footer_note", @"");
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - UITextFieldDelegate -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
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
        _companyName = textfield.text;
    }
    else if (textfield.tag == 1){
        _designation = textfield.text;
    }
}

- (void)addFieldsToDict{
    [self.params setValue:self.companyName forKey:@"companyName"];
    [self.params setValue:self.designation forKey:@"designation"];
}


#pragma mark - validate data
- (BOOL)validateData
{
    if (_designation.length <= 0 || _companyName.length <= 0) {
        [[CBToast shared] showToastMessage:NSLocalizedString(@"enter_all_details", @"")];
        return false;
    }
  
    return YES;
}

@end
