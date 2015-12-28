//
//  PushNote.h
//  
//
//  Created by 烨 刘 on 15/11/5.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushNote : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (BOOL) isEqualNote:(PushNote *)note;

@end

NS_ASSUME_NONNULL_END

#import "PushNote+CoreDataProperties.h"
