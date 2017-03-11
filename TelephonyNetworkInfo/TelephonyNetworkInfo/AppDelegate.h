//
//  AppDelegate.h
//  TelephonyNetworkInfo
//
//  Created by APP210 on 2017/3/11.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

