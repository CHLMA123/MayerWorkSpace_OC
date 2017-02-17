//
//  BossViewController.m
//  NotificationDemo
//
//  Created by MCL on 15/12/25.
//  Copyright © 2015年 MCL. All rights reserved.
//

#import "BossViewController.h"

@implementation BossViewController

+(void)sendMessage{

    //把要发送的信息放入字典中(boss要在论坛中说的话)
    NSDictionary *msg =@{@"notification":@"类方法！"};
    //创建通知对象（老板登陆boss账号）
    NSNotification *notification = [NSNotification notificationWithName:@"boss" object:self userInfo:msg];
    //向通知中心发送消息（发布消息）
    [[NSNotificationCenter defaultCenter] postNotification:notification];

    /**
     1.老板要发的消息要放在字典中才能发布，字典的key是帖子的主题，value是帖子的内容
     
​    ​ ​2.创建通知对象就好比老板登陆内部论坛，用notificationWithName设置老板的昵称

​    ​ 3.向通知中心发送消息就是老板发帖啦
     */
}
-(void)postMessage{

    //把要发送的信息放入字典中(boss要在论坛中说的话)
    NSDictionary *msg =@{@"notification":@"实例方法！"};
    //创建通知对象（老板登陆boss账号）
    NSNotification *notification = [NSNotification notificationWithName:@"boss" object:self userInfo:msg];
    //向通知中心发送消息（发布消息）
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    /**
     1.老板要发的消息要放在字典中才能发布，字典的key是帖子的主题，value是帖子的内容
     
     ​    ​ ​2.创建通知对象就好比老板登陆内部论坛，用notificationWithName设置老板的昵称
     
     ​    ​ 3.向通知中心发送消息就是老板发帖啦
     */

}

@end
