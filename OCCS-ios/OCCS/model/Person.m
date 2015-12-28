//
//  Person.m
//  OCCS
//
//  Created by 烨 刘 on 15/10/26.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "Person.h"

@implementation Person

static Person * person = nil;

+ (Person *) getInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        person = [[Person alloc] initWithAvatar:@"" name:@"" realname:@"" nickname:@"" sex:@"" idno:@"" birthday:@"" address:@"" educollege:@"" degree:@"" mobile:@"" email:@"" profession:@"" skill:@"" qq:@"" weixin:@"" tjid:@"" amount:@"" ocoin:@"" ocoinCash:@"" ocoinFree:@"" typeNumber:0 key:@"" password:@"" industry:@"" url:@"" orgcode:@"" summary:@""];
    });
    
    return person;
}

+ (void)setInstance:(Person *)p {
    person = p;
}

-(instancetype) initWithAvatar:(NSString *)avatar name:(NSString *)name realname:(NSString *)realname
                      nickname:(NSString *)nickname sex:(NSString *)sex idno:(NSString *)idno birthday:(NSString *)birthday
                    address:(NSString *)address educollege:(NSString *)educollege degree:(NSString *)degree
                     mobile:(NSString *)mobile email:(NSString *)email profession:(NSString *)profession
                      skill:(NSString *)skill qq:(NSString *)qq weixin:(NSString *)weixin tjid:(NSString *)tjid
                      amount:(NSString *)amount ocoin:(NSString *)ocoin ocoinCash:(NSString *)ocoinCash
                  ocoinFree:(NSString *)ocoinFree typeNumber:(int)typeNumber key:(NSString *)key password:(NSString *)password
                      industry:(NSString *)industry url:(NSString *)url orgcode:(NSString *)orgcode summary:(NSString *)summary{
    if (self = [super init]) {
        _avatar = avatar;
        _name = name;
        _realname = realname;
        _nickname = nickname;
        _sex = sex;
        _idno = idno;
        _birthday = birthday;
        _address = address;
        _educollege = educollege;
        _degree = degree;
        _mobile = mobile;
        _email = email;
        _profession = profession;
        _skill = skill;
        _qq = qq;
        _weixin = weixin;
        _tjid = tjid;
        _amount = amount;
        _ocoin = ocoin;
        _ocoinCash = ocoinCash;
        _ocoinFree = ocoinFree;
        _typeNumber = typeNumber;
        _key = key;
        _password = password,
        _industry = industry,
        _url = url,
        _orgcode = orgcode,
        _summary = summary;
    }
    return self;
}

+(instancetype) updateWithAvatar:(NSString *)avatar name:(NSString *)name realname:(NSString *)realname
                        nickname:(NSString *)nickname sex:(NSString *)sex idno:(NSString *)idno birthday:(NSString *)birthday
                         address:(NSString *)address educollege:(NSString *)educollege degree:(NSString *)degree
                          mobile:(NSString *)mobile email:(NSString *)email profession:(NSString *)profession
                           skill:(NSString *)skill qq:(NSString *)qq weixin:(NSString *)weixin tjid:(NSString *)tjid
                          amount:(NSString *)amount ocoin:(NSString *)ocoin ocoinCash:(NSString *)ocoinCash
                       ocoinFree:(NSString *)ocoinFree typeNumber:(int)typeNumber key:(NSString *)key password:(NSString *)password
                        industry:(NSString *)industry url:(NSString *)url orgcode:(NSString *)orgcode summary:(NSString *)summary{
    Person *p = [Person getInstance];
    p.avatar = avatar;
    p.name = name;
    p.realname = realname;
    p.nickname = nickname;
    p.sex = sex;
    p.idno = idno;
    p.birthday = birthday;
    p.address = address;
    p.educollege = educollege;
    p.degree = degree;
    p.mobile = mobile;
    p.email = email;
    p.profession = profession;
    p.skill = skill;
    p.qq = qq;
    p.weixin = weixin;
    p.tjid = tjid;
    p.amount = amount;
    p.ocoin = ocoin;
    p.ocoinCash = ocoinCash;
    p.ocoinFree = ocoinFree;
    p.typeNumber = typeNumber;
    p.key = key;
    p.password = password,
    p.industry = industry,
    p.url = url,
    p.orgcode = orgcode,
    p.summary = summary;
    
    return p;
}

+(void) emptyInstance {
    [Person emptyInstanceWithoutName];
    Person *p = [Person getInstance];
    p.name = @"";
    DEF_PERSISTENT_REMOVE_OBJECT(@"userName");
}

+(void) emptyInstanceWithoutName{
    Person *p = [Person getInstance];
    DEF_PERSISTENT_REMOVE_OBJECT(@"key");
    DEF_PERSISTENT_REMOVE_OBJECT(@"password");
    DEF_PERSISTENT_REMOVE_OBJECT(@"avatar");
    DEF_PERSISTENT_REMOVE_OBJECT(@"realName");
    DEF_PERSISTENT_REMOVE_OBJECT(@"sex");
    DEF_PERSISTENT_REMOVE_OBJECT(@"idno");
    DEF_PERSISTENT_REMOVE_OBJECT(@"birthday");
    DEF_PERSISTENT_REMOVE_OBJECT(@"address");
    DEF_PERSISTENT_REMOVE_OBJECT(@"educollege");
    DEF_PERSISTENT_REMOVE_OBJECT(@"degree");
    DEF_PERSISTENT_REMOVE_OBJECT(@"mobile");
    DEF_PERSISTENT_REMOVE_OBJECT(@"email");
    DEF_PERSISTENT_REMOVE_OBJECT(@"profession");
    DEF_PERSISTENT_REMOVE_OBJECT(@"skill");
    DEF_PERSISTENT_REMOVE_OBJECT(@"qq");
    DEF_PERSISTENT_REMOVE_OBJECT(@"weixin");
    DEF_PERSISTENT_REMOVE_OBJECT(@"tjid");
    DEF_PERSISTENT_REMOVE_OBJECT(@"amount");
    DEF_PERSISTENT_REMOVE_OBJECT(@"ocoin");
    DEF_PERSISTENT_REMOVE_OBJECT(@"ocoinCash");
    DEF_PERSISTENT_REMOVE_OBJECT(@"ocoinFree");
    DEF_PERSISTENT_REMOVE_OBJECT(@"typeNumber");
    DEF_PERSISTENT_REMOVE_OBJECT(@"industry");
    DEF_PERSISTENT_REMOVE_OBJECT(@"url");
    DEF_PERSISTENT_REMOVE_OBJECT(@"orgcode");
    DEF_PERSISTENT_REMOVE_OBJECT(@"summary");
    p.avatar = @"";
    p.realname = @"";
    p.nickname = @"";
    p.sex = @"";
    p.idno = @"";
    p.birthday = @"";
    p.address = @"";
    p.educollege = @"";
    p.degree = @"";
    p.mobile = @"";
    p.email = @"";
    p.profession = @"";
    p.skill = @"";
    p.qq = @"";
    p.weixin = @"";
    p.tjid = @"";
    p.amount = @"";
    p.ocoin = @"";
    p.ocoinCash = @"";
    p.ocoinFree = @"";
    p.typeNumber = 0;
    p.key = @"";
    p.password = @"",
    p.industry = @"",
    p.url = @"",
    p.orgcode = @"",
    p.summary = @"";
}

+(void)initInstance{
    Person *p = [Person getInstance];
    p.avatar = DEF_PERSISTENT_GET_OBJECT(@"avatar") ? DEF_PERSISTENT_GET_OBJECT(@"avatar"):@"";
    p.name = DEF_PERSISTENT_GET_OBJECT(@"userName") ? DEF_PERSISTENT_GET_OBJECT(@"userName"):@"";
    p.realname = DEF_PERSISTENT_GET_OBJECT(@"realName") ? DEF_PERSISTENT_GET_OBJECT(@"realName"):@"";
    p.nickname = DEF_PERSISTENT_GET_OBJECT(@"nickname") ? DEF_PERSISTENT_GET_OBJECT(@"nickname"):@"";
    p.sex = DEF_PERSISTENT_GET_OBJECT(@"sex") ? DEF_PERSISTENT_GET_OBJECT(@"sex"):@"";
    p.idno = DEF_PERSISTENT_GET_OBJECT(@"idno") ? DEF_PERSISTENT_GET_OBJECT(@"idno"):@"";
    p.birthday = DEF_PERSISTENT_GET_OBJECT(@"birthday") ? DEF_PERSISTENT_GET_OBJECT(@"birthday"):@"";
    p.address = DEF_PERSISTENT_GET_OBJECT(@"address") ? DEF_PERSISTENT_GET_OBJECT(@"address"):@"";
    p.educollege = DEF_PERSISTENT_GET_OBJECT(@"educollege") ? DEF_PERSISTENT_GET_OBJECT(@"educollege"):@"";
    p.degree = DEF_PERSISTENT_GET_OBJECT(@"degree") ? DEF_PERSISTENT_GET_OBJECT(@"degree"):@"";
    p.mobile = DEF_PERSISTENT_GET_OBJECT(@"mobile") ? DEF_PERSISTENT_GET_OBJECT(@"mobile"):@"";
    p.email = DEF_PERSISTENT_GET_OBJECT(@"email") ? DEF_PERSISTENT_GET_OBJECT(@"email"):@"";
    p.profession = DEF_PERSISTENT_GET_OBJECT(@"profession") ? DEF_PERSISTENT_GET_OBJECT(@"profession"):@"";
    p.skill = DEF_PERSISTENT_GET_OBJECT(@"skill") ? DEF_PERSISTENT_GET_OBJECT(@"skill"):@"";
    p.qq = DEF_PERSISTENT_GET_OBJECT(@"qq") ? DEF_PERSISTENT_GET_OBJECT(@"qq"):@"";
    p.weixin = DEF_PERSISTENT_GET_OBJECT(@"weixin") ? DEF_PERSISTENT_GET_OBJECT(@"weixin"):@"";
    p.tjid = DEF_PERSISTENT_GET_OBJECT(@"tjid") ? DEF_PERSISTENT_GET_OBJECT(@"tjid"):@"";
    p.amount = DEF_PERSISTENT_GET_OBJECT(@"amount") ? DEF_PERSISTENT_GET_OBJECT(@"amount"):@"";
    p.ocoin = DEF_PERSISTENT_GET_OBJECT(@"ocoin") ? DEF_PERSISTENT_GET_OBJECT(@"ocoin"):@"";
    p.ocoinCash = DEF_PERSISTENT_GET_OBJECT(@"ocoinCash") ? DEF_PERSISTENT_GET_OBJECT(@"ocoinCash"):@"";
    p.ocoinFree = DEF_PERSISTENT_GET_OBJECT(@"ocoinFree") ? DEF_PERSISTENT_GET_OBJECT(@"ocoinFree"):@"";
    p.key = DEF_PERSISTENT_GET_OBJECT(@"key") ? DEF_PERSISTENT_GET_OBJECT(@"key"):@"";
    p.password = DEF_PERSISTENT_GET_OBJECT(@"password") ? DEF_PERSISTENT_GET_OBJECT(@"password"):@"";
    p.typeNumber = DEF_PERSISTENT_GET_OBJECT(@"typeNumber") ? [DEF_PERSISTENT_GET_OBJECT(@"typeNumber")intValue]:0;
    p.industry = DEF_PERSISTENT_GET_OBJECT(@"industry") ? DEF_PERSISTENT_GET_OBJECT(@"industry"):@"";
    p.url = DEF_PERSISTENT_GET_OBJECT(@"url") ? DEF_PERSISTENT_GET_OBJECT(@"url"):@"";
    p.orgcode = DEF_PERSISTENT_GET_OBJECT(@"orgcode") ? DEF_PERSISTENT_GET_OBJECT(@"orgcode"):@"";
    p.summary = DEF_PERSISTENT_GET_OBJECT(@"summary") ? DEF_PERSISTENT_GET_OBJECT(@"summary"):@"";
}

+ (NSString *)getTypeFromInt
{
    switch ([Person getInstance].typeNumber){
        case 1:
            return @"个人";
        case 9:
            return @"企业";
        case 91:
            return @"软企";
        default:
            return nil;
    }
}

+ (UIColor *)getColor
{
    if ([Person getInstance].typeNumber == 1)
    {
        return BLUECOLOR;
    }
    else if ([Person getInstance].typeNumber == 9)
    {
        return ORANGECOLOR;
    }
    else if ([Person getInstance].typeNumber == 91)
    {
        return GREENCOLOR;
    }else{
        return BLUECOLOR;
    }
}

-(void) saveInstance {
    Person *p = [Person getInstance];
    DEF_PERSISTENT_SET_OBJECT(p.avatar, @"avatar");
    DEF_PERSISTENT_SET_OBJECT(p.name, @"userName");
    DEF_PERSISTENT_SET_OBJECT(p.realname, @"realName");
    DEF_PERSISTENT_SET_OBJECT(p.nickname, @"nickname");
    DEF_PERSISTENT_SET_OBJECT(p.sex, @"sex");
    DEF_PERSISTENT_SET_OBJECT(p.idno, @"idno");
    DEF_PERSISTENT_SET_OBJECT(p.birthday, @"birthday");
    DEF_PERSISTENT_SET_OBJECT(p.address, @"address");
    DEF_PERSISTENT_SET_OBJECT(p.educollege, @"educollege");
    DEF_PERSISTENT_SET_OBJECT(p.degree, @"degree");
    DEF_PERSISTENT_SET_OBJECT(p.mobile, @"mobile");
    DEF_PERSISTENT_SET_OBJECT(p.email, @"email");
    DEF_PERSISTENT_SET_OBJECT(p.profession, @"profession");
    DEF_PERSISTENT_SET_OBJECT(p.skill, @"skill");
    DEF_PERSISTENT_SET_OBJECT(p.qq, @"qq");
    DEF_PERSISTENT_SET_OBJECT(p.weixin, @"weixin");
    DEF_PERSISTENT_SET_OBJECT(p.tjid, @"tjid");
    DEF_PERSISTENT_SET_OBJECT(p.amount, @"amount");
    DEF_PERSISTENT_SET_OBJECT(p.ocoin, @"ocoin");
    DEF_PERSISTENT_SET_OBJECT(p.ocoinCash, @"ocoinCash");
    DEF_PERSISTENT_SET_OBJECT(p.ocoinFree, @"ocoinFree");
    
    DEF_PERSISTENT_SET_OBJECT(p.key, @"key");
    DEF_PERSISTENT_SET_OBJECT(p.password, @"password");
    DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithInt:p.typeNumber], @"typeNumber");
    
    DEF_PERSISTENT_SET_OBJECT(p.industry, @"industry");
    DEF_PERSISTENT_SET_OBJECT(p.url, @"url");
    DEF_PERSISTENT_SET_OBJECT(p.orgcode, @"orgcode");
    DEF_PERSISTENT_SET_OBJECT(p.summary, @"summary");
}

-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    Person *p = [Person getInstance];
    Person *another = [[Person alloc] initWithAvatar:[p.avatar copy] name:[p.name copy] realname:[p.realname copy] nickname:[p.nickname copy] sex:[p.sex copy] idno:[p.idno copy] birthday:[p.birthday copy] address:[p.address copy] educollege:[p.educollege copy] degree:[p.degree copy] mobile:[p.mobile copy] email:[p.email copy] profession:[p.profession copy] skill:[p.skill copy] qq:[p.qq copy] weixin:[p.weixin copy] tjid:[p.tjid copy] amount:[p.amount copy] ocoin:[p.ocoin copy] ocoinCash:[p.ocoinCash copy] ocoinFree:[p.ocoinFree copy] typeNumber:p.typeNumber key:[p.key copy] password:[p.password copy] industry:[p.industry copy] url:[p.url copy] orgcode:[p.orgcode copy] summary:[p.summary copy]];
    
    return another;
}

+ (NSString *)personToJson{
    Person *p = [Person getInstance];
    return [NSString stringWithFormat:@"{nick_name:\"%@\", Sex:\"%@\", birthday:\"%@\", address:\"%@\", educollege:\"%@\", qq:\"%@\", weixin:\"%@\"}",
                         p.nickname, p.sex, p.birthday, p.address, p.educollege, p.qq, p.weixin];
}

- (BOOL)isEqualToPerson:(Person *)person keys:(NSArray *)keys{
    BOOL isequal = YES;
    for (NSString *k in keys) {
        if (![[self valueForKey:k] isEqualToString:[person valueForKey:k]]) {
            return NO;
        }
    }
    return isequal;
}

@end
