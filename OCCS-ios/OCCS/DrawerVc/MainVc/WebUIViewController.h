//
//  WebUIViewController.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/25.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysNotificationController.h"

@interface WebUIViewController : UIViewController<UIWebViewDelegate, NotificationDelegate>

@property (nonatomic, weak) id<NotificationDelegate>delegate;

- (void)changeBackIcon:(NSNotification *)noti;
- (void)changeBackIconHide:(NSNotification *)noti;
- (void)dismissSelf:(UIBarButtonItem *)button;
- (void)dismissSelfVC;
- (void)goPreviousVC;
- (void)doAction:(NSString *)rurl;

@end


