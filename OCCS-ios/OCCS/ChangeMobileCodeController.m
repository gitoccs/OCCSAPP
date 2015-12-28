//
//  ChangeMobileCodeController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "ChangeMobileCodeController.h"
#import "ChangeMobileDoController.h"

@interface ChangeMobileCodeController ()

@end

@implementation ChangeMobileCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机";
    [self roundAllButtons];
    [self backTapHideKeyboard];
    self.mobileLabel.text = [Person getInstance].mobile;
    
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

- (IBAction)goNext:(UIButton *)sender {
    self.codeTextField.text = [self.codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [Utilitys validateCodeData:self.codeTextField.text media:[Person getInstance].mobile
                       success:^(int status, id message) {
        if (status == 1)
        {
            ChangeMobileDoController *doneVC = [[ChangeMobileDoController alloc] initWithNibName:@"ChangeMobileDoController" bundle:nil];
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

- (IBAction)getCode:(UIButton *)sender {
    [Utilitys getVerifyCode:sender mobile:[self.mobileLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                    success:^(int status, id message) {
                        [Utilitys showAlertWithMsg:message andTitle:@"提示" andVc:self];
                    } fail:^{
                        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
                    }];
}
@end
