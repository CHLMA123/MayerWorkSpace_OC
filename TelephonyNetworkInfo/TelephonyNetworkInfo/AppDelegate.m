//
//  AppDelegate.m
//  TelephonyNetworkInfo
//
//  Created by APP210 on 2017/3/11.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取版本消息
#define IOS_Model [[UIDevice currentDevice] model]
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//eg:2.0.0
#define APP_Build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]//eg:165
#define APP_BundleName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define APP_BundleId [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define kMessageCameraID        @"mac"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"Launch sysLanguage =%@,%@,%@,%@,%@",CurrentLanguage ,APP_Version,APP_BundleName,APP_BundleId,APP_Build);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *rootnav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = rootnav;
    [self.window makeKeyAndVisible];
    
    // 注册通知
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else {
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound
         ];
    }

    //NSLog(@"___UserDefaults = %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    [self getDDNSIP];
    return YES;
}

#pragma mark - Push

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //获取设备的deviceToken
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *thisDeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"___deviceToken = %@", thisDeviceToken);
    //f4f26417eba05da185dd9f36ad41114eca8b933c7ed582cc35cbbc6b1d435579
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"___Register Push Error=%@", error.description);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self receivePushMessage:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self receivePushMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)receivePushMessage:(NSDictionary *)userInfo
{
    @synchronized(self){
        
//        if(inBackground || ![FSUserAccountManager isLogin] || [self.arrAllDevices count] ==0){
//            return;
//        }
//        NSString *mac =[userInfo objectForKey:kMessageCameraID];
//        for(int index =0; index <[self.arrAllDevices count]; ++index){
//            
//            CameraModel *cameraModel =self.arrAllDevices[index];
//            if ([cameraModel.cloudModel.deviceMac isEqualToString:mac]) {
//                break;
//            }else if(index +1 ==[self.arrAllDevices count]){
//                return;
//            }
//        }
//        
//        [[MessageManager sharedInstance] saveMessageWithMessageInfo:userInfo];//存储消息，但不更新MessageID
//        
//        if(inForeground){
//            inForeground =NO;
//            double timePush = [[NSDate date] timeIntervalSince1970];
//            if (timePush -timeForeground <0.5) {
//                if ([FSUserAccountManager isLogin]) {
//                    macPush =[userInfo objectForKey:kMessageCameraID];
//                    [self showMainViewController];
//                    return;
//                }
//            }
//        }
//        
//        Message *oneMsg = [[Message alloc] instanceWithDictionary:userInfo];
//        
//        [[ALAlertBannerManager sharedManager] forceHideAllAlertBannersInView:self.window];
//        ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.window style:ALAlertBannerStyleWarning position:ALAlertBannerPositionTop title:oneMsg.title subtitle:oneMsg.content tappedBlock:^(ALAlertBanner *alertBanner) {
//            [alertBanner hide];
//        }];
//        banner.secondsToShow = 5.0;
//        banner.showAnimationDuration = 0.25;
//        banner.hideAnimationDuration = 0.2;
//        [banner show];
//        
//        AudioServicesPlaySystemSound(1012);  //sms提示音
    }
}

- (void)getDDNSIP{
//
//    //根据域名获取ip地址
//    NSString* hostName =@"https://overseas-api.myfoscam.com";
//    
//    const char *hostN= [hostName UTF8String];
//    struct hostent* phot;
//    @try {
//        phot = gethostbyname(hostN);
//        
//    }
//    @catch (NSException *exception) {
//        return ;
//    }
//    
//    struct in_addr ip_addr;
//    memcpy(&ip_addr, phot->h_addr_list[0], 4);
//    char ip[20] = {0};
//    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
//    
//    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
//    NSLog(@"_____strIPAddress %@",strIPAddress);
//    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TelephonyNetworkInfo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
