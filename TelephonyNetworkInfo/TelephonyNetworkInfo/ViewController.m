//
//  ViewController.m
//  TelephonyNetworkInfo
//
//  Created by APP210 on 2017/3/11.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self telephonyNetworkInfo];
    [self isOpenRemoteNotify];
}

#pragma mark - 检测SIM卡信息
- (void)telephonyNetworkInfo{
    
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode) {
        
        NSLog(@"iosVersion = %f,no SIM",IOS_VERSION);
    }else{
        
        NSString *mobile = [carrier carrierName];
        NSString *mobileCountryCode = [carrier mobileCountryCode];
        NSString *mobileNetworkCode = [carrier mobileNetworkCode];
        NSString *isoCountryCode = [carrier isoCountryCode];
        BOOL allowsVOIP = [carrier allowsVOIP];
        
        NSLog(@"iosVersion = %f, mobile = %@, mobileCountryCode = %@, mobileNetworkCode = %@, isoCountryCode = %@, allowsVOIP = %d",IOS_VERSION,mobile,mobileCountryCode,mobileNetworkCode,isoCountryCode,allowsVOIP);
    }
}

#pragma mark - 检测接受远程通知是否打开
- (void)isOpenRemoteNotify
{
    if(IOS_VERSION >= 8.0f ){
        
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            NSLog(@"RemoteNotify Open");
            return;
        }
    }
    else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            NSLog(@"RemoteNotify Open");
        return;
    }
    NSLog(@"RemoteNotify Close");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
