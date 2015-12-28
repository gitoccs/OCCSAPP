//
//  MMCenterViewController.m
//  MusicKingdom
//
//  Created by Gennie Sun on 14-9-12.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import "MMCenterViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "LDSearchViewController.h"
#import "AppDelegate.h"

@interface MMCenterViewController ()<UIWebViewDelegate>
{
    UIWebView *webview;
}

@end

@implementation MMCenterViewController
NSURL * url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [LDClientEngine sharedInstance].whichPage = @"1";
//    [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];

    [self uiConfig];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    webview.dataDetectorTypes = UIDataDetectorTypeNone;
    UIBarButtonItem *rightBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"set" target:self actoin:@selector(rightBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;
}


- (void)leftBarButtonItemClick:(UIBarButtonItem *)sender
{
    if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"2"])
    {
        [webview stringByEvaluatingJavaScriptFromString:@"setpage1()"];
        [LDClientEngine sharedInstance].whichPage = @"1";
        [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];
    }
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


- (void)rightBarButtonItemClick:(UIBarButtonItem *)btn
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MMDrawerController *drawerController = appDelegate.drawerController;
    [drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon MMCenter");
    UIBarButtonItem *leftBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"backbtn" target:self actoin:@selector(leftBarButtonItemClick:)];
    int pageNum = [[LDClientEngine sharedInstance].whichPage intValue];
    if (pageNum>1 && pageNum != 99)
    {
        NSLog(@"set backbtn");
        self.navigationItem.leftBarButtonItem = leftBar;
    }
}

- (void)changeBackIconHide:(NSNotification *)noti
{
    self.navigationItem.leftBarButtonItem = nil;
}


/**
 *  页面布局
 */
- (void)uiConfig
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
        [self titleViewLabelStr:@"工单市场"];
        url = [NSURL URLWithString:[DEF_PAGE_GD stringByAppendingFormat:@"%@",appendStr]];
    }
    else if ([Person getInstance].typeNumber == 9)
    {
        [self titleViewLabelStr:@"需求市场"];
        url = [NSURL URLWithString:[DEF_PAGE_XQ stringByAppendingFormat:@"%@",appendStr]];
    }
    else if ([Person getInstance].typeNumber == 91)
    {
        [self titleViewLabelStr:@"需求市场"];
        url = [NSURL URLWithString:[DEF_PAGE_XQ stringByAppendingFormat:@"%@",appendStr]];
    }
    
    NSLog(@"%s    %@",__FUNCTION__,[NSURL URLWithString:[DEF_PAGE_GD stringByAppendingFormat:@"%@",appendStr]]);

    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webview setDataDetectorTypes:UIDataDetectorTypeAll];
    webview.delegate  = self;
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
