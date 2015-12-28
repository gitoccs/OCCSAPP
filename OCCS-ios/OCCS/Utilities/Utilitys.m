//
//  Utilitys.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "Utilitys.h"
#import "GDataXMLNode.h"

@implementation Utilitys

static bool okToLogin;
//做ios版本之间的适配
//不同的ios版本,调用不同的方法,实现相同的功能
+(CGSize)sizeOfStr:(NSString *)str
           andFont:(UIFont *)font
        andMaxSize:(CGSize)size
  andLineBreakMode:(NSLineBreakMode)mode
{
    CGSize s;
    if (DEF_IPHONEOS7Later)
    {
        NSDictionary *dic = @{NSFontAttributeName:font};
        s = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic context:nil].size;
    }
    else
    {
        s = [str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return s;
}

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

+ (void)setOkToLogin:(BOOL)flag{
    okToLogin = flag;
}

+ (BOOL)getOkToLogin{
    return okToLogin;
}


#pragma mark -
#pragma mark - 弹出一个对话框提示
+ (void)showAlertWithMsg:(NSString *)message andTitle:(NSString *)title andVc:(UIViewController*)selfVc
{
    NSString *cancelButtonTitle = @"确定";
    
    if (DEF_IPHONEOS8Later)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [selfVc presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
        [alert show];
    }
}


///验证码倒计时
+ (void)verificationCode:(void(^)())blockYes blockNo:(void(^)(id time))blockNo
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                blockYes();
            });
        }
        else
        {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"倒计时：%@",strTime);
                blockNo(strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

//广告也倒计时
+ (void)adPage:(void(^)())blockYes blockNo:(void(^)(id time))blockNo
{
    __block int timeout = 3; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                blockYes();
            });
        }
        else
        {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"%@",strTime);
                blockNo(strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


///验证字符串是否为空
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

///验证验证码是否正确
+ (void) validateCodeData:(NSString *)code
                  media:(NSString *)media
                  success:(void (^)(int status,id message))successBlock fail:(void (^)())failBlock
{
    [LDNetwokAPI ValidateByKeyword:KEYWORD phoneOrEmail:media
                              code:code
                            userid:@""
                      successBlock:^(id returnData) {
                          
                          NSString* status;
                          NSString* msg;
                          NSLog(@"returnData=%@",returnData);
                          
                          if (returnData != nil)
                          {
                              GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                              NSArray *results = [doc nodesForXPath:@"//results" error:nil];
                              // 循环遍历每一个<results.../>元素
                              for(GDataXMLElement *resultElement in results)
                              {
                                  //获取需求名称元素
                                  status = [[[resultElement elementsForName:@"status"] objectAtIndex:0] stringValue];
                                  msg = [[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue];
                              }
                          }
                          
                          successBlock([status intValue],msg);
                          
                      } failureBlock:^(NSError *error) {
                          failBlock();
                      } showHUD:YES];
}

+ (void)getVerifyCode:(UIButton *)btn mobile:(NSString *)mobile
              success:(void (^)(int status, id message))successBlock fail:(void (^)())failBlock{
    [LDNetwokAPI verificationCodeByKeyword:KEYWORD phoneNum:mobile userid:USERID
                              successBlock:^(id returnData) {
                                  NSArray<NSString *> *ary = [Utilitys getRequestStatus:returnData button:btn];
                                  successBlock([ary[0] intValue], ary[1]);
    } failureBlock:^(NSError *error) {
        
        failBlock();
        
    } showHUD:YES];
    
}

+ (void)getEmailVerifyCode:(UIButton *)btn email:(NSString *)email
              success:(void (^)(int status, id message))successBlock fail:(void (^)())failBlock{
    [LDNetwokAPI verificationEmailCodeByKeyword:KEYWORD username:[Person getInstance].name
                                          email:email
                                   successBlock:^(id returnData) {
                                              NSArray<NSString *> *ary = [Utilitys getRequestStatus:returnData button:btn];
                                              successBlock([ary[0] intValue], ary[1]);
        
    } failureBlock:^(NSError *error) {
        
        failBlock();
        
    } showHUD:YES];
    
}

+ (NSArray<NSString *>*)getRequestStatus:(id)returnData button:(UIButton *)btn{
    NSString* status;
    NSString* msg;
    NSLog(@"returnData=%@",returnData);
    UIColor *color = btn.backgroundColor;
    
    if (returnData != nil)
    {
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
        NSArray *results = [doc nodesForXPath:@"//results" error:nil];
        // 循环遍历每一个<results.../>元素
        for(GDataXMLElement *resultElement in results)
        {
            //获取需求名称元素
            status = [[[resultElement elementsForName:@"status"] objectAtIndex:0] stringValue];
            msg = [[[resultElement elementsForName:@"msg"] objectAtIndex:0] stringValue];
        }
    }
    
    if (status.intValue == 1)
    {
        btn.backgroundColor = [UIColor lightGrayColor];
        ///验证码倒计时
        [Utilitys verificationCode:^{
            
            [btn setTitle:@"获取验证码" forState:0];
            [btn setTitle:@"获取验证码" forState:1];
            [btn setEnabled:YES];
            btn.backgroundColor = color;
            
        } blockNo:^(id time) {
            
            [btn setTitle:[NSString stringWithFormat:@"%@秒后重发",time] forState:0];
            [btn setTitle:[NSString stringWithFormat:@"%@秒后重发",time] forState:1];
            [btn setEnabled:NO];
            
        }];
    }
    return @[status,msg];
}

+ (NSDate *)stringToDate:(NSString *)dateStr format:(NSString *)formatStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    return [dateFormatter dateFromString:dateStr];
}

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter stringFromDate:date];
}

+ (UIColor *)cellBackColor{
    return [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
}

+ (NSString*) decodeFromPercentEscapeString:(NSString *) string {
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) string,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8);
}


@end
