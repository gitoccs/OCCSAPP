//
//  LDClientEngine.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/7.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDClientEngine.h"

@implementation LDClientEngine

+ (LDClientEngine *) sharedInstance
{
    static LDClientEngine * handler = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        handler = [[LDClientEngine alloc] init];
    });
    
    return handler;
}
@end
