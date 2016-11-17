//
//  ViewControllerA.m
//  NSNotificationDemo
//
//  Created by MACHUNLEI on 2016/11/17.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "ViewControllerA.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ViewControllerA";
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    UIButton *postnotifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postnotifyBtn.frame = CGRectMake(50, 80, [UIScreen mainScreen].bounds.size.width - 100, 50);
    [postnotifyBtn setTitle:@"NSNotificationQueue" forState:UIControlStateNormal];
    [postnotifyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [postnotifyBtn addTarget:self action:@selector(postnotifyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postnotifyBtn];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerNotifyAction:) name:@"postnotify1" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerNotifyAction:) name:nil object:nil];
    //  UINavigationControllerWillShowViewControllerNotification +
    //  UIViewAnimationDidCommitNotification
}

- (void)triggerNotifyAction:(NSNotification *)notify{
    NSLog(@"notify.name = %@",notify.name);
    NSDictionary *dic = (NSDictionary *)notify.userInfo;
    NSString *keyvalue = [dic objectForKey:@"key"];
    NSLog(@"receiveNotify : keyvalue = %@", keyvalue);
    NSLog(@"Receive Notification Finish");
    
}

- (void)postnotifyAction{

    NSNotification *nofifyqueue1 = [NSNotification notificationWithName:@"postnotify1" object:@"1" userInfo:@{@"key":@"value1"}];
    [[NSNotificationQueue defaultQueue] enqueueNotification:nofifyqueue1 postingStyle:NSPostASAP];
    NSLog(@"添加postnotify1");
    NSNotification *nofifyqueue2 = [NSNotification notificationWithName:@"postnotify1" object:@"2" userInfo:@{@"key":@"value2"}];
    [[NSNotificationQueue defaultQueue] enqueueNotification:nofifyqueue2 postingStyle:NSPostASAP];
    NSLog(@"添加postnotify2");
    sleep(5);
    NSLog(@"NSNotificationQueue 添加结束");
}

/*
 2016-11-17 22:49:30.704 NSNotificationDemo[1858:81099] 添加postnotify1
 2016-11-17 22:49:30.704 NSNotificationDemo[1858:81099] 添加postnotify2
 2016-11-17 22:49:35.777 NSNotificationDemo[1858:81099] NSNotificationQueue 添加结束
 2016-11-17 22:49:35.778 NSNotificationDemo[1858:81099] receiveNotify : keyvalue = value1
 2016-11-17 22:49:35.778 NSNotificationDemo[1858:81099] Receive Notification Finish
 2016-11-17 22:49:35.779 NSNotificationDemo[1858:81099] receiveNotify : keyvalue = value2
 2016-11-17 22:49:35.779 NSNotificationDemo[1858:81099] Receive Notification Finish
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 向通告队列发送通告可以有三种风格：NSPostASAP、NSPostWhenIdle、和NSPostNow，这些风格将在接下来的部分中进行说明。
 
 尽快发送
 
 以NSPostASAP风格进入队列的通告会在运行循环的当前迭代完成时被发送给通告中心，如果当前运行循环模式和请求的模式相匹配的话（如果请求的模式和当前模式不同，则通告在进入请求的模式时被发出）。由于运行循环在每个迭代过程中可能进行多个调用分支（callout），所以在当前调用分支退出及控制权返回运行循环时，通告可能被分发，也可能不被分发。其它的调用分支可能先发生，比如定时器或由其它源触发了事件，或者其它异步的通告被分发了。
 
 您通常可以将NSPostASAP风格用于开销昂贵的资源，比如显示服务器。如果在运行循环的一个调用分支过程中有很多客户代码在窗口缓冲区中进行描画，在每次描画之后将缓冲区的内容刷新到显示服务器的开销是很昂贵的。在这种情况下，每个draw...方法都会将诸如“FlushTheServer” 这样的通告排入队列，并指定按名称和对象进行聚结，以及使用NSPostASAP风格。结果，在运行循环的最后，那些通告中只有一个被派发，而窗口缓冲区也只被刷新一次。
 
 空闲时发送
 
 以NSPostWhenIdle风格进入队列的通告只在运行循环处于等待状态时才被发出。在这种状态下，运行循环的输入通道中没有任何事件，包括定时器和异步事件。以NSPostWhenIdle风格进入队列的一个典型的例子是当用户键入文本、而程序的其它地方需要显示文本字节长度的时候。在用户输入每一个字符后都对文本输入框的尺寸进行更新的开销是很大的（而且不是特别有用），特别是当用户快速输入的时候。在这种情况下，Cocoa会在每个字符键入之后，将诸如“ChangeTheDisplayedSize”这样的通告进行排队，同时把聚结开关打开，并使用NSPostWhenIdle风格。当用户停止输入的时候，队列中只有一个“ChangeTheDisplayedSize”通告（由于聚结的原因）会在运行循环进入等待状态时被发出，显示部分也因此被刷新。请注意，运行循环即将退出（当所有的输入通道都过时的时候，会发生这种情况）时并不处于等待状态，因此也不会发出通告。
 
 立即发送
 
 以NSPostNow风格进入队列的通告会在聚结之后，立即发送到通告中心。您可以在不需要异步调用行为的时候 使用NSPostNow风格（或者通过NSNotificationCenter的postNotification:方法来发送）。在很多编程环境下，我们不仅允许同步的行为，而且希望使用这种行为：即您希望通告中心在通告派发之后返回，以便确定观察者对象收到通告并进行了处理。当然，当您希望通过聚结移除队列中类似的通告时，应该用enqueueNotification...方法，且使用NSPostNow风格，而不是使用postNotification:方法。
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
