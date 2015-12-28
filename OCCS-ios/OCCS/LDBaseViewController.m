//
//  LDBaseViewController.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDBaseViewController ()

@end

@implementation LDBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    // iOS7顶部屏幕适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taphidden:)];
    [self.view addGestureRecognizer:tap];
}

///取消键盘事件
- (void)taphidden:(UIGestureRecognizer *)ges
{
    [ges.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
