//
//  AccountModifyController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "AccountModifyController.h"
#import "ChangePassOldController.h"
#import "ChangeMobileCodeController.h"
#import "ChangeMobileDoController.h"
#import "ChangeEmailCodeController.h"
#import "ChangeEmailDoController.h"

@interface AccountModifyController ()


@end

@implementation AccountModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBarItemsWithTitle:@"账号管理"];
    [self roundAllButtons];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)changePass:(UIButton *)sender {
    ChangePassOldController *changeOld = [[ChangePassOldController alloc] initWithNibName:@"ChangePassOldController" bundle:nil];
    [self.navigationController pushViewController:changeOld animated:YES];
}

- (IBAction)changeMobile:(UIButton *)sender {
    PupupViewController *controller;
    if ([Person getInstance].mobile && ![[Person getInstance].mobile isBlank]) {
        controller = [[ChangeMobileCodeController alloc] initWithNibName:@"ChangeMobileCodeController" bundle:nil];
    }else{
        controller = [[ChangeMobileDoController alloc] initWithNibName:@"ChangeMobileDoController" bundle:nil];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)changeEmail:(UIButton *)sender {
    PupupViewController *controller;
    if ([Person getInstance].email && ![[Person getInstance].email isBlank]) {
        controller = [[ChangeEmailCodeController alloc] initWithNibName:@"ChangeEmailCodeController" bundle:nil];
    }else{
        controller = [[ChangeEmailDoController alloc] initWithNibName:@"ChangeEmailDoController" bundle:nil];
    }
    [self.navigationController pushViewController:controller animated:YES];
}
@end
