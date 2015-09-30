//
//  CBVerifyOTPVC.m
//  Cablo
//
//  Created by Rohit Yadav on 09/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBVerifyOTPVC.h"
#import "CBVerifyOTPVC.h"
#import "CBHomeVC.h"
#import "CBSocialLoginVC.h"
#import "CBTableHeaderView.h"
#import "CBTableFooterView.h"
#import "CBTextField.h"
#import "CBTextfieldTitleCell.h"
#import "CBVerifyPhoneNumberCell.h"
#import "CBKeyboardAccessoryView.h"
#import "CBStyle.h"
#import "CBConstants.h"
#import "CBUtility.h"
#import "NSString+validation.h"
#import "CBAccountManager.h"
#import "CBWebEngineConstants.h"
#import "CBError.h"
#import "CBToast.h"

@interface CBVerifyOTPVC ()<UITextFieldDelegate, CBTextFieldDelegate, CBVerifyPhoneNumberCellDelegate, CBKeyboardAccessoryViewDelegate>
{
    BOOL _hasError;
    BOOL _isOTPDisabled;
}

@property (nonatomic, strong) NSString * userOTPNumber;
@property (nonatomic, assign) BOOL resendOTPButtonTapped;
@property (nonatomic, strong) CBTableFooterView *footer;

@end

@implementation CBVerifyOTPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.tableHeaderView = [[CBTableHeaderView alloc] initWithText:NSLocalizedString(@"add_otp_header_note", @"")];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.footer = [[CBTableFooterView alloc] initWithFrame:CGRectZero];
    self.footer.footerMode = CBFooterModeAllComponents;
    [self.footer.button addTarget:self action:@selector(submitTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.footer.resendButton addTarget:self action:@selector(resendOTP:) forControlEvents:UIControlEventTouchUpInside];
    [self updateFooterViewCurrentState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    if (row == 0)
    {
        static NSString *cellIdentifier = @"VerifyNumberCell";
        CBVerifyPhoneNumberCell *cell = (CBVerifyPhoneNumberCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[CBVerifyPhoneNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        [cell updateCellWithNumber:self.userMobileNumber];
        cell.editNumberDelegate = self;
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"VerifyProductOTPCell";
        CBTextfieldTitleCell *cell = (CBTextfieldTitleCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[CBTextfieldTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.tf.delegate = self;
            
            CBKeyboardAccessoryView *view = [[CBKeyboardAccessoryView alloc] initWithFrame:(CGRect) {0.0, 0.0, self.view.bounds.size.width, kKeyboardAccessoryHeight} andMode:CBDoneButtonOnly];
            view.delegate = self;
            cell.tf.inputAccessoryView = view;
        }
        
        NSString *title = [self cellTitleForIndex:row];
        float w = kLOBBigContentWidth;
        [cell updateTitleWithText:title forWidth:w];
        
        cell.tf.delegate = self;
        cell.tf.text = self.userOTPNumber;
        [cell shouldShowLeftViewWithData:nil];
        cell.tf.tag =  0;
        [cell disableTf:_isOTPDisabled];
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self cellTitleForIndex:indexPath.row];
    float w = 0.0;
    
    if (indexPath.row == 0)
    {
        w = self.view.bounds.size.width;
        return [CBVerifyPhoneNumberCell heightForWidth:w withTitleText:title];
    }
    else
    {
        w = kLOBBigContentWidth;
        return [CBTextfieldTitleCell heightForWidth:w withTitleText:title];
    }
}


- (NSString *)cellTitleForIndex:(NSInteger)row
{
    NSString * headerTitle = nil;
    
    if (row == 0)
    {
        headerTitle = self.userMobileNumber;
    }
    else if (row == 1)
    {
        headerTitle = NSLocalizedString(@"enter_otp_message", @"");
    }
    
    return headerTitle;
}


- (void)updateFooterViewCurrentState
{
    [self.footer.button setTitle:NSLocalizedString(@"confirm", @"") forState:UIControlStateNormal];
    self.footer.textLabel.text = NSLocalizedString(@"add_otp_footer_note", @"");
    NSString *title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"resend_otp", @""), kRightButtonIcon];
    [self.footer.resendButton setTitle:title forState:UIControlStateNormal];
    
    [self.footer.button setEnabled:NO];
    [self.footer refreshFooter];
    self.tableView.tableFooterView = self.footer;
}

#pragma mark - IBActions -
- (IBAction)submitTapped:(id)sender{
    [self.view endEditing:YES];
    //CBSocialLoginVC *socialLoginVC = [self.storyboard instantiateViewControllerWithIdentifier:kSocialLoginVC];
   // [self.navigationController pushViewController:socialLoginVC animated:YES];
    NSDictionary *params = @{@"phone_number":self.userMobileNumber, @"pin":self.userOTPNumber};
    [[CBAccountManager sharedManager] verifyOTPForParams:params withCompletionHandler:^(bool success, bool newUser, CBError *error) {
        if (error) {
            [[CBToast shared]showToastMessage:error.messageText];
        }
        else{
            if (newUser) {
                CBSocialLoginVC *socialLoginVC = [self.storyboard instantiateViewControllerWithIdentifier:kSocialLoginVC];
                socialLoginVC.userMobileNumber = self.userMobileNumber;
                [self.navigationController pushViewController:socialLoginVC animated:YES];
            }
            else
            {
                [self dismissViewControllerAnimated:YES completion:nil];
                //CBHomeVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:kHomeVC];
                //[self.navigationController pushViewController:homeVC animated:YES];
            }
        }
    }];
}

- (IBAction)resendOTP:(id)sender{
    [self.view endEditing:YES];
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:self.userMobileNumber,@"phone_number", nil];
    [[CBAccountManager sharedManager]requestOTPForParams:params withCompletionHandler:^(bool success, CBError *error) {
        if (success) {
        }
        else{
            NSLog(@"error : %@",error.messageText);
            [[CBToast shared]showToastMessage:error.messageText];;
        }
    }];
}

#pragma mark - verify phone number cell delegate
- (void)editUserMobileNumberTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - keyboard accessory view delegate -
- (void)didTapDoneButton
{
    [self.view endEditing:YES];
}

#pragma mark - Text Field delegates

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        self.userOTPNumber = textField.text;
    }
}

#pragma mark - UITEXTFIELD delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ((text.length > 4 || ![text isAllDigits]) && textField.tag == 0) {
        return NO;
    }
    
    if (((text.length == 4 || ![text isAllDigits]) && textField.tag == 0)) {
        [self.footer.button setEnabled:YES];
    }
    else
        [self.footer.button setEnabled:NO];
    
    return YES;
}

- (void)updateTfState
{
        CBTextfieldTitleCell *cell = (CBTextfieldTitleCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell.tf setIsInvalid:_hasError];
        [cell disableTf:_isOTPDisabled];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _hasError = NO;
    [self updateTfState];
    return YES;
}


@end
