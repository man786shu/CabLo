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

@interface CBUploadIDVC ()

@property (nonatomic, strong) CBSocialTableHeaderView *tableHeader;
@property (nonatomic, strong) CBTableFooterView *footer;

@end

@implementation CBUploadIDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableHeader = [[CBSocialTableHeaderView alloc]init];
    [self.tableHeader setTitleForLabel:NSLocalizedString(@"fb_or_manual",@"")];
    self.tableHeader.clipsToBounds = YES;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
