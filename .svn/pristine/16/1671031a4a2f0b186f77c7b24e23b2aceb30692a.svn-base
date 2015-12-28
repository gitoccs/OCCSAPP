//
//  ChangeEmailDoController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "ChangeEmailDoController.h"
#import "AccountModifyController.h"

@interface ChangeEmailDoController ()

@end

@implementation ChangeEmailDoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定新邮箱";
    [self roundAllButtons];
    [self backTapHideKeyboard];
    // Do any additional setup after loading the view.
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

- (IBAction)goCode:(UIButton *)sender {
    [Utilitys getEmailVerifyCode:sender email:[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                         success:^(int status, id message) {
                             [Utilitys showAlertWithMsg:message andTitle:@"提示" andVc:self];
                         } fail:^{
                             [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                         }];
}

- (IBAction)goYes:(UIButton *)sender {
    [Utilitys validateCodeData:[self.codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                         media:[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                       success:^(int status, id message) {
                           if (status == 1)
                           {
                               AccountModifyController *popVC = (AccountModifyController *)self.navigationController.viewControllers[0];
                               [popVC.delegate dismissSelfVC];
                               Person *p = [Person getInstance];
                               p.email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                               [p saveInstance];
                           }
                           else
                           {
                               [Utilitys showAlertWithMsg:message andTitle:@"提示" andVc:self];
                           }
                       } fail:^{
                           [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                       }];
}
@end
