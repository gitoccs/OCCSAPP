//
//  LDSelRegisterViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDSelRegisterViewController.h"
#import "LDRegisterViewController.h"

@interface LDSelRegisterViewController ()

@end

@implementation LDSelRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.companyBtn.layer.masksToBounds = YES;
    self.companyBtn.layer.cornerRadius = 3;
    self.softCompanyBtn.layer.masksToBounds = YES;
    self.softCompanyBtn.layer.cornerRadius = 3;
    self.personBtn.layer.masksToBounds = YES;
    self.personBtn.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushRegisterView:(UIButton *)sender
{
    LDRegisterViewController *registerVc = [[LDRegisterViewController alloc] initWithNibName:@"LDRegisterViewController" bundle:nil];
    registerVc.navigationItem.title = @"注册";
    NSInteger t ;
    switch (sender.tag)
    {
        case 200:
            //注册企业用户会员
            t = 9;
            break;
        case 201:
            //注册软件企业会员
            t = 91;
            break;
        case 202:
            //注册个人会员
            t = 1;
            break;
        default:
            break;
    }
    registerVc.userGroupID = t;
    [self.navigationController pushViewController:registerVc animated:YES];

}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
