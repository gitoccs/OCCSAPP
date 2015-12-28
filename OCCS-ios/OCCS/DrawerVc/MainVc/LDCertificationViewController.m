//
//  LDCertificationViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/16.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDCertificationViewController.h"
#import "AppDelegate.h"

@interface LDCertificationViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;
}
@end

@implementation LDCertificationViewController
NSURL * urlHT;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    UIBarButtonItem *rightBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"set" target:self actoin:@selector(rightBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)btn
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MMDrawerController *drawerController = appDelegate.drawerController;
    [drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)leftBarButtonItemClick:(UIBarButtonItem *)sender
{
    if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"2"])
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage1()"];
        [LDClientEngine sharedInstance].whichPage = @"1";
        [[NSNotificationCenter defaultCenter] postNotificationName:PAGENOT object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];
    }
    else if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"3"])
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage2()"];
    }else if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"4"])
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage3()"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LDClientEngine sharedInstance].whichPage = @"1";
//    [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];
    [self uiConfig];
}


- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon Certfication");
    UIBarButtonItem *leftBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"backbtn" target:self actoin:@selector(leftBarButtonItemClick:)];
    int pageNum = [[LDClientEngine sharedInstance].whichPage intValue];
    if (pageNum == 99)
    {
        [self uiConfig];
        self.navigationItem.leftBarButtonItem = nil;
    }
    else if (pageNum > 1)
    {
        self.navigationItem.leftBarButtonItem = leftBar;
    }
}

- (void)changeBackIconHide:(NSNotification *)noti
{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void) uiConfig
{
    NSString *appendStr = [[NSString alloc] initWithFormat:@"?name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                           [Person getInstance].name,
                           [Person getInstance].key,
                           [Person getInstance].mobile,
                           [Person getInstance].typeNumber,
                           [Person getInstance].email];
    appendStr = [appendStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.navigationController.navigationBar.barTintColor = [Person getColor];
    if ([Person getInstance].typeNumber == 1)
    {
        [self titleViewLabelStr:@"岗位认证"];
        urlHT = [NSURL URLWithString:[DEF_PAGE_GWRZ stringByAppendingFormat:@"%@",appendStr]];
    }
    else if ([Person getInstance].typeNumber == 9)
    {
        [self titleViewLabelStr:@"发布需求"];
        urlHT = [NSURL URLWithString:[DEF_PAGE_FBXQ stringByAppendingFormat:@"%@",appendStr]];
    }
    else if ([Person getInstance].typeNumber == 91)
    {
        [self titleViewLabelStr:@"发布需求"];
        urlHT = [NSURL URLWithString:[DEF_PAGE_FBXQ stringByAppendingFormat:@"%@",appendStr]];
    }

    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webview setDataDetectorTypes:UIDataDetectorTypeAll];
    [webview loadRequest:[NSURLRequest requestWithURL:urlHT]];
    webview.delegate = self;
    [self.view addSubview:webview];
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


@end
