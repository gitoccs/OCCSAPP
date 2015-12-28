//
//  UIBarButtonItem+category.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (category)

/**
 *  深度定制UIBarButtonItem
 *
 *  @param title       UIBarButtonItem上的文本
 *  @param NormalImage 正常显示的图标
 *  @param target      响应者
 *  @param action      触发事件
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *) barButtonItemWithTitle:(NSString *)title
             barButtonItemWithBarButtonImage:(NSString *)NormalImage
                                      target:(id)target
                                      actoin:(SEL)action;


+ (UIBarButtonItem *) barButtonItemWithtarget:(id)target
                                       actoin:(SEL)action;

//UIBarButtonItem  定制图标
+ (UIBarButtonItem *) barButtonItemWithBarButtonImage:(NSString *)NormalImage
                                               target:(id)target
                                               actoin:(SEL)action;

@end
