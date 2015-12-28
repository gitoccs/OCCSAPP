//
//  MMLeftDrawerViewController.m
//  MusicKingdom
//
//  Created by Gennie Sun on 14-9-12.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//
#import "MMLeftDrawerViewController.h"
#import "AppDelegate.h"
#import "LDLoginViewController.h"
#import "GDataXMLNode.h"
#import "UIButton+WebCache.h"
#import "AccountModifyController.h"
#import "LDWebViewController.h"


@interface MMLeftDrawerViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@end

NSArray *dataArray;
UITableView *table;
NSString *urlIconStr;

@implementation MMLeftDrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray = @[@"账户管理",@"我的账户",@"新手帮助",@"联系客服",@"关于OCCS"];

    //---------------------获取所有的用户信息资料
    [self getUserInfo];

    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 155, 270, DEF_SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    if (IS_IPHONE_4_OR_LESS)
    {
        table.frame = CGRectMake(0, 155, 270, DEF_SCREEN_HEIGHT - 100);
    }
    table.backgroundColor = [UIColor whiteColor];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:table];
    
    UIButton *btnLoginout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLoginout addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
    btnLoginout.frame = CGRectMake(15, DEF_SCREEN_HEIGHT - 100 + 25, 230, 44);
    [btnLoginout setTitle:@"退出登录" forState:0];
    btnLoginout.titleLabel.font = [UIFont systemFontOfSize:14];
    btnLoginout.layer.cornerRadius = 3;
    btnLoginout.layer.masksToBounds = YES;
    [btnLoginout setBackgroundColor:UIColorFromRGB(0xe24040)];
    [self.view addSubview:btnLoginout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImage:) name:@"changeImage" object:nil];
}

#pragma mark
#pragma mark --UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        UIImage *imageLine = [UIImage imageNamed:@"lineleft"];
        UIImageView *imageViewLine = [[UIImageView alloc] initWithImage:imageLine];
        imageViewLine.frame = CGRectMake(5, 43, 150, 1.0f);
        [cell.contentView addSubview:imageViewLine];
    }

    cell.backgroundColor = [UIColor clearColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dataArray[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = UIColorFromRGB(0x5E5E5E);// [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            AccountModifyController *avc = [[AccountModifyController alloc] initWithNibName:@"AccountModifyController" bundle:nil];
            avc.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:avc];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 1:{
            NSString *url = [NSString stringWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&email=%@",
                             DEF_PAGE_ACCOUNT,
                             [Person getInstance].name,
                             [Person getInstance].key,
                             [Person getInstance].mobile,
                             [Person getInstance].email];
            NSLog(@"%@", [Person getInstance].name);
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LDWebViewController *webVC = [[LDWebViewController alloc]
                          initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                          url: url
                                          title:@"我的账户"];
            webVC.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 2:
        {
            NSString *url = [NSString stringWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&email=%@",
                             DEF_PAGE_HELP,
                             [Person getInstance].name,
                             [Person getInstance].key,
                             [Person getInstance].mobile,
                             [Person getInstance].email];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LDWebViewController *webVC = [[LDWebViewController alloc]
                                          initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                          url: url
                                          title:@"我的账户"];
            webVC.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 3:
        {
            NSString *url = [NSString stringWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&email=%@",
                             DEF_PAGE_SERVICE,
                             [Person getInstance].name,
                             [Person getInstance].key,
                             [Person getInstance].mobile,
                             [Person getInstance].email];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LDWebViewController *webVC = [[LDWebViewController alloc]
                                          initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                          url: url
                                          title:@"我的账户"];
            webVC.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 4:
        {
            NSString *url = [NSString stringWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&email=%@",
                             DEF_PAGE_ABOUT,
                             [Person getInstance].name,
                             [Person getInstance].key,
                             [Person getInstance].mobile,
                             [Person getInstance].email];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LDWebViewController *webVC = [[LDWebViewController alloc]
                                          initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                          url:url
                                          title:@"我的账户"];
            webVC.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}



/**
 *  页面布局
 */
- (void)uiConfig:(NSArray *)titleArr
{
    UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 155)];
    viewBg.backgroundColor = [Person getColor];
    
    int baseTop = -5;
    [self.view addSubview:viewBg];
    
    // 设置
//    UIImageView *imageSet = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 32, 32)];
//    [viewBg addSubview:imageSet];
//    imageSet.image = [UIImage imageNamed:@"set"];
    
    // 头像
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoBtn.layer.masksToBounds = YES;
    self.photoBtn.layer.cornerRadius = 30;
    self.photoBtn.frame = CGRectMake(15, baseTop + 45, 60, 60);
    
    Person *p = [Person getInstance];
    if (! [self.photoBtn backgroundImageForState:0]) {
        if (![p.avatar isEqualToString:@""] && ![Utilitys isBlankString:p.avatar])
        {
            [self.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:p.avatar] forState:0];
        }
        else
        {
            [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"userimage"] forState:0];
        }
    }
    
    [viewBg addSubview:self.photoBtn];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, baseTop + 57, 140, 30)];
    nameLabel.text = [Person getInstance].name;
    [viewBg addSubview:nameLabel];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:20];
    
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    
    [viewBg addSubview:arrowBtn];
    arrowBtn.frame = CGRectMake(220, baseTop + 62, 32, 32);
    [arrowBtn addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, baseTop + 80, 140, 30)];
    infoLabel.text = [NSString stringWithFormat:@"O币：%@",p.ocoin];
    [viewBg addSubview:infoLabel];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:12];
    for (int i = 0 ; i < 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(7 + 63 * i, baseTop + 110, 60, 45);
        [viewBg addSubview:btn];
//        btn.backgroundColor = [UIColor lightGrayColor];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.numberOfLines = 0;
        
        if (i < 3)
        {
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(70 + 62 * i, baseTop + 125, 1, 20)];
            [viewBg addSubview:viewLine];
            viewLine.alpha = 0.4;
            viewLine.backgroundColor = [UIColor lightGrayColor];
        }
    }
}

-(void)arrowClick:(UIButton *)sender
{
    PersonInfoViewController *perVC = [[PersonInfoViewController alloc] initWithNibName:@"PersonInfoViewController" bundle:nil];
    perVC.delegate = self;
    perVC.orgImg = [self.photoBtn backgroundImageForState:0];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:perVC];
    
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark-
#pragma mark PersonInfo Delegate

- (void)dismissPersonInfoVC:(UIImage*)img{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.photoBtn setBackgroundImage:img forState:0];
}

- (void)changeImage:(NSNotification *)notification
{
    UIImage *img = (UIImage *)notification.object;
    [self.photoBtn setBackgroundImage:img forState:0];
}

#pragma mark-
#pragma mark PupupView Delegate

- (void)dismissSelfVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)btnClick:(UIButton *)sender
{
    [self loginout];
}


//退出登陆
- (void)loginout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}



- (void)loadLoginOut
{
    [LDNetwokAPI loginOutByKeyword:KEYWORD key:[Person getInstance].key successBlock:^(id returnData) {
        
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
        
        if (status.integerValue == 1)
        {
            [Person emptyInstanceWithoutName];
            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            LDLoginViewController *loginViewController = [[LDLoginViewController alloc] initWithNibName:@"LDLoginViewController" bundle:nil];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            navi.navigationBar.hidden = YES;
            delegate.window.rootViewController = navi;
        }
        else
        {
            [Utilitys showAlertWithMsg:msg andTitle:@"提示" andVc:self];
        }
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) getUserInfo
{
    [LDNetwokAPI GetUserInfoByKeyword:KEYWORD userName:[Person getInstance].name successBlock:^(id returnData) {
        
        Person *p = [Person getInstance];
        
        if (returnData != nil)
        {
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
            NSArray *results = [doc nodesForXPath:@"//results/details" error:nil];
 
            // 循环遍历每一个<results.../>元素
            for(GDataXMLElement *resultElement in results)
            {
                //获取需求名称元素
                p.avatar = [[[resultElement elementsForName:@"avatar"] objectAtIndex:0] stringValue];
                p.realname = [[[resultElement elementsForName:@"user_name"] objectAtIndex:0] stringValue];
                p.nickname = [[[resultElement elementsForName:@"nick_name"] objectAtIndex:0] stringValue];
                p.sex = [[[resultElement elementsForName:@"sex"] objectAtIndex:0] stringValue];
                p.birthday = [[[resultElement elementsForName:@"birthday"] objectAtIndex:0] stringValue];
                p.idno = [[[resultElement elementsForName:@"idno"] objectAtIndex:0] stringValue];
                p.address = [[[resultElement elementsForName:@"address"] objectAtIndex:0] stringValue];
                p.educollege = [[[resultElement elementsForName:@"educollege"] objectAtIndex:0] stringValue];
                p.degree = [[[resultElement elementsForName:@"degree"] objectAtIndex:0] stringValue];
                p.profession = [[[resultElement elementsForName:@"profession"] objectAtIndex:0] stringValue];
                p.skill = [[[resultElement elementsForName:@"skill"] objectAtIndex:0] stringValue];
                p.qq = [[[resultElement elementsForName:@"qq"] objectAtIndex:0] stringValue];
                p.weixin = [[[resultElement elementsForName:@"weixin"] objectAtIndex:0] stringValue];
                p.tjid = [[[resultElement elementsForName:@"tjid"] objectAtIndex:0] stringValue];
                p.amount = [[[resultElement elementsForName:@"amount"] objectAtIndex:0] stringValue];
                p.ocoin = [[[resultElement elementsForName:@"ocoin"] objectAtIndex:0] stringValue];
                p.ocoinCash = [[[resultElement elementsForName:@"ocoinCash"] objectAtIndex:0] stringValue];
                p.ocoinFree = [[[resultElement elementsForName:@"ocoinFree"] objectAtIndex:0] stringValue];
                p.industry = [[[resultElement elementsForName:@"industry"] objectAtIndex:0] stringValue];
                p.url = [[[resultElement elementsForName:@"url"] objectAtIndex:0] stringValue];
                p.orgcode = [[[resultElement elementsForName:@"orgcode"] objectAtIndex:0] stringValue];
                p.summary = [[[resultElement elementsForName:@"summary"] objectAtIndex:0] stringValue];
            }
        }
        
        [LDNetwokAPI GetGongdanInfoByKeyword:KEYWORD key:[Person getInstance].key successBlock:^(id returnData) {
            NSString *a, *b, *c, *d;
            NSArray *titleArr;
            if (returnData != nil)
            {
                GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:returnData options:1 error:nil];
                NSArray *results = [doc nodesForXPath:@"//results" error:nil];
                
                // 循环遍历每一个<results.../>元素
                
                for(GDataXMLElement *resultElement in results)
                {
                    a = [[[resultElement elementsForName:@"a"] objectAtIndex:0] stringValue];
                    b = [[[resultElement elementsForName:@"b"] objectAtIndex:0] stringValue];
                    c = [[[resultElement elementsForName:@"c"] objectAtIndex:0] stringValue];
                    d = [[[resultElement elementsForName:@"d"] objectAtIndex:0] stringValue];
                    titleArr = @[[NSString stringWithFormat:@"%@\n全部",a],
                                          [NSString stringWithFormat:@"%@\n竞标中",b],
                                          [NSString stringWithFormat:@"%@\n进行中",c],
                                          [NSString stringWithFormat:@"%@\n已完成",d]];
                }
            }
            [self uiConfig:titleArr];
        } failureBlock:^(NSError *error) {
            [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        } showHUD:YES];
        
    } failureBlock:^(NSError *error) {
        
        [Utilitys showAlertWithMsg:@"网络异常" andTitle:@"提示" andVc:self];
        
    } showHUD:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([Utilitys isBlankString:[Person getInstance].key])
        {
            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [delegate showLoginVc];
        }
        else
        {
            [self loadLoginOut];
        }
    }
}

@end
