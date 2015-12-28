//
//  LDNetwokAPI.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDNetwokAPI : NSObject

#pragma mark - 手机号码获取验证码
/**
 *  注册获取手机验证码
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)verificationCodeByKeyword:(NSString *)keyword
                         phoneNum:(NSString *)phoneNumber
                           userid:(NSString *)userid
                     successBlock:(NWSuccessBlock)successBlock
                     failureBlock:(NWFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD;

//Email获取验证码
+ (void)verificationEmailCodeByKeyword:(NSString *)keyword
                              username:(NSString *)username
                                 email:(NSString *)email
                          successBlock:(NWSuccessBlock)successBlock
                          failureBlock:(NWFailureBlock)failureBlock
                               showHUD:(BOOL)showHUD;

/**
 *  注册
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)registerByKeyword:(NSString *)keyword
                 userName:(NSString *)username
                 passWord:(NSString *)password
                 phoneNum:(NSString *)phoneNumber
                  groupid:(NSString *)groupid
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD;

/**
 *  登录
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)loginByKeyword:(NSString *)keyword
                   key:(NSString *)key
              userName:(NSString *)username
              passWord:(NSString *)password
          successBlock:(NWSuccessBlock)successBlock
          failureBlock:(NWFailureBlock)failureBlock
               showHUD:(BOOL)showHUD;

/**
 *  返回电话号码
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)backPhoneNumByKeyword:(NSString *)keyword
                     userName:(NSString *)username
                 successBlock:(NWSuccessBlock)successBlock
                 failureBlock:(NWFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD;

/**
 *  公共验证验证码接口
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)ValidateByKeyword:(NSString *)keyword
                 phoneOrEmail:(NSString *)phoneOrEmail
                         code:(NSString *)code
                       userid:(NSString *)userid
                 successBlock:(NWSuccessBlock)successBlock
                 failureBlock:(NWFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD;

/**
 *  修改密码
 *
 *  @param keyword      key
 *  @param phone member 手机号码
 *  @param userid
 */
+ (void)changePasswordByKeyword:(NSString *)keyword
                       userName:(NSString *)username
                       passWord:(NSString *)password
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD;



/**
 *  个人信息包括头像
 */
+ (void)GetUserInfoByKeyword:(NSString *)keyword
                       userName:(NSString *)username
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD;
//上传个人信息
+ (void)UploadUserInfoByKeyword:(NSString *)keyword
                            key:(NSString *)key
                       jsonData:(NSString *)jsonData
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD;
//上传头像
+ (void)UploadUserAvatarByKeyword:(NSString *)keyword
                         userName:(NSString *)username
                          imgInfo:(NSString *)imgInfo
                          imgName:(NSString *)imgName
                     successBlock:(NWSuccessBlock)successBlock
                     failureBlock:(NWFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD;
//工单信息
+ (void)GetGongdanInfoByKeyword:(NSString *)keyword
                            key:(NSString *)key
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD;
//校验密码
+ (void)checkPasswordByKeyword:(NSString *)keyword
                      password:(NSString *)password
                      username:(NSString *)username
                  successBlock:(NWSuccessBlock)successBlock
                  failureBlock:(NWFailureBlock)failureBlock
                       showHUD:(BOOL)showHUD;

///退出
+ (void)loginOutByKeyword:(NSString *)keyword
                 key:(NSString *)key
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD;
///得到软件版本信息
+ (void)getAppVersion:(NSString *)keyword
         successBlock:(NWSuccessBlock)successBlock
         failureBlock:(NWFailureBlock)failureBlock
              showHUD:(BOOL)showHUD;

///得到通知信息
+ (void)getAppMessage:(NSString *)keyword
                msgId:(NSString *)msgId
         successBlock:(NWSuccessBlock)successBlock
         failureBlock:(NWFailureBlock)failureBlock
              showHUD:(BOOL)showHUD;

///获得工单细节信息
+ (void)getProjectDetail:(NSString *)keyword
                  workid:(NSString *)workid
            successBlock:(NWSuccessBlock)successBlock
            failureBlock:(NWFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD;
@end


