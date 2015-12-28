//
//  WebUIViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/25.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "WebUIViewController.h"
#import "LDWebViewController.h"

@interface WebUIViewController ()

@end

@implementation WebUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackIcon:) name:PAGENOT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackIconHide:) name:LEFT_BAR object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon webviewcontroller");
}

- (void)changeBackIconHide:(NSNotification *)noti
{
    NSLog(@"hidden webviewcontroller");
}

- (void)dismissSelf:(UIBarButtonItem *)button
{
    if ([[LDClientEngine sharedInstance].whichPage intValue] != 99) {
        if ([[LDClientEngine sharedInstance].whichPage intValue] > 1) {
            [self goPreviousVC];
        }else{
            [self dismissSelfVC];
        }
    }else{
        
    }
}

- (void)dismissSelfVC{
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
       [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)goPreviousVC{
    
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
    NSString *rurl = [[request URL] absoluteString];
    NSLog(@"rurllll :%@",rurl);
    if ([rurl hasPrefix:@"info"])
    {
        if ([rurl hasSuffix:@"page1"])
        {
            [LDClientEngine sharedInstance].whichPage = @"1";
            [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page2"])
        {
            [LDClientEngine sharedInstance].whichPage = @"2";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page3"])
        {
            [LDClientEngine sharedInstance].whichPage = @"3";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
            return NO;
        }else if ([rurl hasSuffix:@"page4"])
        {
            [LDClientEngine sharedInstance].whichPage = @"4";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
            return NO;
        }
        else if ([rurl hasSuffix:@"page99"])
        {
            [LDClientEngine sharedInstance].whichPage = @"99";
            [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
            return NO;
        }
    }else if ([rurl hasPrefix:@"action"]){
        [self doAction:rurl];
    }
    return YES;
}

- (void)doAction:(NSString *)rurl{
    NSArray *ary = [[rurl componentsSeparatedByString:@"://"][1] componentsSeparatedByString:@"?"];
    if ([ary[0] isEqualToString:@"newIntent"]) {
        NSString *content = [NSString stringWithFormat:@"%@Controller",ary[1]];
        UIViewController *pupVC = [[NSClassFromString(content) alloc]
                                   initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:pupVC];
        
        if ([pupVC respondsToSelector:@selector(initWithFrame:url:title:)]) {
            ((WebUIViewController *)pupVC).delegate = self;
        }else{
            ((SysNotificationController *)pupVC).delegate = self;
        }
        
        [self presentViewController:navVC animated:YES completion:nil];
    }else if ([ary[0] isEqualToString:@"newToast"]){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[Utilitys decodeFromPercentEscapeString:ary[1]]
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
    }else if ([ary[0] isEqualToString:@"showWeb"]){
        NSString *baseurl = [Utilitys decodeFromPercentEscapeString:[rurl componentsSeparatedByString:@"http://"][1]];
        NSString *url = [NSString stringWithFormat:@"http://%@",baseurl];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        LDWebViewController *webVC = [[LDWebViewController alloc] initWithFrame:self.view.frame url:url title:@"网页浏览"];
        if (self.presentedViewController) {
            if ([self.presentedViewController respondsToSelector:@selector(pushViewController:animated:)]) {
                UINavigationController *nav = (UINavigationController *)self.presentedViewController;
                [nav pushViewController:webVC animated:YES];
            }
        }else{
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

@end
