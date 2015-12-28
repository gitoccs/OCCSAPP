//
//  ChangeEmailCodeController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "ChangeEmailCodeController.h"
#import "ChangeEmailDoController.h"

@interface ChangeEmailCodeController ()

@end

@implementation ChangeEmailCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证邮箱";
    [self roundAllButtons];
    [self backTapHideKeyboard];
    self.emailLabel.text = [Person getInstance].email;
    
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

- (IBAction)getCode:(UIButton *)sender {
    self.codeTextField.text = [self.codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [Utilitys validateCodeData:self.codeTextField.text media:[Person getInstance].email
                       success:^(int status, id message) {
                           if (status == 1)
                           {
                               ChangeEmailDoController *doneVC = [[ChangeEmailDoController alloc] initWithNibName:@"ChangeEmailDoController" bundle:nil];
                               [self.navigationController pushViewController:doneVC animated:YES];
                           }
                           else
                           {
                               [Utilitys showAlertWithMsg:message andTitle:@"提示" andVc:self];
                           }
                       } fail:^{
                           [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                       }];
}

- (IBAction)goNext:(UIButton *)sender {
    [Utilitys getEmailVerifyCode:sender email:[self.emailLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                         success:^(int status, id message) {
        [Utilitys showAlertWithMsg:message andTitle:@"提示" andVc:self];
    } fail:^{
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
    }];
}
@end
