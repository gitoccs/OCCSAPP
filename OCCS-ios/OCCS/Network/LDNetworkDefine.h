
//
//  LDNetworkDefine.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#ifndef OCCS_LDNetworkDefine_h
#define OCCS_LDNetworkDefine_h

/**
 *  网络请求超时的时间
 */
#define NETWORK_TIME_OUT 60


//宏：验证码
#define KEYWORD @"dhccpass"
#define USERID  @""

#define PAGENOT     @"page"
#define LEFT_BAR    @"leftbar"
#define PAGEXQNOT     @"xqpage"

#if NS_BLOCKS_AVAILABLE

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^NWSuccessBlock)(id returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^NWFailureBlock)(NSError *error);
#endif

#endif
