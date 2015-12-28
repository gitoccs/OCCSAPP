//
//  LDMyMessageViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/16.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDMyMessageViewController.h"
#import <WebKit/WebKit.h>
#import "DatabaseHelper.h"
#import "PushNote.h"
#import "Gongdan.h"
#import "AppDelegate.h"

@interface LDMyMessageViewController ()<UIWebViewDelegate>
{
    UIWebView *webview_X;
}
@end

@implementation LDMyMessageViewController
NSURL * urlHO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [Person getColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteReflesh:) name:@"sysNoteReceiver" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteReflesh:) name:@"sysGongdanReceiver" object:nil];
    
    UIBarButtonItem *rightBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"set" target:self actoin:@selector(rightBarButtonItemClick:)];
    
    self.navigationItem.rightBarButtonItem = rightBar;
    webview_X = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
}

- (void)noteReflesh:(NSNotification *)notification
{
    [self uiConfig];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LDClientEngine sharedInstance].whichPage = @"1";
    [self uiConfig];
}

- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon myMessage");
    UIBarButtonItem *leftBar = [UIBarButtonItem barButtonItemWithBarButtonImage:@"backbtn" target:self actoin:@selector(leftBarButtonItemClick:)];
    
    int pageNum = [[LDClientEngine sharedInstance].whichPage intValue];
    if (pageNum>1 && pageNum != 99)
    {
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
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    titleView.text = @"我的消息";
    [titleView setTextColor:[UIColor whiteColor]];
    titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleView;
    NSArray *noteAry = [DatabaseHelper getAllNotes];
    long noteCount = 0;
    NSString *noteStringFromDate = @"";
    NSString *noteMessage = @"";
    if (noteAry.count > 0) {
        PushNote *lastNote = noteAry[0];
        for (PushNote *n in noteAry) {
            if (![n.is_seen boolValue]) {
                noteCount ++;
            }
        }
        noteStringFromDate = [Utilitys dateToString:lastNote.time format:@"yyyy年MMMdd日"];
        noteMessage = [NSString stringWithFormat:@"%@",lastNote.message];
    }
    
    NSArray *gongdanAry = [DatabaseHelper getAllGongdan];
    long gongdanCount = 0;
    NSString *gongdanStringFromDate = @"";
    NSString *gongdanTitle = @"";
    if (gongdanAry.count > 0) {
        Gongdan *lastGongdan = gongdanAry[0];
        for (Gongdan *g in gongdanAry) {
            if (![g.is_seen boolValue]) {
                gongdanCount ++;
            }
        }
        gongdanStringFromDate = [Utilitys dateToString:lastGongdan.time format:@"yyyy年MMMdd日"];
        gongdanTitle = [NSString stringWithFormat:@"%@",lastGongdan.title];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = noteCount;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&note_msg=%@&note_date=%@&note_unseen=%ld&note_count=%ld&gd_title=%@&gd_date=%@&gd_unseen=%ld&gd_count=%ld",
                              DEF_PAGE_PERSONMAIN, appendStr,
                        noteMessage,
                        noteStringFromDate,
                        noteCount,
                        (unsigned long)noteAry.count,
                        gongdanTitle,
                        gongdanStringFromDate,
                        gongdanCount,
                        (unsigned long)gongdanAry.count
                        ];
    NSString* webStringURL = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlHO = [NSURL URLWithString:webStringURL];
    
    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webview_X setDataDetectorTypes:UIDataDetectorTypeAll];
    [webview_X loadRequest:[NSURLRequest requestWithURL:urlHO]];
    webview_X.delegate = self;
    [self.view addSubview:webview_X];
}


- (void)leftBarButtonItemClick:(UIBarButtonItem *)sender
{
    if ([[LDClientEngine sharedInstance].whichPage isEqualToString:@"2"])
    {
        [webview_X stringByEvaluatingJavaScriptFromString:@"setpage1()"];
        [LDClientEngine sharedInstance].whichPage = @"1";
        [[NSNotificationCenter defaultCenter] postNotificationName:LEFT_BAR object:nil];
    }
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)btn
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MMDrawerController *drawerController = appDelegate.drawerController;
    [drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
