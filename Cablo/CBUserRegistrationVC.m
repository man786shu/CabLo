//
//  CBUserRegistrationVC.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBUserRegistrationVC.h"
#import "CBVerifyOTPVC.h"
#import "CBTableHeaderView.h"
#import "CBTableFooterView.h"
#import "AppDelegate.h"
#import "CBTextfieldTitleCell.h"
#import "CBKeyboardAccessoryView.h"
#import "CBStyle.h"
#import "CBTextField.h"
#import "NSString+validation.h"
#import "CBAccountManager.h"
#import "CBWebEngineConstants.h"

@interface CBUserRegistrationVC ()<UITextFieldDelegate,CBKeyboardAccessoryViewDelegate>
{
    BOOL _hasError;
    BOOL _isLoginDisabled;
}

@property (nonatomic, strong) NSString * userMobileNumber;
@property (nonatomic, strong) CBTableFooterView *footer;

@end

@implementation CBUserRegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[CBTableHeaderView alloc]initWithImage:[UIImage imageNamed:@"mobile_verify_icon"]];
    self.footer = [[CBTableFooterView alloc]initWithFrame:CGRectZero];
    self.footer.footerMode = CBFooterModeAllComponents;
    [self.footer.button addTarget:self action:@selector(submitTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self updateFooterViewCurrentState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appd = [[UIApplication sharedApplication] delegate];
    if (appd.splashView) {
        [appd.splashView removeFromSuperview];
        appd.splashView = nil;
    }
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"enterNumberCell";
    CBTextfieldTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[CBTextfieldTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.tf.delegate = self;
        
        CBKeyboardAccessoryView *view = [[CBKeyboardAccessoryView alloc] initWithFrame:(CGRect) {0.0, 0.0, self.view.bounds.size.width, kKeyboardAccessoryHeight} andMode:MADoneButtonOnly];
        view.delegate = self;
        cell.tf.inputAccessoryView = view;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger row = indexPath.row;
    NSString *title = [self cellTitleForIndex:row];
    float w = kLOBBigContentWidth;
    [cell updateTitleWithText:title forWidth:w];
    
    if (row == 0) {
        cell.tf.tag = 0;
        cell.tf.delegate = self;
        cell.tf.text = self.userMobileNumber;
        [cell shouldShowLeftViewWithData:@"+91"];
        //[cell.tf setIsInvalid:_hasError]
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self cellTitleForIndex:indexPath.row];
    float w = kLOBBigContentWidth;
    return [CBTextfieldTitleCell heightForWidth:w withTitleText:title];
}

- (NSString *)cellTitleForIndex:(NSInteger)row
{
    NSString * headerTitle = nil;
    
    if (row == 0)
    {
        headerTitle = NSLocalizedString(@"enter_10_digit_mobile_registration_note", @"");
    }
    
    return headerTitle;
}

- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"submit", @"") forState:UIControlStateNormal];
    self.footer.textLabel.text = NSLocalizedString(@"add_registration_footer_note", @"");
    
    [self.footer.button setEnabled:NO];
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - Keyboard accessory delegate -
-(void)didTapDoneButton
{
    [self.view endEditing:YES];
}

#pragma mark - IBActions - 
- (IBAction)submitTapped:(id)sender
{
    [self.view endEditing:YES];
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:SANDBOX_NUMBER,@"phone_number", nil];
    [[CBAccountManager sharedManager]requestOTPForParams:params withCompletionHandler:^(bool success, NSError *error) {
        if (success) {
            CBVerifyOTPVC *verifyOTP = [self.storyboard instantiateViewControllerWithIdentifier:kVerifyOTPVC];
            verifyOTP.userMobileNumber = self.userMobileNumber;
            [self.navigationController pushViewController:verifyOTP animated:YES];
        }
        else{
            NSLog(@"error : %@",error.localizedDescription);
        }
    }];
    
}


#pragma mark - Text Field delegates

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        self.userMobileNumber = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ((text.length > 10 || ![text isAllDigits]) && textField.tag == 0) {
        return NO;
    }
    
    if (((text.length == 10 || ![text isAllDigits]) && textField.tag == 0)) {
        [self.footer.button setEnabled:YES];
    }
    else
        [self.footer.button setEnabled:NO];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _hasError = NO;
    [self updateTfState];
    return YES;
}

- (void)updateTfState
{
        CBTextfieldTitleCell *cell = (CBTextfieldTitleCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.tf setIsInvalid:_hasError];
        [cell disableTf:_isLoginDisabled];
}


@end
