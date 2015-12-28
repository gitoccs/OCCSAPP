//
//  NoteTableController.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/9.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysNoteProtocol.h"

@interface SysNotificationController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic,weak) id<NotificationDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)dismissSelf:(UIBarButtonItem *)btn;

@end