//
//  GongdanSuitableControllerViewController.m
//  OCCS
//
//  Created by 烨 刘 on 15/12/9.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "GongdanSuitableController.h"
#import "DatabaseHelper.h"
#import "Gongdan.h"
#import <QuartzCore/QuartzCore.h>

@interface GongdanSuitableController ()

@property (nonatomic, strong) NSArray *gongdanAry;
@property (nonatomic) CGRect frame;

@end

@implementation GongdanSuitableController

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.title = @"适合的工单";
        self.frame = frame;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"GongdanTableCell" bundle:nil]
         forCellReuseIdentifier:@"GongdanTableCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [Utilitys cellBackColor];
    self.tableView.backgroundColor = [Utilitys cellBackColor];
    
    self.gongdanAry = [DatabaseHelper getAllGongdan];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                             target:self action:@selector(dismissSelf:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                              target:self action:@selector(emptyGongdanDatabase:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gongdanReflesh:) name:@"sysGongdanReceiver" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)gongdanReflesh:(NSNotification *)notification
{
    self.gongdanAry = [DatabaseHelper getAllGongdan];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [DatabaseHelper setAllGongdanIsSeen];
}

- (void)dismissSelf:(UIBarButtonItem *)btn
{
    [self.delegate dismissSelfVC];
}

- (void)emptyGongdanDatabase:(UIBarButtonItem *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除所有推送工单？" delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}

# pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [DatabaseHelper emptyGongdanDatabase];
            self.gongdanAry = [DatabaseHelper getAllGongdan];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gongdanAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 225.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GongdanTableCell"];
    Gongdan *gongdan = self.gongdanAry[index];
    cell.contentView.backgroundColor = [Utilitys cellBackColor];
    UIView *backView1 = [cell.contentView viewWithTag:100];
    [backView1.layer setCornerRadius:10.0f];
    // drop shadow
    [backView1.layer setShadowColor:[UIColor blackColor].CGColor];
    [backView1.layer setShadowOpacity:0.4];
    [backView1.layer setShadowRadius:3.0];
    [backView1.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    UIView *backView2 = [cell.contentView viewWithTag:99];
    [backView2.layer setCornerRadius:10.0f];
    // border
    [backView2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [backView2.layer setBorderWidth:1.0f];
    
    UILabel *titleLabel = [cell.contentView viewWithTag:1];
    titleLabel.text = gongdan.title;
    
    UILabel *costLabel = [cell.contentView viewWithTag:2];
    costLabel.text = gongdan.cost;
    
    UILabel *typeLabel = [cell.contentView viewWithTag:3];
    typeLabel.text = gongdan.type;
    
    UILabel *projectLabel = [cell.contentView viewWithTag:4];
    projectLabel.text = gongdan.project;
    
    UILabel *periodLabel = [cell.contentView viewWithTag:5];
    periodLabel.text = [NSString stringWithFormat:@"%@天",gongdan.period];
    
    UILabel *deadLineLabel = [cell.contentView viewWithTag:6];
    deadLineLabel.text = [Utilitys dateToString:gongdan.deadline format:@"yyyy年MMMdd日 HH:mm:ss"];
    
    UILabel *statusLabel = [cell.contentView viewWithTag:7];
    statusLabel.text = gongdan.status;
    
    UIImageView *newIcon = [cell.contentView viewWithTag:8];
    
    if (![[gongdan valueForKey:@"is_seen"] boolValue]) {
        newIcon.alpha = 1;
    }else{
        newIcon.alpha = 0;
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        long index = indexPath.row;
        Gongdan *gondan = self.gongdanAry[index];
        [DatabaseHelper deleteGongdan:gondan.workid time:gondan.time];
        NSMutableArray *mary = [self.gongdanAry mutableCopy];
        [mary removeObjectAtIndex:index];
        self.gongdanAry = [mary copy];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
     NSUInteger row = indexPath.row;
     Gongdan *gongdan = self.gongdanAry[row];
     NSString *workid = gongdan.workid;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"pupModalView"
                                                         object:[[NSDictionary alloc] initWithObjects:@[workid] forKeys:@[@"workid"]]
                                                       userInfo:@{@"type": @"推送工单详情"}];
 }

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
