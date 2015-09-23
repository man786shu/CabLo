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
#import "CBAccountManager.h"

@interface CBSocialLoginVC () < UITextFieldDelegate>{
    NSDictionary *fbAccountInfo;
}
@property (nonatomic, strong) CBSocialTableHeaderView *tableHeader;
@property (nonatomic, strong) CBTableFooterView *footer;

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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
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
    CBTextfieldCell *cell = (CBTextfieldCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CBTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textfield.delegate = self;
        
    }
    cell.textfield.tag = row;
    cell.textfield.delegate = self;
    [cell.textfield setPlaceholder:[self cellTitleForIndex:row]];
    cell.clipsToBounds = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CBTextfieldCell heightForCell];
}

- (NSString *)cellTitleForIndex:(NSInteger)row
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
        headerTitle = NSLocalizedString(@"enter_password", @"");
    }
    else if (row == 4){
        headerTitle = NSLocalizedString(@"confirm_password", @"");
    }
    return headerTitle;
}

- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"submit", @"") forState:UIControlStateNormal];
    //self.footer.textLabel.text = NSLocalizedString(@"add_registration_footer_note", @"");
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - IBActions -
- (IBAction)submitTapped:(id)sender{
    CBProfessionalInfoVC *professionalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CBProfessionalInfoVC"];
    [self.navigationController pushViewController:professionalVC animated:YES];
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
                              NSString *firstName = [result valueForKey:@"first_name"];
                              NSString *email = [result valueForKey:@"email"];
                              NSString *lastName = [result valueForKey:@"last_name"];
                              //NSString *userID = [result valueForKey:@"id"];
                              NSString *fullName = nil;
                              if (firstName.length > 0 && lastName.length > 0) {
                                  fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
                              }
                              else if (firstName.length > 0) {
                                  fullName = firstName;
                              }
                              else if (lastName.length > 0) {
                                  fullName = lastName;
                              }
             
                              if (fullName == nil) {
                                  fullName = [result valueForKey:@"name"];
                              }
             
                              if (error || fullName.length == 0 || email.length == 0 || fbToken.length == 0) {
                                  //[CBUtility showDefaultAlertWithMessage:NSLocalizedString(@"fb_login_error_msg", "")];
                                  //[CBUtility hideHUD];
                                  return ;
                              }
         }];
        }
     }];
}




@end
