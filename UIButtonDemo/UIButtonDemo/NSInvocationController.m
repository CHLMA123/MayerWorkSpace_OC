//
//  ViewController.m
//  XRCarouselViewDemo
//
//  Created by 肖睿 on 16/3/17.
//  Copyright © 2016年 肖睿. All rights reserved.
//

#import "NSInvocationController.h"

@interface NSInvocationController ()
@end

@implementation NSInvocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performNSInvocation];//返回值void
    NSString *ret = [self performNSInvocation2];//有返回值
    NSLog(@"%@",ret);
}

/**
 *  在iOS开发中，我们一般会使用以下两种方式去调用一个方法
 (1) [obj methodName];//方式一不能通过方法名字符串来执行方法
 (2) [obj performSelector......];//方式二由于最多只能传递两个参数，所以最后一个参数的值是不准确的
 
 [][]iOS之使用NSInvocation调用方法
 */
- (NSString *)performNSInvocation2{
    
    NSString *methodNameStr = @"test:withArg2:andArg3:";
    SEL selector = NSSelectorFromString(methodNameStr);
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    NSString *arg1 = @"a";
    NSString *arg2 = @"b";
    NSString *arg3 = @"c";
    [invocation setArgument:&arg1 atIndex:2];
    [invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
    
    //5.执行方法
    [invocation invoke];

    //可以在invoke方法前添加，也可以在invoke方法后添加
    //通过方法签名的methodReturnLength判断是否有返回值
    NSString *result = nil;
    if (signature.methodReturnLength > 0) {
        [invocation getReturnValue:&result];
    }
    return result;
}

- (NSString *)test:(NSString *)arg1 withArg2:(NSString *)arg2 andArg3:(NSString *)arg3 {
    NSLog(@"%@---%@---%@", arg1, arg2, arg3);
    return @"haha";
}

- (void)performNSInvocation{
    
    NSString *methodNameStr = @"testvoid:withArg2:andArg3:";
    
    //1.创建一个方法签名 :: 一般使用self来创建方法签名
    /*
     NSMethodSignature有两个常用的只读属性
     a. numberOfArguments:方法参数的个数
     b. methodReturnLength:方法返回值类型的长度，大于0表示有返回值
     
     //NSObject的对象方法，任何继承自NSObject的对象都可以调用
     - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
     //NSObject的类方法，任何继承自NSObject的类都可以调用
     + (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector
     */
    SEL selector = NSSelectorFromString(methodNameStr);
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    //或使用下面这种方式
    //NSMethodSignature *signature1 = [[self class] instanceMethodSignatureForSelector:selector];
    
    //2.使用方法的签名来创建一个NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //只能使用该方法来创建，不能使用alloc init
    
    //3.给invocation的两个属性赋值 :: 要执行谁的（target）的哪个方法（selector）
    invocation.target = self;
    invocation.selector = selector;
    
    //4.给要执行的方法设置参数 :: 使用setArgument:atIndex:方法给要执行的方法设置参数，注意下标从2开始，因为0、1已经被target与selector占用 [设置参数，必须传递参数的地址，不能直接传值]
    NSString *arg1 = @"a";
    NSString *arg2 = @"b";
    NSString *arg3 = @"c";
    [invocation setArgument:&arg1 atIndex:2];
    [invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
    
    //5.执行方法
    [invocation invoke];
}

//要执行的方法
- (void)testvoid:(NSString *)arg1 withArg2:(NSString *)arg2 andArg3:(NSString *)arg3 {
    NSLog(@"%@---%@---%@", arg1, arg2, arg3);
}


@end
