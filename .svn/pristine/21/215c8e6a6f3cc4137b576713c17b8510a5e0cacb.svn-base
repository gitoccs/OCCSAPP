//
//  DatabaseHelper.m
//  OCCS
//
//  Created by 烨 刘 on 15/11/9.
//  Copyright © 2015年 Leader. All rights reserved.
//

#import "DatabaseHelper.h"
#import "AppDelegate.h"
#import "PushNote.h"
#import "Gongdan.h"

static NSManagedObjectContext *coreDateContext;

@implementation DatabaseHelper

///通知的数据库

+ (void)insertNote:(NSDictionary *)userInfo success:(void(^)(PushNote *note))block
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDateContext = appDelegate.managedObjectContext;
    NSString *rawMessage = userInfo[@"aps"][@"alert"];
    NSString *identity = userInfo[@"identity"];
    BOOL isAnbody = false;
    
    NSDate *date = [Utilitys stringToDate:userInfo[@"time"] format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PushNote" inManagedObjectContext:coreDateContext];
    PushNote *pushNote = [[PushNote alloc] initWithEntity:entity insertIntoManagedObjectContext:coreDateContext];
    pushNote.note_id = [NSNumber numberWithLongLong:[userInfo[@"id"] longLongValue]];
    pushNote.message = rawMessage;
    pushNote.is_seen = [NSNumber numberWithInt:0];
    pushNote.time = date;
    if ([identity isEqualToString:@"1"])
        isAnbody = true;
    else if ([Person getInstance].password && ![[Person getInstance].password isEqualToString:@""])
        pushNote.username = [Person getInstance].name;
    else
        pushNote.username = @"";
    
    pushNote.type = userInfo[@"action"];
    pushNote.identity = userInfo[@"identity"];
    pushNote.action_code = userInfo[@"action"];
    
    NSError *error;
    if( ![coreDateContext save:&error] ){
        NSLog(@"Error relating a location to an invite %@",error);
    }else{
        NSLog(@"push note message: %@",pushNote.message);
        block(pushNote);
    }
    
}

+ (void)deleteNote:(NSNumber *)idNum time:(NSDate *)date
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PushNote"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *pushNoteAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (PushNote *n in pushNoteAry) {
        if ([n.note_id isEqualToNumber:idNum] && [[Utilitys dateToString:date format:@"yyyy-MM-dd HH:mm:ss"]
                                                  isEqualToString:[Utilitys dateToString:n.time format:@"yyyy-MM-dd HH:mm:ss"]]) {
            [appDelegate.managedObjectContext deleteObject:n];
        }
    }
    [appDelegate.managedObjectContext save:nil];
}

+ (void)setAllNoteIsSeen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PushNote"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *pushNoteAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (PushNote *n in pushNoteAry) {
        n.is_seen = [NSNumber numberWithBool:YES];
    }
    NSError *error;
    if( ![appDelegate.managedObjectContext save:&error]){
        NSLog(@"Error relating a location to an invite %@",error);
    }
    
}

+ (void)emptyNoteDatabase
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PushNote"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *pushNoteAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (PushNote *n in pushNoteAry) {
        [appDelegate.managedObjectContext deleteObject:n];
    }
    [appDelegate.managedObjectContext save:nil];
}

+ (NSArray *)getAllNotes{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                      ascending:NO];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PushNote"];
    [request setPredicate:notePredicate];
    [request setSortDescriptors:@[dateDescriptor]];
    NSArray *pushNoteAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    return pushNoteAry;
}

///工单的数据库

+ (NSArray *)getAllGongdan{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                                   ascending:NO];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Gongdan"];
    [request setPredicate:notePredicate];
    [request setSortDescriptors:@[dateDescriptor]];
    NSArray *pushNoteAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    return pushNoteAry;
}

+ (void)insertGongdan:(NSDictionary *)userInfo success:(void(^)(Gongdan *))block
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    coreDateContext = appDelegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Gongdan" inManagedObjectContext:coreDateContext];
    Gongdan *gongdan = [[Gongdan alloc] initWithEntity:entity insertIntoManagedObjectContext:coreDateContext];
    gongdan.workid = userInfo[@"workid"];
    gongdan.title = userInfo[@"title"];
    gongdan.project = userInfo[@"project"];
    gongdan.cost = userInfo[@"cost"];
    gongdan.period = userInfo[@"period"];
    gongdan.type = userInfo[@"type"];
    gongdan.status = userInfo[@"status"];
    gongdan.username = userInfo[@"username"];
    gongdan.addtime = [Utilitys stringToDate:userInfo[@"addtime"] format:@"yyyy-MM-dd HH:mm:ss"];
    gongdan.time = [Utilitys stringToDate:userInfo[@"time"] format:@"yyyy-MM-dd HH:mm:ss"];
    gongdan.deadline = [Utilitys stringToDate:userInfo[@"deadline"] format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSError *error;
    if( ![coreDateContext save:&error] ){
        NSLog(@"Error relating a location to an invite %@",error);
    }else{
        block(gongdan);
    }
}

+ (void)deleteGongdan:(NSString *)idStr time:(NSDate *)date
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Gongdan"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *gongdanAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (Gongdan *g in gongdanAry) {
        if ([g.workid isEqualToString:idStr] && [[Utilitys dateToString:date format:@"yyyy-MM-dd HH:mm:ss"]
                                                 isEqualToString:[Utilitys dateToString:g.time format:@"yyyy-MM-dd HH:mm:ss"]]) {
            [appDelegate.managedObjectContext deleteObject:g];
        }
    }
    [appDelegate.managedObjectContext save:nil];
}

+ (void)setAllGongdanIsSeen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Gongdan"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *gongdanAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (Gongdan *g in gongdanAry) {
        g.is_seen = [NSNumber numberWithBool:YES];
    }
    NSError *error;
    if( ![appDelegate.managedObjectContext save:&error]){
        NSLog(@"Error relating a location to an invite %@",error);
    }
}

+ (void)emptyGongdanDatabase
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Gongdan"];
    NSPredicate *notePredicate = [NSPredicate predicateWithFormat:@"(username = %@) OR (username = %@)",[Person getInstance].name, @""];
    [request setPredicate:notePredicate];
    NSArray *gongdanAry = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (Gongdan *g in gongdanAry) {
        [appDelegate.managedObjectContext deleteObject:g];
    }
    [appDelegate.managedObjectContext save:nil];
}

@end
