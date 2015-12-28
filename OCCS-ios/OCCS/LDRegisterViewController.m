//
//  LDRegisterViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDRegisterViewController.h"
#import "GDataXMLNode.h"
#import "LDLoginViewController.h"
#import "AppDelegate.h"
#import "AgreementViewController.h"
#import "APService.h"

@interface LDRegisterViewController ()<UIAlertViewDelegate>

@end


BOOL agree;
@implementation LDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verCodeBtn.layer.masksToBounds = YES;
    self.verCodeBtn.layer.cornerRadius = 3;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
    switch (self.userGroupID)
    {
        case 9:
            //注册企业用户会员
            self.navititle.text = @"注册企业用户";
            break;
        case 91:
            //注册软件企业会员
            self.navititle.text = @"注册软件公司";
            break;
        case 1:
            //注册个人会员
            self.navititle.text = @"注册个人用户";
            break;
        default:
            break;
    }

    [self addNotice];
}


//弹出协议VC

- (IBAction)presentvc:(id)sender {
    AgreementViewController *agreeVc = [[AgreementViewController alloc] initWithNibName:@"AgreementViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:agreeVc];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//添加键盘通知
-(void)addNotice
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark ---键盘事件--

-(void)keyBoardWillShow:(NSNotification *)not
{
    CGSize size = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [UIView animateWithDuration:0.35 animations:^{
        if (IS_IPHONE_4_OR_LESS)
        {
            if ([self.passwordTf isFirstResponder])
            {
                self.view.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - size.height - DEF_TABBAR_HEIGHT - 250, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
            }
            else if ([self.affirmTf isFirstResponder])
            {
                self.view.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - size.height - DEF_TABBAR_HEIGHT - 280, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
            }
            else if ([self.referrerIDTf isFirstResponder])
            {
                self.view.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - size.height - DEF_TABBAR_HEIGHT - 320, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
            }
        }
    }];
}

#pragma mark - 键盘隐藏和显示
-(void)keyBoardWillHide
{
    [UIView animateWithDuration:0.35 animations:^{
        
        if (IS_IPHONE_4_OR_LESS)
        {
            self.view.frame = CGRectMake(0, 0 , DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
        }
    }];
}

- (IBAction)getVerCode:(id)sender
{
    [LDNetwokAPI verificationCodeByKeyword:KEYWORD phoneNum:self.phoneNumTf.text userid:USERID successBlock:^(id returnData) {
        
        NSString* status;
        NSString* msg;
        NSLog(@"returnData=%@",returnData);
        UIColor *color = self.verCodeBtn.backgroundColor;
        
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
            self.verCodeBtn.backgroundColor = [UIColor lightGrayColor];
            ///验证码倒计时
            [Utilitys verificationCode:^{
                
                [self.verCodeBtn setTitle:@"获取验证码" forState:0];
                [self.verCodeBtn setTitle:@"获取验证码" forState:1];
                [self.verCodeBtn setEnabled:YES];
                self.verCodeBtn.backgroundColor = color;
                
            } blockNo:^(id time) {
                
                [self.verCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",time] forState:0];
                [self.verCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",time] forState:1];
                [self.verCodeBtn setEnabled:NO];
                
            }];
        }
        
        [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];

    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];

    } showHUD:YES];
}

///注册提交
- (IBAction)registerBtn:(id)sender
{
    NSString *errorMessage;
    ///去除首尾的空格和换行符
    self.userTf.text = [self.userTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.passwordTf.text = [self.passwordTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.affirmTf.text = [self.affirmTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.phoneNumTf.text = [self.phoneNumTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.verCodeTf.text = [self.verCodeTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!agree) {
        [Utilitys showAlertWithMsg:@"请同意协议" andTitle:@"提示" andVc:self];
        return;
    }
    
    if (![Utilitys isBlankString:[self isValidUserName]])
    {
        errorMessage =  [self isValidUserName];
    }
    else if (![Utilitys isBlankString:[self isValidPassWord]])//[[self isValidPassWord] isEqualToString:@""])
    {
        errorMessage =  [self isValidPassWord];
    }
    else
    {
        if ([self.userTf.text length] == 0)
        {
            errorMessage = @"用户名不能为空";
        }
        else if ([self.passwordTf.text length] == 0)
        {
            errorMessage = @"密码不能为空";
        }
        else if ([self.affirmTf.text length] == 0)
        {
            errorMessage = @"再次输入密码不能为空";
        }
        else if ([self.phoneNumTf.text length] == 0)
        {
            errorMessage = @"手机号码不能为空";
        }
        else if ([self.verCodeTf.text length] == 0)
        {
            errorMessage = @"验证码不能为空";
        }
        else if ([self.passwordTf.text compare: self.affirmTf.text] != NSOrderedSame)
        {
            errorMessage = @"确认密码填写不正确";
        }
        else
        {
            [self validateCodeData];
        }
    }
        
    [Utilitys isBlankString:errorMessage] ? nil : [Utilitys showAlertWithMsg:errorMessage andTitle:@"提示" andVc:self];
}

///注测网络请求
- (void) registerBtnData
{
    [LDNetwokAPI registerByKeyword:KEYWORD userName:self.userTf.text passWord:self.passwordTf.text phoneNum:self.phoneNumTf.text groupid:[NSString stringWithFormat:@"%ld",(long)self.userGroupID] successBlock:^(id returnData) {
        
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
            [self loginData];
            Person *p = [Person getInstance];
            p.name = self.userTf.text;
            p.password = self.passwordTf.text;
            [p saveInstance];
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        LDLoginViewController *loginViewController = [[LDLoginViewController alloc] initWithNibName:@"LDLoginViewController" bundle:nil];
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//        navi.navigationBar.hidden = YES;
//        delegate.window.rootViewController = navi;
        [delegate showMainViewController];
    }
}

///验证验证码是否正确
- (void) validateCodeData
{
    self.verCodeTf.text = [self.verCodeTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"self.verCodeTf.text = %@",self.verCodeTf.text);
    
    [LDNetwokAPI ValidateByKeyword:KEYWORD phoneOrEmail:self.phoneNumTf.text code:self.verCodeTf.text userid:@"" successBlock:^(id returnData) {
        
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
            [self registerBtnData];
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }

    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}


///验证用户名
- (NSString *) isValidUserName
{
    NSString *msg;
    NSString *userNameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5_]{3,16}$";
    NSPredicate *userNamePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL isValid = [userNamePred evaluateWithObject:self.userTf.text];
    if (!isValid)
    {
        if ([self.userTf.text length] < 3)
        {
            msg = @"用户名长度最少为3位";
        }
        else if([self.userTf.text length] > 16)
        {
            msg = @"字符串最大长度为16";
        }
        else
        {
            msg = @"用户名为中英文数字以及下划线";
        }
    }
    return msg;
}


///验证密码
- (NSString *) isValidPassWord
{
    NSString *msg;
    NSString *pwdRegex = @"^.*(([a-z]|[A-Z])+.*[0-9]+)|([0-9]+.*([a-z]|[A-Z])+).*$";
    NSPredicate *pwdPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    if(![pwdPred evaluateWithObject:self.passwordTf.text])
    {
        msg = @"密码必须包含字母和数字";
    }
    return msg;
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)changeBtnBackIcon:(UIButton *)sender {
    sender.selected = !sender.selected;
    agree = sender.selected;
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"agree"] forState:UIControlStateSelected];
}

- (void)loginData
{
    [LDNetwokAPI loginByKeyword:KEYWORD key:@"" userName:self.userTf.text passWord:self.passwordTf.text successBlock:^(id returnData) {
        
        NSString* status;
        NSArray* msg;
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
                msg = [[[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue] componentsSeparatedByString:@","];
                NSString *t;
                if (![msg[0] isEqualToString:@"登录成功"] && ![msg[0] isEqualToString:@"登录失败！"])
                {
                    if ([msg[1] isEqualToString:@"1"])
                    {
                        t = @"1";
                    }
                    else if ([msg[1] isEqualToString:@"91"])
                    {
                        t = @"3";
                    }
                    else
                    {
                        t = @"2";
                    }
                    Person *p = [Person getInstance];
                    p.name = self.userTf.text;
                    p.password = self.passwordTf.text;
                    p.typeNumber = [t intValue];
                    [p saveInstance];
                }
            }
        }
        
        if (status.integerValue == 0)
        {
            [Utilitys showAlertWithMsg:msg[0] andTitle:@"提示" andVc:self];
        }
        else if (status.integerValue == 1 && ![msg[0] isEqualToString:@"登录成功"])
        {
            Person *p = [Person getInstance];
            p.key = msg[0];
            [p saveInstance];
            //存储返回的用户的Key
            [LDClientEngine sharedInstance].loginKeyStr = p.key;
            [APService setAlias:self.userTf.text callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
            NSLog(@"log moblie: %@", msg[3]);
            p.mobile = msg[3];
            p.email = msg[2];
            p.typeNumber = [msg[1] intValue];
            [p saveInstance];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        if (status.integerValue == 1)
        {
            Person *p = [Person getInstance];
            p.name = self.userTf.text;
            [p saveInstance];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


@end
