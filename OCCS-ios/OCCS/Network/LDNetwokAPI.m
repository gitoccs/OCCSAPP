//
//  LDNetwokAPI.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/3.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "LDNetwokAPI.h"

@implementation LDNetwokAPI

+ (void)verificationCodeByKeyword:(NSString *)keyword
                         phoneNum:(NSString *)phoneNumber
                           userid:(NSString *)userid
                     successBlock:(NWSuccessBlock)successBlock
                     failureBlock:(NWFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:phoneNumber forKey:@"phone"];
    [params setValue:userid forKey:@"userid"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_SEND];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)verificationEmailCodeByKeyword:(NSString *)keyword
                              username:(NSString *)username
                                 email:(NSString *)email
                     successBlock:(NWSuccessBlock)successBlock
                     failureBlock:(NWFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:username forKey:@"username"];
    [params setValue:email forKey:@"email"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_SENDEMAIL];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


+ (void)registerByKeyword:(NSString *)keyword
                 userName:(NSString *)username
                 passWord:(NSString *)password
                 phoneNum:(NSString *)phoneNumber
                  groupid:(NSString *)groupid
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"key"];
    [params setValue:username forKey:@"username"];
    [params setValue:password forKey:@"password"];
    [params setValue:phoneNumber forKey:@"phone"];
    [params setValue:groupid forKey:@"groupid"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_TELREGISTER];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


+ (void)loginByKeyword:(NSString *)keyword
                   key:(NSString *)key
              userName:(NSString *)username
              passWord:(NSString *)password
          successBlock:(NWSuccessBlock)successBlock
          failureBlock:(NWFailureBlock)failureBlock
               showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:key forKey:@"key"];
    [params setValue:username forKey:@"username"];
    [params setValue:password forKey:@"password"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_TELLOGIN];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


+ (void)backPhoneNumByKeyword:(NSString *)keyword
                     userName:(NSString *)username
                 successBlock:(NWSuccessBlock)successBlock
                 failureBlock:(NWFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:username forKey:@"username"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_SENDPHONE];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:showHUD
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)ValidateByKeyword:(NSString *)keyword
             phoneOrEmail:(NSString *)phoneOrEmail
                     code:(NSString *)code
                   userid:(NSString *)userid
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD;
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:phoneOrEmail forKey:@"phoneOrEmail"];
    [params setValue:code forKey:@"code"];
    [params setValue:userid forKey:@"userid"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_VALIFATE];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


+ (void)changePasswordByKeyword:(NSString *)keyword
                       userName:(NSString *)username
                       passWord:(NSString *)password
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:username forKey:@"username"];
    [params setValue:password forKey:@"password"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_UPDATEPASSWORD];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


+ (void)GetUserInfoByKeyword:(NSString *)keyword
                       userName:(NSString *)username
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:username forKey:@"username"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_GETUSERINFO];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)UploadUserAvatarByKeyword:(NSString *)keyword
                         userName:(NSString *)username
                          imgInfo:(NSString *)imgInfo
                          imgName:(NSString *)imgName
                successBlock:(NWSuccessBlock)successBlock
                failureBlock:(NWFailureBlock)failureBlock
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:username forKey:@"username"];
    [params setValue:imgInfo forKey:@"imgInfo"];
    [params setValue:imgName forKey:@"imgName"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_UPLOADAVATAR];
    [[LDNetworkHandler sharedInstance] conPOSTURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)UploadUserInfoByKeyword:(NSString *)keyword
                            key:(NSString *)key
                          jsonData:(NSString *)jsonData
                     successBlock:(NWSuccessBlock)successBlock
                     failureBlock:(NWFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:key forKey:@"key"];
    [params setValue:jsonData forKey:@"jsonData"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_UPDATEUSERINFO];
    [[LDNetworkHandler sharedInstance] conURL:url
                                           params:params
                                          showHUD:YES
                                     successBlock:successBlock
                                     failureBlock:failureBlock];
}

+ (void)checkPasswordByKeyword:(NSString *)keyword
                            password:(NSString *)password
                       username:(NSString *)username
                   successBlock:(NWSuccessBlock)successBlock
                   failureBlock:(NWFailureBlock)failureBlock
                        showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:password forKey:@"password"];
    [params setValue:username forKey:@"username"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_CHECKPASSWORD];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)GetGongdanInfoByKeyword:(NSString *)keyword
                    key:(NSString *)key
                successBlock:(NWSuccessBlock)successBlock
                failureBlock:(NWFailureBlock)failureBlock
                     showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:key forKey:@"key"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_GETGONGDANINFO];
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)loginOutByKeyword:(NSString *)keyword
                 key:(NSString *)key
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:key forKey:@"key"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_LOGINOUT];
    
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)getAppVersion:(NSString *)keyword
             successBlock:(NWSuccessBlock)successBlock
             failureBlock:(NWFailureBlock)failureBlock
                  showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_GETVERSION];
    
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)getAppMessage:(NSString *)keyword
                msgId:(NSString *)msgId
         successBlock:(NWSuccessBlock)successBlock
         failureBlock:(NWFailureBlock)failureBlock
              showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:msgId forKey:@"MsgId"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_GETAPPMESSAGE];
    
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}

+ (void)getProjectDetail:(NSString *)keyword
                workid:(NSString *)workid
         successBlock:(NWSuccessBlock)successBlock
         failureBlock:(NWFailureBlock)failureBlock
              showHUD:(BOOL)showHUD
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:keyword forKey:@"keyword"];
    [params setValue:workid forKey:@"workid"];
    [params setValue:@"1" forKey:@"ispublic"];
    NSString *url = [BASE_URL stringByAppendingString:NET_ACTION_PROJECTDETAIL];
    
    [[LDNetworkHandler sharedInstance] conURL:url
                                       params:params
                                      showHUD:YES
                                 successBlock:successBlock
                                 failureBlock:failureBlock];
}


@end
