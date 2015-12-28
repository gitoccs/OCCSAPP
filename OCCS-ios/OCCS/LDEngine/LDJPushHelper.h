//
//  LDJPushHelper.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/9.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

///极光推送相关API封装
@interface LDJPushHelper : NSObject

// 在应用启动的时候调用
+ (void)setupWithOptions:(NSDictionary *)launchOptions;

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification;

@end
