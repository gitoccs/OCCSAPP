
//
//  LDDefineUtils.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#ifndef OCCS_LDDefineUtils_h
#define OCCS_LDDefineUtils_h

///导航栏加电池栏高度
#define DEF_NAVIGATION_AND_STATUS_BAR_HEIGHT  64.0
///导航栏高度
#define DEF_NAVIGATION_BAR_HEIGHT  44
///电池栏的高度
#define DEF_STATUS_BAR_HEIGHT  20
///tabbar的高度
#define DEF_TABBAR_HEIGHT  49

#define  DEF_IPHONEOS7Later [[[UIDevice currentDevice] systemVersion]doubleValue] >= 7.0
#define  DEF_IPHONEOS8Later [[[UIDevice currentDevice] systemVersion]doubleValue] >= 8.0
/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define DEF_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define DEF_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width) 
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



/**
 *	获取视图宽度
 *
 *	@param 	view 	视图对象
 *
 *	@return	宽度
 */
#define DEF_WIDTH(view) view.bounds.size.width

/**
 *	获取视图高度
 *
 *	@param 	view 	视图对象
 *
 *	@return	高度
 */
#define DEF_HEIGHT(view) view.bounds.size.height

/**
 *	获取视图原点横坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	原点横坐标
 */
#define DEF_LEFT(view) view.frame.origin.x

/**
 *	获取视图原点纵坐标
 *
 *	@param 	view 	视图对象
 *
 *	@return	原点纵坐标
 */
#define DEF_TOP(view) view.frame.origin.y


#pragma mark -
#pragma mark - Colors Define
/**
 *  RGB 颜色
 */
#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]

/**
 *  RGB 颜色 加透明度
 */
#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

/**
 *  0x 开头的颜色色值
 */
#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

/**
 *  0x 开头的颜色色值 加透明度
 */
#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


#pragma mark -
#pragma mark - 用户配置存储
/**
 *	永久存储对象
 *
 *	@param	object    需存储的对象
 *	@param	key    对应的key
 */
#define DEF_PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

#define DEF_PERSISTENT_REMOVE_OBJECT(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

/**
 *	取出永久存储的对象
 *
 *	@param	key    所需对象对应的key
 *	@return	key所对应的对象
 */
#define DEF_PERSISTENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]


#pragma mark - NSNotificationCenter
#define DEF_NOTIFICATION    [NSNotificationCenter defaultCenter]
#define DEF_SHOWHIDEHUD         @"showHUDOrhideHUD"

#endif
