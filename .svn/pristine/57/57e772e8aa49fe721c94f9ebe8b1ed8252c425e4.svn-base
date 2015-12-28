//
//  LDClientEngine.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/7.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDClientEngine : NSObject

///个人用户
#define BLUECOLOR  UIColorFromRGB(0x0077D8)
///企业用户
#define ORANGECOLOR  UIColorFromRGB(0xE87A49)
///软件企业用户
#define GREENCOLOR UIColorFromRGB(0x06BAA8)

/**
 *  单例
 *
 *  @return LDClientEngine的单例对象
 */
+ (LDClientEngine *) sharedInstance;

//登录时候的随机数key
@property(nonatomic ,strong) NSString *loginKeyStr;
///用户名
@property(nonatomic ,strong) NSString *appuserName;
///用户类型
@property(nonatomic ,strong) NSString *appuserType;
///哪一个page
@property (nonatomic ,strong) NSString *whichPage;

@end
