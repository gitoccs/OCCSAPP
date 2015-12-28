//
//  NSString+extended.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/3.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "NSString+extended.h"

@implementation NSString(extended)

- (BOOL)isBlank
{
    if (self == nil || self == NULL)
    {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

@end
