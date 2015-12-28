//
//  PushNote+CoreDataProperties.h
//  
//
//  Created by 烨 刘 on 15/11/5.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PushNote.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushNote (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *note_id;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *identity;
@property (nullable, nonatomic, retain) NSString *action_code;
@property (nullable, nonatomic, retain) NSNumber *is_seen;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *username;


@end

NS_ASSUME_NONNULL_END
