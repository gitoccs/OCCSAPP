//
//  LDSearchViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/16.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDSearchViewController.h"

@interface LDSearchViewController ()

@end

@implementation LDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
