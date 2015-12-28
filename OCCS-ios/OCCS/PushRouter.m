//
//  PushRouter.m
//  OCCS
//
//  Created by 烨 刘 on 15/12/8.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "PushRouter.h"
#import "AppDelegate.h"
#import "GDataXMLNode.h"
#import "PushNote.h"


@implementation PushRouter

+ (ActionType)actionToRouter:(NSString *)action {
    if([action isEqualToString:@""])
        return 0;
    return action.integerValue;
}

+ (void)receiveNoteWhenActive:(NSDictionary *)userInfo{
    [PushRouter insertNoteBroadcast:userInfo isActive:YES];
}

+ (void)receiveNoteWhenInactive:(NSDictionary *)userInfo{
    [PushRouter insertNoteBroadcast:userInfo isActive:NO];
}

+ (void)insertNoteBroadcast:(NSDictionary *)userInfo isActive:(BOOL)isActive {
    staticUserInfo = userInfo;
    NSString *actionCode = userInfo[@"action"];
    ActionType action = [PushRouter actionToRouter:actionCode];
    __block PushNote *pushNote = nil;
    [DatabaseHelper deleteNote:[NSNumber numberWithLongLong:[userInfo[@"id"] longLongValue]] time:[Utilitys stringToDate:userInfo[@"time"] format:@"yyyy-MM-dd HH:mm:ss"]];
    [DatabaseHelper insertNote:userInfo
                       success:^(PushNote *note) {
                           pushNote = note;
                           if (action != 推送工单详情){
                               if (note) {
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"sysNoteReceiver" object:note];
                               }
                           }else{
                               if (note) {
                                   [PushRouter saveGongdanNote:userInfo note:pushNote isPopup:NO];
                               }
                           }
                           
                           if (isActive && note) {
                               NSDictionary* pushInfo = @{@"message": note.message};
                               staticNote = note;
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"activeAlert" object:pushInfo];
                           }else if (!isActive && note){
                               [PushRouter doAfterAction:note];
                           }
    }];
    NSArray *noteAry = [DatabaseHelper getAllNotes];
    long noteCount = 0;
    if (noteAry.count > 0) {
        for (PushNote *n in noteAry) {
            if (![n.is_seen boolValue]) {
                noteCount ++;
            }
        }
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = noteCount;
}

+ (void)afterAction{
    [PushRouter doAfterAction:staticNote];
}

+ (void)doAfterAction:(PushNote *)note{
    NSString *actionCode = note.action_code;
    ActionType action = [PushRouter actionToRouter:actionCode];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%lu",(unsigned long)action);
    switch (action) {
        case 个人主页:
            [appDelegate showMainViewController];
            [appDelegate tabBarView:appDelegate.tabBar didSelectAtIndex:100];
            [DEF_NOTIFICATION postNotificationName:@"changIcon" object:[NSNumber numberWithInteger:0]];
            break;
        case 工单市场:
        case 需求市场:
            [appDelegate showMainViewController];
            [appDelegate tabBarView:appDelegate.tabBar didSelectAtIndex:101];
            [DEF_NOTIFICATION postNotificationName:@"changIcon" object:[NSNumber numberWithInteger:1]];
            break;
        case 岗位应聘:
        case 需求发布:
            [appDelegate showMainViewController];
            [appDelegate tabBarView:appDelegate.tabBar didSelectAtIndex:102];
            [DEF_NOTIFICATION postNotificationName:@"changIcon" object:[NSNumber numberWithInteger:2]];
            break;
        case 特殊页面:{
            [LDNetwokAPI getAppMessage:KEYWORD msgId:[NSString stringWithFormat:@"%@",note.note_id] successBlock:^(id returnData) {
                if (returnData != nil)
                {
                    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                    NSArray *results = [doc nodesForXPath:@"//results//details" error:nil];
                    NSString *push_identity;
                    
                    // 循环遍历每一个<results.../>元素
                    
                    for(GDataXMLElement *resultElement in results)
                    {
                        push_identity = [[[resultElement elementsForName:@"push_identity"] objectAtIndex:0] stringValue];
                        push_identity = [push_identity stringByReplacingOccurrencesOfString:@":" withString:@"\":"];
                        push_identity = [push_identity stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
                        
                        NSError *jsonError;
                        NSData *objectData = [push_identity dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&jsonError];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView" object:json userInfo:@{@"type": @"特殊页面"}];
                    }
                }
            } failureBlock:^(NSError *error) {
                [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:appDelegate.window.rootViewController];
            } showHUD:YES];
        }

            break;
        case 模板1:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView" object:note userInfo:@{@"type": @"模板1"}];
        }
            break;
        case 推送工单详情:{
            [LDNetwokAPI getAppMessage:KEYWORD msgId:[NSString stringWithFormat:@"%@",note.note_id] successBlock:^(id returnData) {
                if (returnData != nil)
                {
                    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                    NSArray *results = [doc nodesForXPath:@"//results//details" error:nil];
                    NSString *push_identity;
                    
                    // 循环遍历每一个<results.../>元素
                    
                    for(GDataXMLElement *resultElement in results)
                    {
                        push_identity = [[[resultElement elementsForName:@"push_identity"] objectAtIndex:0] stringValue];
                        push_identity = [push_identity stringByReplacingOccurrencesOfString:@":" withString:@"\":"];
                        push_identity = [push_identity stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
                        
                        NSError *jsonError;
                        NSData *objectData = [push_identity dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&jsonError];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView" object:json userInfo:@{@"type": @"推送工单详情"}];
                    }
                }
            } failureBlock:^(NSError *error) {
                [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:appDelegate.window.rootViewController];
            } showHUD:YES];
        }
            
            break;
        case 推送需求详情:
            break;
        case 个人账户:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView" object:note userInfo:@{@"type": @"个人账户"}];
            break;
        case 个人信息:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView" object:note userInfo:@{@"type": @"个人信息"}];
            break;
        default:
            break;
    }

}

+ (void)saveGongdanNote:(NSDictionary *)userInfo note:(PushNote *)pushNote isPopup:(BOOL)isPupup{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [LDNetwokAPI getAppMessage:KEYWORD msgId:userInfo[@"id"] successBlock:^(id returnData) {
        if (returnData != nil)
        {
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
            NSArray *results = [doc nodesForXPath:@"//results//details" error:nil];
            NSString *push_identity;
            
            // 循环遍历每一个<results.../>元素
            
            for(GDataXMLElement *resultElement in results)
            {
                push_identity = [[[resultElement elementsForName:@"push_identity"] objectAtIndex:0] stringValue];
                push_identity = [push_identity stringByReplacingOccurrencesOfString:@":" withString:@"\":"];
                push_identity = [push_identity stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
                
                NSError *jsonError;
                NSData *objectData = [push_identity dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&jsonError];
                [LDNetwokAPI getProjectDetail:KEYWORD workid:json[@"workid"] successBlock:^(id returnData) {
                    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                    NSArray *results = [doc nodesForXPath:@"//results//details" error:nil];
                    NSString *title, *workid, *project, *cost, *status, *period, *addtime, *deadline, *time, *type, *username;
                    for(GDataXMLElement *resultElement in results)
                    {
                        title = [[[resultElement elementsForName:@"worktitle"] objectAtIndex:0] stringValue];
                        workid = [[[resultElement elementsForName:@"id"] objectAtIndex:0] stringValue];
                        project = [[[resultElement elementsForName:@"projectname"] objectAtIndex:0] stringValue];
                        cost = [[[resultElement elementsForName:@"balances"] objectAtIndex:0] stringValue];
                        period = [[[resultElement elementsForName:@"workdays"] objectAtIndex:0] stringValue];
                        addtime = [[[resultElement elementsForName:@"addtime"] objectAtIndex:0] stringValue];
                        deadline = [[[resultElement elementsForName:@"deadline"] objectAtIndex:0] stringValue];
                        type = [[[resultElement elementsForName:@"typename"] objectAtIndex:0] stringValue];
                        time = userInfo[@"time"];
                        username = pushNote.username;
                        
                        if ([deadline isEqualToString:(@"")]) {
                            status = @"无截止时间";
                        }else{
                            NSDate *sinceNow = [Utilitys stringToDate:deadline format:@"yyyy-MM-dd HH:mm:ss"];
                            double timeSinceNow = [sinceNow timeIntervalSinceNow];
                            if (timeSinceNow > 0) {
                                status = @"竞标中";
                            }else{
                                status = @"竞标结束";
                            }
                        }
                        
                        if (username) {
                            NSDictionary *dict = [[NSDictionary alloc]
                                                  initWithObjects:@[workid, title, cost, project, type, period, addtime, deadline, time, status, username]
                                                  forKeys:@[@"workid",@"title",@"cost",@"project",@"type",@"period",@"addtime",@"deadline",@"time",@"status", @"username"]];
                            [DatabaseHelper deleteGongdan:workid time:[Utilitys stringToDate:time format:@"yyyy-MM-dd HH:mm:ss"]];
                            [DatabaseHelper insertGongdan:dict success:^(Gongdan * gongdan) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"sysGongdanReceiver" object:gongdan];
                            }];
                            
                        }
                        if (isPupup) {
                            //pupup webview;
                        }
                        
                    }
                    
                } failureBlock:^(NSError *error) {
                    [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:appDelegate.window.rootViewController];
                } showHUD:YES];
            }
        }
    } failureBlock:^(NSError *error) {
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:appDelegate.window.rootViewController];
    } showHUD:YES];
}

@end
