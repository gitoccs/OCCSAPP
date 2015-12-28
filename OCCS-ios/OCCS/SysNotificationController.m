//
//  NoteTableController.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/9.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "SysNotificationController.h"
#import "DatabaseHelper.h"
#import "PushNote.h"
#import "PushRouter.h"


@interface SysNotificationController ()

@property (nonatomic, strong) NSArray *noteAry;
@property (nonatomic) CGRect frame;

@end

@implementation SysNotificationController

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.title = @"系统信息";
        self.frame = frame;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableCell" bundle:nil]
         forCellReuseIdentifier:@"NoteTableCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [Utilitys cellBackColor];
    self.tableView.backgroundColor = [Utilitys cellBackColor];
    
    self.noteAry = [DatabaseHelper getAllNotes];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                    target:self action:@selector(dismissSelf:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                        target:self action:@selector(emptyNoteDatabase:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteReflesh:) name:@"sysNoteReceiver" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)noteReflesh:(NSNotification *)notification
{
    self.noteAry = [DatabaseHelper getAllNotes];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [DatabaseHelper setAllNoteIsSeen];
}

- (void)dismissSelf:(UIBarButtonItem *)btn
{
    [self.delegate dismissSelfVC];
}

- (void)emptyNoteDatabase:(UIBarButtonItem *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除所有推送信息？" delegate:self
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
            [DatabaseHelper emptyNoteDatabase];
            self.noteAry = [DatabaseHelper getAllNotes];
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
    return self.noteAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    PushNote *note = self.noteAry[index];
    NSString *txt = [NSString stringWithFormat:@"%@",[note valueForKey:@"message"]];
    int height = [Utilitys findHeightForText:txt havingWidth:self.view.frame.size.width-31 andFont:[UIFont systemFontOfSize:16.0]].height;
    return 75+(height-20);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteTableCell"];
    PushNote *note = self.noteAry[index];
    cell.contentView.backgroundColor = [Utilitys cellBackColor];
    UIView *backView = [cell.contentView viewWithTag:100];
    [backView.layer setCornerRadius:10.0f];
    
    // border
    [backView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [backView.layer setBorderWidth:1.0f];
    
    // drop shadow
    [backView.layer setShadowColor:[UIColor blackColor].CGColor];
    [backView.layer setShadowOpacity:0.4];
    [backView.layer setShadowRadius:3.0];
    [backView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    UILabel *msgLabel = [cell.contentView viewWithTag:1];
    NSString *txt = [NSString stringWithFormat:@"%@",[note valueForKey:@"message"]];
    msgLabel.text = txt;
    UILabel *dateLabel = [cell.contentView viewWithTag:2];
    
//    NSLog(@"txt:%@    width:%f",txt,msgLabel.frame.size.width);
//    NSLog(@"height1 is:%f",[Utilitys findHeightForText:txt havingWidth:msgLabel.frame.size.width andFont:[UIFont systemFontOfSize:16.0]].height);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MMMdd日 HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:[note valueForKey:@"time"]];
    
    dateLabel.text = stringFromDate;
    
    UIImageView *newIcon = [cell.contentView viewWithTag:3];
        
    if (![[note valueForKey:@"is_seen"] boolValue]) {
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
        PushNote *note = self.noteAry[index];
        [DatabaseHelper deleteNote:note.note_id time:note.time];
        NSMutableArray *mary = [self.noteAry mutableCopy];
        [mary removeObjectAtIndex:index];
        self.noteAry = [mary copy];
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
    PushNote *note = self.noteAry[row];
    [PushRouter doAfterAction:note];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dismissSelfVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
