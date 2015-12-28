//
//  LDWebViewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "LDWebViewController.h"

@interface LDWebViewController ()

@end

@implementation LDWebViewController

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url title:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
        _urlStr = url;
        self.view.frame = frame;
    }
    return self;
}

- (void)setUrlStr:(NSString *)urlStr{
    if (![_urlStr isEqualToString:urlStr]) {
        _urlStr = urlStr;
        NSURL *url =[NSURL URLWithString:urlStr];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)changeBackIcon:(NSNotification *)noti
{
    NSLog(@"changeBackIcon LDwebviewcontroller");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(dismissSelf:)];
}

- (void)changeBackIconHide:(NSNotification *)noti
{
    NSLog(@"hidden LDwebviewcontroller");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissSelf:)];
}

- (void)goPreviousVC{
    NSLog(@"goPreviousVC");
    int num = [[LDClientEngine sharedInstance].whichPage intValue];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setpage%d()",--num]];
    [LDClientEngine sharedInstance].whichPage = [NSString stringWithFormat:@"%d",num];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    NSURL *url =[NSURL URLWithString:self.urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissSelf:)];

    // Do any additional setup after loading the view.
}

- (void)doAction:(NSString *)rurl
{
    [super doAction:rurl];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
