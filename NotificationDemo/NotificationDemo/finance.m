//
//  finance.m
//  NotificationDemo
//
//  Created by MCL on 15/12/25.
//  Copyright © 2015年 MCL. All rights reserved.
//

#import "finance.h"

@implementation finance
-(instancetype)init{
    
    self = [super init];
    if (self) {
        //xian在通知中心注册，确定要接受谁的消息，（登陆论坛，关注老板）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomthing:) name:@"boss" object:nil];
    }
    return self;
}

-(void)doSomthing:(NSNotification *)notification
{
    //接受消息，（从论坛上看到啦boss的消息）
    NSDictionary *bossInfo = [notification userInfo];
    //输出收到的信息
    NSLog(@"finance部门收到：%@", bossInfo[@"notification"]);
}

/**
 1.注册为观察者相当于各部门要在内部论坛注册并关注老板，在关注老板的同时指定当老板发送通知时自己要做些什么事儿
 
 ​ 2.doSomething里是各部门要做的事情
 */

@end
