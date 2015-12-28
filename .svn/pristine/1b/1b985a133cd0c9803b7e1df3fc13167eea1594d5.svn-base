//
//  DatabaseHelper.h
//  OCCS
//
//  Created by 烨 刘 on 15/11/9.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PushNote;
@class Gongdan;

@interface DatabaseHelper : NSObject

+ (void)insertNote:(NSDictionary *)userInfo success:(void(^)(PushNote *note))block;
+ (void)deleteNote:(NSNumber *)idNum time:(NSDate *)date;
+ (NSArray *)getAllNotes;
+ (void)setAllNoteIsSeen;
+ (void)emptyNoteDatabase;

+ (NSArray *)getAllGongdan;
+ (void)insertGongdan:(NSDictionary *)userInfo success:(void(^)(Gongdan*))block;
+ (void)deleteGongdan:(NSString *)idStr time:(NSDate *)date;
+ (void)setAllGongdanIsSeen;
+ (void)emptyGongdanDatabase;

@end
