//
//  ViewController.m
//  CFConvertOCDemo
//
//  Created by MCL on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     ARC下的内存管理:
     
     ARC的诞生大大简化了我们针对内存管理的开发工作，但是只支持管理 Objective-C 对象, 不支持 Core Foundation 对象。Core Foundation 对象必须使用CFRetain和CFRelease来进行内存管理。那么当使用Objective-C 和 Core Foundation 对象相互转换的时候，必须让编译器知道，到底由谁来负责释放对象，是否交给ARC处理。只有正确的处理，才能避免内存泄漏和double free导致程序崩溃。
     
     根据不同需求，有3种转换方式
     
     __bridge 							                	（不改变对象所有权）
     
     __bridge_retained 或者 CFBridgingRetain()              	（解除 ARC 所有权）
     
     __bridge_transfer 或者 CFBridgingRelease()            	（给予 ARC 所有权）
     */
    
    
    /*
     1. __bridge_retained 或者 CFBridgingRetain()
     
     __bridge_retained 或者 CFBridgingRetain()  将Objective-C对象转换为Core Foundation对象，把对象所有权桥接给Core Foundation对象，同时剥夺ARC的管理权，后续需要开发者使用CFRelease或者相关方法手动来释放对象。
     
     来看个例子：
     */
    NSString *cOCString = [NSString stringWithFormat:@"test1"];
    //CFStringRef cCFString = (__bridge_retained CFStringRef)cOCString;
    CFStringRef cCFString = (CFStringRef)CFBridgingRetain(cOCString);
    //CFBridgingRetain()  是 __bridge_retained 的宏方法，shang面两行代码等价
    (void)cCFString;
    // 正确的做法应该执行CFRelease
    //CFRelease(cCFString);//程序没有执行CFRelease，造成内存泄漏
    
    
    /*
     2. __bridge_transfer 或者 CFBridgingRelease()
     
     __bridge_transfer 或者 CFBridgingRelease()  将非Objective-C对象转换为Objective-C对象，同时将对象的管理权交给ARC，开发者无需手动管理内存。
     
     接着上面那个内存泄漏的例子，再转成OC对象交给ARC来管理内存，无需手动管理，也不会出现内存泄漏：
     */
    //CFBridgingRelease() 是__bridge_transfer的宏方法，下面两行代码等价：
    cOCString = (NSString *)CFBridgingRelease(cCFString);
    // cOCString = (__bridge_transfer NSString *)cCFString;
    (void)cOCString;
    
    
    /*
     3. __bridge
     
     __bridge 只做类型转换，不改变对象所有权，是我们最常用的转换符。
     */
    
    // 从OC转CF，ARC管理内存：
    NSString *aOCString = [NSString stringWithFormat:@"%@",@"123"];
    CFStringRef aCFString = (__bridge CFStringRef)aOCString;
    (void)aCFString;
    
    // 从CF转OC，需要开发者手动释放，不归ARC管：
    CFStringRef bCFString = CFStringCreateWithCString(CFAllocatorGetDefault(), "test", kCFStringEncodingASCII);
    NSString *bOCString = (__bridge NSString*)bCFString;
    (void)bOCString;
    CFRelease(bCFString);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
