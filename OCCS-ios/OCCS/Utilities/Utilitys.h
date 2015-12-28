//
//  Utilitys.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilitys : NSObject

///不同的ios版本,调用不同的方法,实现相同的功能

+(CGSize)sizeOfStr:(NSString *)str
           andFont:(UIFont *)font
        andMaxSize:(CGSize)size
  andLineBreakMode:(NSLineBreakMode)mode;


+ (void)showAlertWithMsg:(NSString *)message andTitle:(NSString *)title andVc:(UIViewController*)selfVc;
+ (void)verificationCode:(void(^)())blockYes blockNo:(void(^)(id time))blockNo;
+ (void)adPage:(void(^)())blockYes blockNo:(void(^)(id time))blockNo;

+ (BOOL) isBlankString:(NSString *)string;
+ (void)getVerifyCode:(UIButton *)btn mobile:(NSString *)mobile
              success:(void (^)(int status, id message))successBlock fail:(void (^)())failBlock;
+ (void)getEmailVerifyCode:(UIButton *)btn email:(NSString *)email
                   success:(void (^)(int status, id message))successBlock fail:(void (^)())failBlock;
+ (void) validateCodeData:(NSString *)code
                    media:(NSString *)media
                  success:(void (^)(int status,id message))successBlock fail:(void (^)())failBlock;
+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;

+ (void)setOkToLogin:(BOOL)flag;
+ (BOOL)getOkToLogin;
+ (NSDate *)stringToDate:(NSString *)dateStr format:(NSString *)formatStr;
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)formatStr;
+ (UIColor *)cellBackColor;
+ (NSString*) decodeFromPercentEscapeString:(NSString *) string;


@end
