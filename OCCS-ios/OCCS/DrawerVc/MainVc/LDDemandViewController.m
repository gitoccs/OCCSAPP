
//
//  LDDemandViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/28.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDDemandViewController.h"

@interface LDDemandViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;
}
@end

@implementation LDDemandViewController

NSURL * urlHT1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    self.navigationController.navigationBar.barTintColor = ORANGECOLOR;
    [self titleViewLabelStr:@"发布需求"];
    UIBarButtonItem *leftBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"backbtn" target:self actoin:@selector(backLogin)];
    self.navigationItem.leftBarButtonItem = leftBar;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackIcon:) name:PAGENOT object:nil];
}


- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon Demand");
    if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"1"])
    {
        
    }
    else if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"2"])
    {
        [LDClientEngine sharedInstance].whichPage = @"1";
    }
    else
    {
        [LDClientEngine sharedInstance].whichPage = @"2";
    }
}

///退回login
- (void)backLogin
{
    if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"1"])
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"2"] || [[LDClientEngine sharedInstance].whichPage isEqualToString:@"99"])
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage1()"];
    }
    else
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage2()"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *appendStr = [[NSString alloc] initWithFormat:@"?name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                           [Person getInstance].name,
                           [Person getInstance].key,
                           [Person getInstance].mobile,
                           [Person getInstance].typeNumber,
                           [Person getInstance].email];
    appendStr = [appendStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlHT1 = [NSURL URLWithString:[DEF_PAGE_FBXQ stringByAppendingFormat:@"%@",appendStr]];
    NSLog(@"uiConfig urlHT1 %@",urlHT1);

    [self uiConfig];
}

/**
 *  设置导航栏上面的title
 *
 *  @param str 根据传过来的str
 */
- (void)titleViewLabelStr:(NSString *)str
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((DEF_SCREEN_WIDTH - 150) / 2, 20, 150, 40)];
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(20, 0  , 100, 40)];
    titleView.text = str;
    [titleView setTextColor:[UIColor whiteColor]];
    titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    [bgView addSubview:titleView];
    bgView.userInteractionEnabled = YES;
    self.navigationItem.titleView = bgView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) uiConfig
{
    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webview setDataDetectorTypes:UIDataDetectorTypeAll];
    [webview loadRequest:[NSURLRequest requestWithURL:urlHT1]];
    webview.delegate = self;
    [self.view addSubview:webview];
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
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *rurl = [[request URL] absoluteString];
    NSLog(@"%@",rurl);
    if ([rurl hasPrefix:@"info"])
    {
        if ([rurl hasSuffix:@"page1"])
        {
            [LDClientEngine sharedInstance].whichPage = @"1";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGEXQNOT object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page2"])
        {
            [LDClientEngine sharedInstance].whichPage = @"2";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGEXQNOT object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page3"])
        {
            [LDClientEngine sharedInstance].whichPage = @"3";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGEXQNOT object:nil];
            return NO;
        }else if ([rurl hasSuffix:@"page4"])
        {
            [LDClientEngine sharedInstance].whichPage = @"4";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGEXQNOT object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page99"])
        {
            [LDClientEngine sharedInstance].whichPage = @"99";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
            return NO;
        }

    }
    return YES;
}

@end
