//
//  CBHomeVC.m
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#import "CBHomeVC.h"
#import "CBUserRegistrationVC.h"
#import "CBSideMenuController.h"
#import "CBConstants.h"
#import "CBStyle.h"
#import "CBAccountManager.h"
#import "AppDelegate.h"

typedef enum{
    CBContainerModeSideMenu,
    CBContainerModeSideMenuHidden
} CBContainerMode;

@interface CBHomeVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) CBUserRegistrationVC *userRegistrationVC;
@property (nonatomic, strong) CBSideMenuController *menuVC;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePan;
@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, assign) CBContainerMode *mode;

@end

@implementation CBHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.overlayView = [[UIControl alloc] initWithFrame:CGRectZero];
    [self.overlayView addTarget:self action:@selector(overlayTouched:) forControlEvents:UIControlEventTouchDown];
    self.overlayView.backgroundColor = kHomeOverlayColor;
    [self.view addSubview:_overlayView];
    
    self.menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PVSideMenuController"];
    [self addChildViewController:self.menuVC];
    //self.menuVC.delegate = self;
    [self.view addSubview:_menuVC.view];
    [self.menuVC didMoveToParentViewController:self];
    
    UIScreenEdgePanGestureRecognizer *swipeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgeSwipe:)];
    swipeGesture.edges = UIRectEdgeLeft;
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
    
    self.edgePan = swipeGesture;
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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect = self.view.frame;
    CGFloat overlayX = kSideMenuWidth;
    
    CGRect sideMenuFrame = (CGRect){-overlayX,0.0,overlayX,rect.size.height};
    CGRect overlayFrame = (CGRect){0.0,0.0,rect.size};
    
    if (_mode == CBContainerModeSideMenu) {
        overlayFrame.origin.x += overlayX;
        sideMenuFrame.origin.x += overlayX;
        self.overlayView.alpha = 1.0;
    }
    else {
        self.overlayView.alpha = 0.0;
    }
    
    self.menuVC.view.frame = sideMenuFrame;
    self.overlayView.frame = overlayFrame;

}

- (void)overlayTouched:(id)sender
{
    [self updateMode];
}

- (void)handleEdgeSwipe:(UIScreenEdgePanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self updateMode];
    }
}

- (void)updateMode
{
       [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end
