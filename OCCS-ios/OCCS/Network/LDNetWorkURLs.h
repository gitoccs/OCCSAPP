//
//  LDNetWorkURLs.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/2.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#ifndef OCCS_LDNetWorkURLs_h
#define OCCS_LDNetWorkURLs_h

/**生产环境地址*/
//http://api.occs.com.cn/MobileAPI.asmx
//http://api.test.occs.com.cn/MobileAPI.asmx/

//APP链接地址
#define ITUNCELINK          @"https://itunes.apple.com/us/app/occs-ruan-jian-yun-gong-chang/id1024446939?l=zh&ls=1&mt=8"


//生产环境 page页面的
#define BASE_ACTION         @"http://api.test.occs.com.cn/"

#define BASE_URL            [BASE_ACTION stringByAppendingString:@"MobileAPI.asmx/"]
/**
 网络请求Action常量
 **/
///发送验证码
#define NET_ACTION_SEND                 @"Send"
//发送验证码到邮箱
#define NET_ACTION_SENDEMAIL            @"SendEmailcode"
///注册
#define NET_ACTION_TELREGISTER          @"TelRegister"
///登录
#define NET_ACTION_TELLOGIN             @"TelLogin"
///返回电话号码
#define NET_ACTION_SENDPHONE            @"Sendphone"
///公共验证验证码接口
#define NET_ACTION_VALIFATE             @"Validate"
///修改密码
#define NET_ACTION_UPDATEPASSWORD       @"UpdatePassword"
//退出登陆
#define NET_ACTION_LOGINOUT             @"TelLogout"
//上传头像
#define NET_ACTION_UPLOADAVATAR         @"uploadAvatar"
//得到个人信息
#define NET_ACTION_GETUSERINFO          @"GetUserInfo"
//上传个人信息
#define NET_ACTION_UPDATEUSERINFO       @"UpdateUserInfo"
//得到个人工单信息
#define NET_ACTION_GETGONGDANINFO       @"GetAllWorkCount"
//验证密码
#define NET_ACTION_CHECKPASSWORD        @"Verifypassword"
//软件Version
#define NET_ACTION_GETVERSION           @"GetVersion"
//获取企业信息
#define NET_ACTION_GETCORPERATION       @"GetCorperation"
//获取通知信息
#define NET_ACTION_GETAPPMESSAGE        @"GetAppMessage"
//获取工单信息
#define NET_ACTION_PROJECTDETAIL        @"GetProjectDetailsForV1"



////////////////////////////////////////////

///网络请求的ACTION
#define DEF_PAGE_XQ                 [BASE_ACTION stringByAppendingString:@"demand.html"]
#define DEF_PAGE_GD                 [BASE_ACTION stringByAppendingString:@"gongdan.html"]
#define DEF_PAGE_FBXQ               [BASE_ACTION stringByAppendingString:@"sendDemand.html"]
#define DEF_PAGE_GWRZ               [BASE_ACTION stringByAppendingString:@"job.html"]
#define DEF_PAGE_AD                 [BASE_ACTION stringByAppendingString:@"adv.html"]
#define DEF_PAGE_ACCOUNT            [BASE_ACTION stringByAppendingString:@"myAccount.html"]
#define DEF_PAGE_PERSONMAIN         [BASE_ACTION stringByAppendingString:@"personMain.html"]
#define DEF_PAGE_SYSNOTIFY          [BASE_ACTION stringByAppendingString:@"sysNotification.html"]
#define DEF_PAGE_ABOUT              [BASE_ACTION stringByAppendingString:@"aboutOccs.html"]
#define DEF_PAGE_ACTIVITY           [BASE_ACTION stringByAppendingString:@"activity.html"]
#define DEF_PAGE_SERVICE            [BASE_ACTION stringByAppendingString:@"contactService.html"]
#define DEF_PAGE_HELP               [BASE_ACTION stringByAppendingString:@"HelpIndex.html"]
#define DEF_PAGE_TEMPLATE1          [BASE_ACTION stringByAppendingString:@"noteTemplate01.html"]
#define DEF_PAGE_SINGLEGONGDAN      [BASE_ACTION stringByAppendingString:@"singleSuitableGongdan.html"]


#endif
