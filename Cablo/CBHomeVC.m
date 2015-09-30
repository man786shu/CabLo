//
//  CBHomeVC.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBHomeVC.h"
#import "CBUserRegistrationVC.h"
#import "CBConstants.h"
#import "CBAccountManager.h"
#import "AppDelegate.h"

@interface CBHomeVC ()

@property (nonatomic, strong) CBUserRegistrationVC *userRegistrationVC;

@end

@implementation CBHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpNavigationBar{
    self.title = @"Home";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[CBAccountManager sharedManager] updateUserAccountInfo];
    if (![[CBAccountManager sharedManager] isUserLoggedIn]) {
        self.userRegistrationVC = [self.storyboard instantiateViewControllerWithIdentifier:kUserRegistrationVC];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:self.userRegistrationVC];
        [self presentViewController:navController animated:NO completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
