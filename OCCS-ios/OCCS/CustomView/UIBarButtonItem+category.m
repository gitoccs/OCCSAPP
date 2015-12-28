//
//  UIBarButtonItem+category.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "UIBarButtonItem+category.h"

@implementation UIBarButtonItem (category)

+ (UIBarButtonItem *) barButtonItemWithTitle:(NSString *)title
             barButtonItemWithBarButtonImage:(NSString *)NormalImage
                                      target:(id)target
                                      actoin:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 5, 50, 30)];
    UIImage *normalIcon = [UIImage imageNamed:NormalImage];
    [button setBackgroundImage:normalIcon forState:UIControlStateNormal];
    [button setBackgroundImage:normalIcon forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = title;
    [button addSubview:label];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



+ (UIBarButtonItem *) barButtonItemWithtarget:(id)target
                                       actoin:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 20 , 20)];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *) barButtonItemWithBarButtonImage:(NSString *)NormalImage
                                               target:(id)target
                                               actoin:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalIcon = [UIImage imageNamed:NormalImage];
    [button setFrame:CGRectMake(35, 0, 25 , 25)];
    [button setBackgroundImage:normalIcon forState:UIControlStateNormal];
    [button setBackgroundImage:normalIcon forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
