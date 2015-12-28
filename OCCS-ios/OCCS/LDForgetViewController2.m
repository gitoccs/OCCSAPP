//
//  LDForgetViewController2.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDForgetViewController2.h"
#import "GDataXMLNode.h"
#import "AppDelegate.h"
#import "LDLoginViewController.h"

@interface LDForgetViewController2 ()<UIAlertViewDelegate>
{
    NSInteger index;
}
@end

@implementation LDForgetViewController2


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.affBtn.layer.masksToBounds = YES;
    self.affBtn.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)finishCommit:(id)sender
{
    NSString *errorMessage;
    self.newpasswordTf.text = [self.newpasswordTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.affPasswordTf.text = [self.affPasswordTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.newpasswordTf.text length] == 0)
    {
        errorMessage = @"新密码不能为空";
    }
    else if([self.affPasswordTf.text length] == 0)
    {
        errorMessage = @"确认密码不能为空";
    }
    else if (![self.newpasswordTf.text isEqualToString:self.affPasswordTf.text])
    {
        errorMessage = @"两次密码确认不一致";
    }
    else
    {
        [self updataPasswordByNewpassword];
    }
    [Utilitys isBlankString:errorMessage] ? nil : [Utilitys showAlertWithMsg:errorMessage andTitle:@"提示" andVc:self];
}

///更改密码
- (void)updataPasswordByNewpassword
{
    NSString *username = [Utilitys isBlankString:[[LDClientEngine sharedInstance] appuserName]] ? @"" : [[LDClientEngine sharedInstance] appuserName];

    [LDNetwokAPI changePasswordByKeyword:KEYWORD userName:username passWord:self.newpasswordTf.text successBlock:^(id returnData) {
        
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        index = status.integerValue;
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];

    } showHUD:YES];
}


- (IBAction)backbtn:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    LDLoginViewController *loginViewController = [[LDLoginViewController alloc] initWithNibName:@"LDLoginViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navi.navigationBar.hidden = YES;
    delegate.window.rootViewController = navi;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (index == 1)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}
@end
