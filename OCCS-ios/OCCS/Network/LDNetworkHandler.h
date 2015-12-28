//
//  LDNetworkHandler.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDNetworkHandler : NSObject

/**
 *  单例
 *
 *  @return LDNetworkHandler的单例对象
 */
+ (LDNetworkHandler *) sharedInstance;

/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 
 */
- (void)conURL:(NSString *) url
              params:(NSMutableDictionary *) params
             showHUD:(BOOL) showHUD
        successBlock:(NWSuccessBlock) successBlock
        failureBlock:(NWFailureBlock) failureBlock;

- (void)conPOSTURL:(NSString *) url
            params:(NSMutableDictionary *) params
           showHUD:(BOOL) showHUD
      successBlock:(NWSuccessBlock) successBlock
      failureBlock:(NWFailureBlock) failureBlock;
@end
