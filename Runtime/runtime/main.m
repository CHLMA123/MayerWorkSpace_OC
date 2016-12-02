//
//  main.m
//  runtime
//
//  Created by 张星宇 on 16/1/2.
//  Copyright © 2016年 张星宇. All rights reserved.
//

/*
 Objective-C不支持多继承，因为消息机制名字查找发生在运行时而非编译时，很难解决多个基类可能导致的二义性问题。
 不过其实 Objective-C 也无需支持多继承，我们可以找到如下几种间接实现多继承目的的方法：
 
 消息转发
 delegate和protocol
 类别
 */

#import <Foundation/Foundation.h>

#import "MethodForwardTest.h"
#import "MethodSwizzlingTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /*
         消息转发
         
         当向someObject发送某消息，但runtime system在当前类和父类中都找不到对应方法的实现时，runtime system并不会立即报错使程序崩溃，而是依次执行下列步骤：消息转发模型.png
         分别简述一下流程：
         
         1.动态方法解析
         向当前类发送 resolveInstanceMethod: 信号，检查是否动态向该类添加了方法。（迷茫请搜索：@dynamic）
         2.快速消息转发
         检查该类是否实现了 forwardingTargetForSelector: 方法，若实现了则调用这个方法。若该方法返回值对象非nil或非self，则向该返回对象重新发送消息。
         3.标准消息转发
         runtime发送methodSignatureForSelector:消息获取Selector对应的方法签名。返回值非空则通过forwardInvocation:转发消息，返回值为空则向当前对象发送doesNotRecognizeSelector:消息，程序崩溃退出。
         
         顾名思义，我们可以利用上述过程中的2、3两种方式来完成消息转发。
         */
        
        MethodForwardTest *methodForward = [[MethodForwardTest alloc] init];
        [methodForward test];  // test 方法只有定义没有实现，需要进行消息转发
        
//        MethodSwizzlingTest *methodSwizzling = [[MethodSwizzlingTest alloc] init];
//        [methodSwizzling test];  // 演示Method Swizzling的实现
    }
    return 0;
}

