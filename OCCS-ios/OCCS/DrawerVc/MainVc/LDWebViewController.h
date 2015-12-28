//
//  LDWebViewController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/4.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebUIViewController.h"

@interface LDWebViewController : WebUIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *urlStr;

- (instancetype)initWithFrame:(CGRect)frame url:(NSString *)url title:(NSString *)title;

@end


