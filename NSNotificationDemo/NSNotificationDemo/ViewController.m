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

@property (nonatomic, strong) NSString *strongString;

@property (nonatomic, copy) NSString *copyedString;

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
    [self test];
}

/*
 对源头是NSMutableString的字符串，retain仅仅是指针引用，增加了引用计数器，这样源头改变的时候，用这种retain方式声明的变量（无论被赋值的变量是可变的还是不可变的），它也会跟着改变;而copy声明的变量，它不会跟着源头改变，它实际上是深拷贝。
 
 对源头是NSString的字符串，无论是retain声明的变量还是copy声明的变量，当第二次源头的字符串重新指向其它的地方的时候，它还是指向原来的最初的那个位置，也就是说其实二者都是指针引用，也就是浅拷贝。
 
 另外说明一下，这两者对内存计数的影响都是一样的，都会增加内存引用计数，都需要在最后的时候做处理。
 
 其实说白了，对字符串为啥要用这两种方式？我觉得还是一个安全问题，比如声明的一个NSString *str变量，然后把一个NSMutableString *mStr变量的赋值给它了，如果要求str跟着mStr变化，那么就用retain;如果str不能跟着mStr一起变化，那就用copy。而对于要把NSString类型的字符串赋值给str，那两都没啥区别。不会影响安全性，内存管理也一样。
 */
- (void)test {
    
    NSString *string = [NSString stringWithFormat:@"abc"];
    self.strongString = string;
    self.copyedString = string;
    
    NSLog(@"origin string: %p, %p", string, &string);
    NSLog(@"strong string: %p, %p", _strongString, &_strongString);
    NSLog(@"copy   string: %p, %p", _copyedString, &_copyedString);
    /*
     2016-11-19 16:01:18.440 NSNotificationDemo[2001:480691] origin string: 0x14533b20, 0x171394
     2016-11-19 16:01:18.441 NSNotificationDemo[2001:480691] strong string: 0x14533b20, 0x14622b5c
     2016-11-19 16:01:18.441 NSNotificationDemo[2001:480691] copy   string: 0x14533b20, 0x14622b60
     这种情况下，不管是strong还是copy属性的对象，其指向的地址都是同一个，即为string指向的地址。
     */
    
    NSMutableString *string2 = [NSMutableString stringWithFormat:@"abc"];
    self.strongString = string2;
    self.copyedString = string2;
    
    NSLog(@"origin string: %p, %p", string2, &string2);
    NSLog(@"strong string: %p, %p", _strongString, &_strongString);
    NSLog(@"copy   string: %p, %p", _copyedString, &_copyedString);
    /*
     2016-11-19 16:05:34.595 NSNotificationDemo[2004:481441] origin string: 0x14e5a580, 0x215390
     2016-11-19 16:05:34.596 NSNotificationDemo[2004:481441] strong string: 0x14e5a580, 0x14e6376c
     2016-11-19 16:05:34.597 NSNotificationDemo[2004:481441] copy   string: 0x14e5a5a0, 0x14e63770
     此时copy属性字符串已不再指向string字符串对象，而是深拷贝了string字符串，并让_copyedString对象指向这个字符串。
     此时，我们如果去修改string字符串的话，可以看到：因为_strongString与string是指向同一对象，所以_strongString的值也会跟随着改变(需要注意的是，此时_strongString的类型实际上是NSMutableString，而不是NSString)；而_copyedString是指向另一个对象的，所以并不会改变。
     */
}


#pragma mark - Objective-C 伪继承 与 消息重定向
//// 重写需要转发消息的类A的forwardInvocation方法，以实现将消息转发给能处理fun消息的对象。
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//}

- (void)postnotifyAction1{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Mayernotify" object:nil userInfo:@{@"key":@"value"}];
    ViewControllerA *VCA = [[ViewControllerA alloc] init];
    //    [self.navigationController pushViewController:VCA animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VCA];
    [self presentViewController:nav animated:YES completion:^{
        NSLog(@"Postnotify Action button Down");
    }];
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
