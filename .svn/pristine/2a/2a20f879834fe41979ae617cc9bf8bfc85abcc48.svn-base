//
//  AdWebViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/28.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "AdWebViewController.h"
#import "AppDelegate.h"
#import "GDataXMLNode.h"
#import "APService.h"
#import "Utilitys.h"


@interface AdWebViewController ()<UIWebViewDelegate, UIAlertViewDelegate>
{
    BOOL flag;
    NSString *disMust;
}
@end

@implementation AdWebViewController
NSURL * urlHTAd;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utilitys setOkToLogin:YES];
    [self checkVersion];
    [Person initInstance];
    self.DJSBtn.alpha = 0;
    
    urlHTAd = [NSURL URLWithString:DEF_PAGE_AD];
    [self uiConfig];
}

- (void)checkVersion
{
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    [LDNetwokAPI getAppVersion:KEYWORD successBlock:^(id returnData) {
//        NSLog(@"returnData=%@",returnData);
        NSString *disOptional;
        NSString *strategy;
        NSString *curVersion;
        if (returnData != nil)
        {
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
            NSArray *results = [doc nodesForXPath:@"//results/info" error:nil];
            // 循环遍历每一个<results.../>元素
            for(GDataXMLElement *resultElement in results)
            {
                //获取需求名称元素
                curVersion = [[[resultElement elementsForName:@"version"] objectAtIndex:0] stringValue];
                disMust = [[[resultElement elementsForName:@"description-must"] objectAtIndex:0] stringValue];
                disOptional = [[[resultElement elementsForName:@"description-optional"] objectAtIndex:0] stringValue];
                strategy = [[[resultElement elementsForName:@"strategy"] objectAtIndex:0] stringValue];
                long curNum = [curVersion componentsSeparatedByString:@"."][0].intValue * 100 + [curVersion componentsSeparatedByString:@"."][1].intValue * 10 + [curVersion componentsSeparatedByString:@"."][2].intValue;
                long verNum = [version componentsSeparatedByString:@"."][0].intValue * 100 + [version componentsSeparatedByString:@"."][1].intValue * 10 + [version componentsSeparatedByString:@"."][2].intValue;
                
                if (curNum > verNum) {
                    if ([strategy isEqualToString:@"optional"]) {
                        [Utilitys setOkToLogin:YES];
                        [self showDialog:disOptional];
                    }else if ([strategy isEqualToString:@"must"]){
                        [Utilitys setOkToLogin:NO];
                        [self showDialog:disMust];
                    }else{
                        if (curVersion.intValue > version.intValue) {
                            [Utilitys setOkToLogin:NO];
                            [self showDialog:disMust];
                        }else{
                            [Utilitys setOkToLogin:YES];
                            [self showDialog:disOptional];
                        }
                    }
                }
                if ([Utilitys getOkToLogin]) {
                    self.DJSBtn.alpha = 1;
                    [Utilitys adPage:^{
                        
                        [self.DJSBtn setTitle:@"00" forState:0];
                        if (!flag)
                        {
                            [self performSelector:@selector(gologinVc) withObject:nil afterDelay:1];
                        }
                        
                    } blockNo:^(id time) {
                        
                        [self.DJSBtn setTitle:time forState:0];
                    }];
                }
            }
        }
    } failureBlock:^(NSError *error) {
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
    } showHUD:YES];
}

- (void)showDialog:(NSString *)msg
{
    NSString *optionalTitle;
    if ([Utilitys getOkToLogin]) {
        optionalTitle = @"取消";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:optionalTitle, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNCELINK]];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && ![Utilitys getOkToLogin]) {
        [self showDialog:disMust];
    }
}

//进入登录页
- (void)gologinVc
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *loginUserStr = [Person getInstance].name;
    NSString *passwordStr = [Person getInstance].password;
    
    CATransition *animation =  [[CATransition alloc] init];
    animation.delegate = self;
    animation.duration = 1.0f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"fade";
    animation.subtype = @"fromBottom";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [delegate.window.layer addAnimation:animation forKey:nil];

    if ([loginUserStr isBlank] && [passwordStr isBlank])
    {
        [delegate showLoginVc];
    }
    else
    {
        [LDNetwokAPI loginByKeyword:KEYWORD key:@"" userName:loginUserStr passWord:passwordStr successBlock:^(id returnData) {
            
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
                        [APService setAlias:loginUserStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
                        p.mobile = msg[3];
                        p.typeNumber = [msg[1] intValue];
                        p.email = msg[2];
                        p.name = loginUserStr;
                        p.password = passwordStr;
                        [p saveInstance];
                        [delegate showMainViewController];
                    }else{
                        [delegate showLoginVc];
                    }
                }
            }
            
        } failureBlock:^(NSError *error) {  
            
            [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
            
        } showHUD:YES];
    }
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)jumpLoginVc:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    flag = YES;
    [self gologinVc];
}


- (void) uiConfig
{
    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [self.aDwebView setDataDetectorTypes:UIDataDetectorTypeAll];
    [self.aDwebView loadRequest:[NSURLRequest requestWithURL:urlHTAd]];
    self.aDwebView.delegate = self;
    [self.view addSubview:self.aDwebView];
    [self.aDwebView addSubview:self.DJSBtn];
}


// 网页开始加载的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
// 网页加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

// 网页加载出错的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([error code] == NSURLErrorCancelled)
    {
        [webView removeFromSuperview];
        UIImageView *bgCry = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        bgCry.image = [UIImage imageNamed:@"cry"];
        bgCry.center = CGPointMake(DEF_SCREEN_WIDTH / 2, DEF_SCREEN_HEIGHT / 2);
        self.view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:bgCry];
    }
}

// 网页中的每一个请求都会被触发这个方法，返回NO代表不执行这个请求(常用于JS与iOS之间通讯)
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


@end
