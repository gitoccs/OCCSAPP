//
//  AppDelegate.h
//  OCCS
//
//  Created by Gennie Sun on 15/7/24.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMDrawerController.h"
#import "MMCenterViewController.h"
#import "MMLeftDrawerViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "TabBarView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, NotificationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong) UINavigationController * navi;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) TabBarView *tabBar;
@property (nonatomic, strong) MMLeftDrawerViewController *leftSideDrawerViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)showMainViewController;
- (void) showLoginVc;
- (void)tabBarView:(TabBarView *)tabBarView didSelectAtIndex:(NSInteger)indexTip;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end

