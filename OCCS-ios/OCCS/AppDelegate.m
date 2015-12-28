//
//  AppDelegate.m
//  OCCS
//
//  Created by Gennie Sun on 15/7/24.
//  Copyright (c) 2015年 Leader. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "LDLoginViewController.h"
#import "LDJPushHelper.h"
#import "LDMyMessageViewController.h"
#import "LDCertificationViewController.h"
#import "AdWebViewController.h"
#import "DatabaseHelper.h"
#import "PushRouter.h"
#import "PushNote.h"

@interface AppDelegate ()<TabBarViewDelegate,UITabBarControllerDelegate>
{
    NSArray *controllers;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //register notifications
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)]) // ios 8
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
    }
    else // ios 7
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    [DEF_NOTIFICATION addObserver:self selector:@selector(showHUD:) name:DEF_SHOWHIDEHUD object:nil];
    
    AdWebViewController *adWebview = [[AdWebViewController alloc] init];
    self.window.rootViewController = adWebview;
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDialog:) name:@"activeAlert" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showModalView:) name:@"pupModalView" object:nil];
    return YES;
}

- (void)showModalView:(NSNotification *)notification
{
    NSString *type = ((NSDictionary *)notification.userInfo)[@"type"];
    if ([type isEqualToString:@"特殊页面"]) {
        NSDictionary *json = (NSDictionary *)notification.object;
        NSString *url = [[NSString alloc] initWithFormat:@"http://%@/?name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                         json[@"url"],[Person getInstance].name,[Person getInstance].key,[Person getInstance].mobile,[Person getInstance].typeNumber, [Person getInstance].email];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        LDWebViewController *webVC = [[LDWebViewController alloc] initWithFrame:self.window.frame url:url title:@"网页浏览"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            }];
        }else{
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
    
    if ([type isEqualToString:@"模板1"]) {
        PushNote *note = (PushNote *)notification.object;
        NSString *baseUrl = DEF_PAGE_TEMPLATE1;
        NSString *url = [[NSString alloc] initWithFormat:@"%@?id=%@&name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                         baseUrl, note.note_id,[Person getInstance].name,[Person getInstance].key,[Person getInstance].mobile,[Person getInstance].typeNumber, [Person getInstance].email];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        LDWebViewController *webVC = [[LDWebViewController alloc] initWithFrame:self.window.frame url:url title:@"网页浏览"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            }];
        }else{
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
    
    if ([type isEqualToString:@"个人账户"]) {
        NSString *baseUrl = DEF_PAGE_ACCOUNT;
        NSString *url = [[NSString alloc] initWithFormat:@"%@?name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                         baseUrl,[Person getInstance].name,[Person getInstance].key,[Person getInstance].mobile,[Person getInstance].typeNumber, [Person getInstance].email];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        LDWebViewController *webVC = [[LDWebViewController alloc] initWithFrame:self.window.frame url:url title:@"网页浏览"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            }];
        }else{
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
    
    if ([type isEqualToString:@"个人信息"]) {
        PersonInfoViewController *perVC = [[PersonInfoViewController alloc] initWithNibName:@"PersonInfoViewController" bundle:nil];
        perVC.delegate = self;
        perVC.orgImg = [self.leftSideDrawerViewController.photoBtn backgroundImageForState:0];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:perVC];
        if (self.window.rootViewController.presentedViewController) {
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            }];
        }else{
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
    
    if ([type isEqualToString:@"推送工单详情"]) {
        NSLog(@"推送工单详情");
        NSString *workid = (NSString *)notification.object[@"workid"];
        NSString *baseUrl = DEF_PAGE_SINGLEGONGDAN;
        NSString *url = [[NSString alloc] initWithFormat:@"%@?workid=%@&name=%@&key=%@&phoneNum=%@&typeNum=%d&email=%@",
                         baseUrl, workid,[Person getInstance].name,[Person getInstance].key,[Person getInstance].mobile,[Person getInstance].typeNumber, [Person getInstance].email];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        LDWebViewController *webVC = [[LDWebViewController alloc] initWithFrame:self.window.frame url:url title:@"工单详情"];
        if (self.window.rootViewController.presentedViewController) {
            if ([self.window.rootViewController.presentedViewController respondsToSelector:@selector(pushViewController:animated:)]) {
                UINavigationController *nav = (UINavigationController *)self.window.rootViewController.presentedViewController;
                if ([nav.title isEqualToString:@"工单详情"]) {
                    [nav popToRootViewControllerAnimated:NO];
                }
                [nav pushViewController:webVC animated:YES];
            }
        }else{
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
}

- (void)dismissSelfVC{
    if ([self.window.rootViewController.presentedViewController respondsToSelector:@selector(pushViewController:animated:)]) {
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController.presentedViewController;
        if (nav.viewControllers.count > 1) {
            [nav popViewControllerAnimated:YES];
        }else{
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)showDialog:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.object;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCCS消息推送"
                                                     message:userInfo[@"message"]
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [PushRouter afterAction];
    }
}

- (void) showLoginVc
{
    LDLoginViewController *loginViewController = [[LDLoginViewController alloc] initWithNibName:@"LDLoginViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navi.navigationBar.hidden = YES;
    self.window.rootViewController = navi;
}


- (void)showMainViewController
{
    self.leftSideDrawerViewController = [[MMLeftDrawerViewController alloc] init];
    
    // 请根据实际情况替换以下ViewController
    LDMyMessageViewController *controller1 = [[LDMyMessageViewController alloc] init];
    MMCenterViewController * controller2 = [[MMCenterViewController alloc] init];
    LDCertificationViewController *controller3 = [[LDCertificationViewController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:controller1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:controller2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:controller3];
    
    controllers = [[NSArray alloc] initWithObjects:nav1, nav2,nav3, nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = controllers;

    [self.tabBarController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    UINavigationController * leftSideNavController = [[UINavigationController alloc] initWithRootViewController:self.leftSideDrawerViewController];
    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:self.tabBarController leftDrawerViewController:leftSideNavController];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:270];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    
    _navi = [[UINavigationController alloc] initWithRootViewController:self.drawerController];
    _navi.navigationBarHidden = YES;
    self.window.rootViewController = _navi;
    
    _tabBar = [[TabBarView alloc] initWithFrame:CGRectMake(0 , DEF_SCREEN_HEIGHT - DEF_TABBAR_HEIGHT, DEF_SCREEN_WIDTH, DEF_TABBAR_HEIGHT)];
    _tabBar.delegate = self;
    _tabBarController.hidesBottomBarWhenPushed= YES;
    [self.tabBarController.view addSubview:_tabBar];
    [self.window makeKeyAndVisible];
}


- (void)tabBarView:(TabBarView *)tabBarView didSelectAtIndex:(NSInteger)indexTip
{
    NSLog(@"%ld",(long)indexTip);
    if (indexTip == 100)
    {
        self.tabBarController.selectedIndex = 0;
    }
    else if (indexTip == 101)
    {
        self.tabBarController.selectedIndex = 1;
    }
    else if (indexTip == 102)
    {
        self.tabBarController.selectedIndex = 2;
    }
}



- (void) showHUD:(NSNotification *)not
{
    NSString *str = not.object;
    if ([str isEqualToString:@"show"])
    {
        [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    }
    else if ([str isEqualToString:@"hide"])
    {
        [MBProgressHUD hideAllHUDsForView:self.window animated:YES];
    }
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviectoken");
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
// IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  )
    {
        //opened from a push notification when the app was on background
        [PushRouter receiveNoteWhenInactive:userInfo];
    }else{
        //opened from a push notification when the app was forground
        [PushRouter receiveNoteWhenActive:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.LDSoft.OCCSDatabase" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OCCSDatabase" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OCCSDatabase.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
