//
//  LDForgetViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDForgetViewController.h"
#import "LDForgetViewController1.h"
#import "GDataXMLNode.h"

@interface LDForgetViewController ()

@end
///绑定de手机号
NSString *bindingPhoneNum;

@implementation LDForgetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toDoNext:(id)sender
{
    NSString *errorMessage;
    ///去除首尾的空格和换行符
    self.occsUserName.text = [self.occsUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([self.occsUserName.text length] == 0)
    {
        errorMessage = @"用户名不能为空";
    }

    [Utilitys isBlankString:errorMessage] ? nil : [Utilitys showAlertWithMsg:errorMessage andTitle:@"提示" andVc:self];

    [self getPhoneNumByUserName];
}

///根据occs用户名得到手机号
- (void)getPhoneNumByUserName
{
    [LDNetwokAPI backPhoneNumByKeyword:KEYWORD userName:self.occsUserName.text successBlock:^(id returnData) {
        
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
        NSLog(@"%lu", (unsigned long)msg.length);
        if (status.integerValue == 1 && msg.length == 23)
        {
            bindingPhoneNum = [msg substringWithRange:NSMakeRange(12, 11)];
            [self sendCodeByPhoneNum];
        }else if(status.integerValue == 1 && msg.length != 23){
            [Utilitys showAlertWithMsg:@"您的手机号码未绑定或不正确，请联系客服人员" andTitle:@"提示" andVc:self];
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];

    } showHUD:NO];
}

///根据手机号发送验证码
- (void)sendCodeByPhoneNum
{
    [LDNetwokAPI verificationCodeByKeyword:KEYWORD phoneNum:bindingPhoneNum userid:USERID successBlock:^(id returnData) {
        
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
        
        if (status.intValue == 1)
        {
            LDForgetViewController1 *forgetVc1 = [[LDForgetViewController1 alloc] initWithNibName:@"LDForgetViewController1" bundle:nil];
            forgetVc1.navigationItem.title = @"找回密码";
            forgetVc1.phoneNumLast = bindingPhoneNum;
            [self.navigationController pushViewController:forgetVc1 animated:YES];
            [LDClientEngine sharedInstance].appuserName = self.occsUserName.text;
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}
@end
