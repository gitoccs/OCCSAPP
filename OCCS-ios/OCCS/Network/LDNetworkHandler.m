
//
//  LDNetworkHandler.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDNetworkHandler.h"

@implementation LDNetworkHandler

+ (LDNetworkHandler *) sharedInstance
{
    static LDNetworkHandler * handler = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        handler = [[LDNetworkHandler alloc] init];
    });
    
    return handler;
}

- (void)conURL:(NSString *) url
              params:(NSMutableDictionary *) params
             showHUD:(BOOL) showHUD
        successBlock:(NWSuccessBlock) successBlock
        failureBlock:(NWFailureBlock) failureBlock
{
    showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"show"] : nil;
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"url is :%@     params is:%@",url,params);
    
    [manage GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"url load successed");
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];

        showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"hide"] : nil;
        
        if (successBlock)
        {
            successBlock(requestTmp);
        }
    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"url load failed %@",error);
            if (failureBlock)
            {
                showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"hide"] : nil;
                failureBlock([AFURLConnectionOperation new].error);
            }
        }];
}

- (void)conPOSTURL:(NSString *) url
        params:(NSMutableDictionary *) params
       showHUD:(BOOL) showHUD
  successBlock:(NWSuccessBlock) successBlock
  failureBlock:(NWFailureBlock) failureBlock
{
    showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"show"] : nil;
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"url load successed");
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"hide"] : nil;
        
        if (successBlock)
        {
            successBlock(requestTmp);
        }
    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"url load failed %@",error);
            if (failureBlock)
            {
                showHUD ? [DEF_NOTIFICATION postNotificationName:DEF_SHOWHIDEHUD object:@"hide"] : nil;
                failureBlock([AFURLConnectionOperation new].error);
            }
        }];
}



@end
