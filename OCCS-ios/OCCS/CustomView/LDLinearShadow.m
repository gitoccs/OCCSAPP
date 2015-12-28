
//
//  LDLinearShadow.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/13.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDLinearShadow.h"

@implementation LDLinearShadow

-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self drawLinearGradient:context];
}



#pragma mark 线性渐变
-(void)drawLinearGradient:(CGContextRef)context
{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12] =
    {
        217.0/255.0,    217.0/255.0,    217.0/255.0,    1.0,
        255.0/255.0,    255.0/255.0,    255.0/255.0,    1.0,
        1.0,            1.0,            1.0,            1.0
    };
    CGFloat locations[3] = {1, 0.3, 0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.bounds.size.width, self.bounds.size.height), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


@end
