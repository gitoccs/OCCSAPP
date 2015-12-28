//
//  PushNote.m
//  
//
//  Created by 烨 刘 on 15/11/5.
//
//

#import "PushNote.h"

@implementation PushNote

// Insert code here to add functionality to your managed object subclass

- (BOOL) isEqualNote:(PushNote *)note
{
    if (self.note_id.intValue == note.note_id.intValue) {
        return YES;
    }else{
        return NO;
    }
}

@end
