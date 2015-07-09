//
//  ViewController.m
//  MaterialTableView
//
//  Created by Tomoya_Hirano on 7/9/27 H.
//  Copyright (c) 27 Heisei Tomoya_Hirano. All rights reserved.
//

#import "ViewController.h"
#import "MaterialTableView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MaterialTableViewDelegate>{
    UIView*header;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView*tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    MaterialTableView*v = [[MaterialTableView alloc] initWithFrame:self.view.bounds tableView:tableView];
    v.minHeaderHeight = 64;
    v.maxHeaderHeight = 64*3;
    v.center = self.view.center;
    [v setButtonBlock:^{
        NSLog(@"tap");
    }];
    header = [UIView new];
    header.backgroundColor = [UIColor yellowColor];
    v.headerView = header;
    v.delegate = self;
    [self.view addSubview:v];
}

#pragma mark - MaterialTableViewDalegate
- (void)MaterialTableViewWillShowHeader:(MaterialTableView *)view{

}

- (void)MaterialTableViewDidShowHeader:(MaterialTableView *)view{

}

#pragma mark - UITableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
