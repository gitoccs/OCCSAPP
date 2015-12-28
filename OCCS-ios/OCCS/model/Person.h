//
//  Person.h
//  OCCS
//
//  Created by 烨 刘 on 15/10/26.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *idno;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *educollege;
@property (nonatomic, copy) NSString *degree;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *skill;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *weixin;
@property (nonatomic, copy) NSString *tjid;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *ocoin;
@property (nonatomic, copy) NSString *ocoinCash;
@property (nonatomic, copy) NSString *ocoinFree;
@property (nonatomic) int typeNumber;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *name;
/// this part is needed by 软企和企业用户
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *orgcode;
@property (nonatomic, copy) NSString *summary;


+(Person *) getInstance;
+ (void)setInstance:(Person *)person;
+(void) initInstance;
+(void) emptyInstanceWithoutName;
+(void) emptyInstance;
+ (UIColor *)getColor;
+ (NSString *)personToJson;
+ (NSString *)getTypeFromInt;
-(void) saveInstance;
- (BOOL)isEqualToPerson:(Person *)person keys:(NSArray *)keys;

@end
