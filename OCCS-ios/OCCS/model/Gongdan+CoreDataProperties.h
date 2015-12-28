//
//  Gongdan+CoreDataProperties.h
//  
//
//  Created by 烨 刘 on 15/12/7.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Gongdan.h"

NS_ASSUME_NONNULL_BEGIN

@interface Gongdan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cost;
@property (nullable, nonatomic, retain) NSDate *deadline;
@property (nullable, nonatomic, retain) NSNumber *is_seen;
@property (nullable, nonatomic, retain) NSString *period;
@property (nullable, nonatomic, retain) NSString *project;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSDate *addtime;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *workid;

@end

NS_ASSUME_NONNULL_END
