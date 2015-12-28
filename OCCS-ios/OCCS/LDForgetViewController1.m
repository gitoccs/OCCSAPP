//
//  LDForgetViewController1.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDForgetViewController1.h"
#import "LDForgetViewController2.h"
#import "GDataXMLNode.h"

@interface LDForgetViewController1 ()

@end

@implementation LDForgetViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.phoneLastNumLabel.text = [NSString stringWithFormat:@"验证码已发送到尾号为%@的手机",[self.phoneNumLast substringWithRange:NSMakeRange(7, 4)]];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
    
    self.sendAgainBtn.layer.masksToBounds = YES;
    self.sendAgainBtn.layer.cornerRadius = 2;

    ///验证码倒计时
    [Utilitys verificationCode:^{
        
        [self.sendAgainBtn setEnabled:YES];
        [self.sendAgainBtn setTitle:@"重新发送" forState:0];
        self.sendAgainBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.sendAgainBtn setBackgroundColor:UIColorFromRGB(0xE87A49)];
        
    } blockNo:^(id time) {
        
        self.sendAgainBtn.titleLabel.numberOfLines = 0;
        [self.sendAgainBtn setTitle:[NSString stringWithFormat:@"获取验证码\n倒计时%@s",time] forState:0];
        [self.sendAgainBtn setEnabled:NO];
        [self.sendAgainBtn setBackgroundColor:UIColorFromRGB(0x828282)];
        self.sendAgainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)toDoNext:(id)sender
{
    [self validateCodeData];
}

///验证验证码是否正确
- (void) validateCodeData
{
    self.VerCodeTf.text = [self.VerCodeTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [LDNetwokAPI ValidateByKeyword:KEYWORD phoneOrEmail:self.phoneNumLast code:self.VerCodeTf.text userid:@"" successBlock:^(id returnData) {
        
        NSString* status;
        NSString* msg;
        NSLog(@"returnData=%@",returnData);
        
        if (returnData != nil)
        {
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
            NSArray *results = [doc nodesForXPath:@"//results" error:nil];
            // 循环遍历每一个<results.../>元素
            for(GDataXMLElement *resultElement in results)
            {
                //获取需求名称元素
                status = [[[resultElement elementsForName:@"status"] objectAtIndex:0] stringValue];
                msg = [[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue];
            }
        }
        if (status.integerValue == 1)
        {
            LDForgetViewController2 *forgetVc2 = [[LDForgetViewController2 alloc] initWithNibName:@"LDForgetViewController2" bundle:nil];
            forgetVc2.navigationItem.title = @"找回密码";
            [self.navigationController pushViewController:forgetVc2 animated:YES];
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        

    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];

    } showHUD:YES];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///再次发生验证码
- (IBAction)sendAgaindata:(id)sender
{
    [self sendCodeByPhoneNum];
}


///根据手机号发送验证码
- (void)sendCodeByPhoneNum
{
    [LDNetwokAPI verificationCodeByKeyword:KEYWORD phoneNum:self.phoneNumLast userid:USERID successBlock:^(id returnData) {
        
        NSString* status;
        NSString* msg;
        NSLog(@"returnData=%@",returnData);
        
        if (returnData != nil)
        {
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
            NSArray *results = [doc nodesForXPath:@"//results" error:nil];
            // 循环遍历每一个<results.../>元素
            for(GDataXMLElement *resultElement in results)
            {
                //获取需求名称元素
                status = [[[resultElement elementsForName:@"status"] objectAtIndex:0] stringValue];
                msg = [[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue];
            }
        }
        
        if (status.intValue != 1)
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}

@end
