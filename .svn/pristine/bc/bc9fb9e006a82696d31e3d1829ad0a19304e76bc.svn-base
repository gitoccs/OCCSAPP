//
//  LDLoginViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDLoginViewController.h"
#import "LDSelRegisterViewController.h"
#import "LDForgetViewController.h"
#import "GDataXMLNode.h"
#import "AppDelegate.h"
#import "APService.h"
#import "LDDemandViewController.h"

@interface LDLoginViewController ()

@end

@implementation LDLoginViewController

 
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.registerBtn addTarget:self action:@selector(pushRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 3;

    [self.forgetBtn addTarget:self action:@selector(pushdemandVC:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetBtn.layer.masksToBounds = YES;
    self.forgetBtn.layer.cornerRadius = 3;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    
    self.userNameTf.text = [Person getInstance].name;
}

- (void)pushRegisterVC:(UIButton *)sender
{
    LDSelRegisterViewController *selRegisterVc = [[LDSelRegisterViewController alloc] initWithNibName:@"LDSelRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:selRegisterVc animated:YES];
}
- (IBAction)forgetBtn:(id)sender {
    LDForgetViewController *forgetVc = [[LDForgetViewController alloc] initWithNibName:@"LDForgetViewController" bundle:nil];
    forgetVc.navigationItem.title = @"找回密码";
    [self.navigationController pushViewController:forgetVc animated:YES];
}

- (void)pushdemandVC:(UIButton *)sender
{
    
}

- (IBAction)LoginBtn:(id)sender
{
    NSString *errorMessage;
    ///去除首尾的空格和换行符
    self.userNameTf.text = [self.userNameTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.passWordTf.text = [self.passWordTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.userNameTf.text length] == 0)
    {
        errorMessage = @"用户名不能为空";
    }
    else if ([self.passWordTf.text length] == 0)
    {
        errorMessage = @"密码不能为空";
    }
    else
    {
        [self loginBtnData];
    }
    [Utilitys isBlankString:errorMessage] ? nil : [Utilitys showAlertWithMsg:errorMessage andTitle:@"提示" andVc:self];
}


///登录网络请求数据
- (void) loginBtnData
{
    if (![[Person getInstance].name isEqualToString:self.userNameTf.text])
    {
        [Person emptyInstance];
        Person *p = [Person getInstance];
        p.name = self.userNameTf.text;
    }
    
//    NSString *keyStr = [Utilitys isBlankString:[Person getInstance].key] ? @"" : [Person getInstance].key;
    
    NSString *userNameStr = self.userNameTf.text;
    NSString *passWordStr = self.passWordTf.text;
    
    [LDNetwokAPI loginByKeyword:KEYWORD key:@"" userName:userNameStr passWord:passWordStr successBlock:^(id returnData) {
        
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
                if (status.intValue == 1) {
                    Person *p = [Person getInstance];
                    p.key = msg[0];
                    [p saveInstance];
                    [LDClientEngine sharedInstance].loginKeyStr = p.key;
                    [APService setAlias:userNameStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                    p.mobile = msg[3];
                    p.typeNumber = [msg[1] intValue];
                    p.email = msg[2];
                    p.name = userNameStr;
                    p.password = passWordStr;
                    [p saveInstance];
                    [self OnLogin];
                }else{
                    [Utilitys showAlertWithMsg:msg[0] andTitle:@"提示" andVc:self];
                }
            }
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

- (void)OnLogin
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    CATransition *animation =  [[CATransition alloc] init];
    animation.delegate = self;
    animation.duration = 1.0f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"fade";
    animation.subtype = @"fromBottom";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [delegate.window.layer addAnimation:animation forKey:nil];
    [delegate showMainViewController];
}

- (IBAction)pushXQVc:(id)sender {
    
    LDDemandViewController *demandVc = [[LDDemandViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:demandVc];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
