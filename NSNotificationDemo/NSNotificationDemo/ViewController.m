//
//  ViewController.m
//  NSNotificationDemo
//
//  Created by MACHUNLEI on 2016/11/17.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"ViewController";
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    UIButton *postnotifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postnotifyBtn.frame = CGRectMake(50, 80, [UIScreen mainScreen].bounds.size.width - 100, 50);
    [postnotifyBtn setTitle:@"postnotify" forState:UIControlStateNormal];
    [postnotifyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [postnotifyBtn addTarget:self action:@selector(postnotifyAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postnotifyBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotify:) name:@"Mayernotify" object:nil];
}

#pragma mark - Objective-C 伪继承 与 消息重定向
//// 重写需要转发消息的类A的forwardInvocation方法，以实现将消息转发给能处理fun消息的对象。
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//}

- (void)postnotifyAction1{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Mayernotify" object:nil userInfo:@{@"key":@"value"}];
    ViewControllerA *VCA = [[ViewControllerA alloc] init];
    [self.navigationController pushViewController:VCA animated:YES];
    NSLog(@"Postnotify Action button Down");
}

- (void)receiveNotify:(NSNotification *)notify{

    NSDictionary *dic = (NSDictionary *)notify.userInfo;
    NSString *keyvalue = [dic objectForKey:@"key"];
    NSLog(@"receiveNotify : keyvalue = %@", keyvalue);
    NSLog(@"Receive Notification Finish");
}

/*
 2016-11-17 22:50:54.634 NSNotificationDemo[1878:82254] receiveNotify : keyvalue = value
 2016-11-17 22:50:54.634 NSNotificationDemo[1878:82254] Receive Notification Finish
 2016-11-17 22:50:54.639 NSNotificationDemo[1878:82254] Postnotify Action button Down
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
