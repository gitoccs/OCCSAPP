//
//  PushRouter.h
//  OCCS
//
//  Created by 烨 刘 on 15/12/8.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"

typedef NS_ENUM(NSUInteger, ActionType)
{
    其它,
    个人主页,
    需求市场,
    工单市场,
    岗位应聘,
    需求发布,
    特殊页面,
    模板1,
    推送工单详情,
    推送需求详情,
    个人账户,
    个人信息
};

static NSDictionary *staticUserInfo;
static PushNote *staticNote;

@interface PushRouter : NSObject

+ (ActionType)actionToRouter:(NSString *)action;
+ (void)receiveNoteWhenActive:(NSDictionary *)userInfo;
+ (void)receiveNoteWhenInactive:(NSDictionary *)userInfo;
+ (void)doAfterAction:(PushNote *)note;
+ (void)afterAction;
@end
