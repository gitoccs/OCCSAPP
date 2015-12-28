
//
//  AgreementViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/28.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = BLUECOLOR;
    [self titleViewLabelStr:@"《OCCS注册协议》"];
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithBarButtonImage:@"backwhite" target:self actoin:@selector(backVc)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.webViewAgree.editable = NO;

    //    通过指定的路径读取文本内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"rtf"];
    NSString *textFileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.webViewAgree.text = textFileContents;
}

- (void)backVc
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  设置导航栏上面的title
 *
 *  @param str 根据传过来的str
 */
- (void)titleViewLabelStr:(NSString *)str
{
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 250, 40)];
    titleView.text = str;
    titleView.center = CGPointMake(DEF_SCREEN_WIDTH - 250 - 64, 40);
    [titleView setTextColor:[UIColor whiteColor]];
    titleView.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:18];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleView;
}

@end
