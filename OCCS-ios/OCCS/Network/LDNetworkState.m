
//
//  LDNetworkState.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDNetworkState.h"
#include <netdb.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@implementation LDNetworkState

+ (BOOL)connectedToNetwork {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


+ (BOOL)isEnableWiFi {
    NetworkStatus netWorkStatus = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    
    if (netWorkStatus == ReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSInteger)currentNetworkType {
    NetworkStatus netWorkStatus = [[Reachability reachabilityWithHostName:@"http://interface.91smxz.com"] currentReachabilityStatus];
    
    switch (netWorkStatus) {
        case NotReachable:
            return NETWORK_NO;
            break;
        case ReachableViaWiFi:
            return NETWORK_WIFI;
            break;
        case ReachableViaWWAN:
            return NETWORK_WWAN;
            break;
        case ReachableVia2G:
            return NETWORK_2G;
            break;
        case ReachableVia3G:
            return NETWORK_3G;
            break;
        default:
            return NETWORK_NOT;
            break;
    }
}


@end
