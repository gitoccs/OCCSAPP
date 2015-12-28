//
//  LDNetworkState.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

 
#define NETWORK_NO      0  //无网络
#define NETWORK_WIFI    1  //WiFi网络
#define NETWORK_WWAN    2  //移动网络
#define NETWORK_2G      3  //2G网络
#define NETWORK_3G      4  //3G网络
#define NETWORK_NOT     5  //不知类型的网络


@interface LDNetworkState : NSObject

/**
 检查网络状态
 */
+ (BOOL)connectedToNetwork;

/**
 检查wifi是否可用
 */
+ (BOOL)isEnableWiFi;

/**
 检查当前使用的网络类型
 */
+ (NSInteger)currentNetworkType;




@end

