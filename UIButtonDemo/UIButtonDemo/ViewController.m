//
//  ViewController.m
//  UIButtonDemo
//
//  Created by MCL on 2016/11/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "OBJC_ASSOCIATIONController.h"
#import "BlockUsageController.h"
#import "BlockTypeController.h"

#import "BlockButton.h"
//#import "UIButton+Delay.h"

NSInteger originalY =  80;

@interface ViewController ()

@property (nonatomic, strong) UIButton *ClickButton1;
@property (nonatomic, strong) UIButton *ClickButton2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self mContinueClickButton1];
    
    [self mContinueClickButton2];
    
    [self mContinueClickButton3];
    
    [self mContinueClickButton4];
    
    [self mContinueClickButton5];
    [self mContinueClickButton6];
}

#pragma mark - iOS防止按钮快速连续点击造成多次响应的方法:
// 规定时间内只执行"最后一次"点击
- (void)mContinueClickButton1{

    _ClickButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _ClickButton1.frame = CGRectMake(50, originalY, 200, 50);
    [_ClickButton1 setTitle:@"ResponseLastClick" forState:UIControlStateNormal];
    [_ClickButton1 addTarget:self action:@selector(mResponseLastClick:) forControlEvents:UIControlEventTouchUpInside];
    _ClickButton1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ClickButton1];
}

- (void)mResponseLastClick:(UIButton*)sender{
    
    [self performSelector:@selector(play::) withObject:@"basketball" withObject:@"ssd"];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(responseLastClickTaskBegin) object:nil];
    [self performSelector:@selector(responseLastClickTaskBegin) withObject:nil afterDelay:5.0];
    // NSLog(@"ResponseLastClick 按钮被点击了");
}


/**
 *  在iOS开发中，我们一般会使用以下两种方式去调用一个方法
 (1) [obj methodName];//方式一不能通过方法名字符串来执行方法
 (2) [obj performSelector...];//方式二由于最多只能传递两个参数，所以最后一个参数的值是不准确的
    iOS之使用NSInvocation调用方法: NSInvocationController
 */
// performSelector 传参
- (void)play:(NSString *)str :(NSString *)str1
{
    // NSLog(@"str = %@,%@",str,str1);
    // 2016-11-21 15:31:30.390 UIButtonDemo[2333:603973] str = basketball,ssd
}

- (void)responseLastClickTaskBegin{
    
    NSLog(@"ResponseLastClick Task Begin");
}
/*
 2016-11-21 15:02:47.537 UIButtonDemo[2284:594716] ResponseLastClick 按钮被点击了
 2016-11-21 15:02:48.070 UIButtonDemo[2284:594716] ResponseLastClick 按钮被点击了
 2016-11-21 15:02:48.736 UIButtonDemo[2284:594716] ResponseLastClick 按钮被点击了
 2016-11-21 15:02:49.253 UIButtonDemo[2284:594716] ResponseLastClick 按钮被点击了
 2016-11-21 15:02:49.786 UIButtonDemo[2284:594716] ResponseLastClick 按钮被点击了
 2016-11-21 15:02:54.787 UIButtonDemo[2284:594716] ResponseLastClick Task Begin
 */

// 规定时间内只执行"第一次"点击
- (void)mContinueClickButton2{
    
    _ClickButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _ClickButton2.frame = CGRectMake(50, originalY+70, 200, 50);
    [_ClickButton2 setTitle:@"ResponseFirstClick" forState:UIControlStateNormal];
    [_ClickButton2 addTarget:self action:@selector(mResponseFirstClick:) forControlEvents:UIControlEventTouchUpInside];
    _ClickButton2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ClickButton2];
}

- (void)mResponseFirstClick:(UIButton*)sender{
    
    sender.enabled = NO;
    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:5.0];
    NSLog(@"ResponseFirstClick 按钮被点击了");
}

- (void)changeButtonStatus{

    self.ClickButton2.enabled = YES;
}
/*
 2016-11-21 14:35:03.863 UIButtonDemo[2259:588774]  ResponseFirstClick 按钮被点击了
 2016-11-21 14:35:08.962 UIButtonDemo[2259:588774]  ResponseFirstClick 按钮被点击了
 2016-11-21 14:35:14.379 UIButtonDemo[2259:588774]  ResponseFirstClick 按钮被点击了
 “在第一次执行响应事件后，5s之内，无论我点击多少次不会响应事件，直到5s走完，我再点击按钮 ，会响应事件，之后3s不再响应事件 ~~~ 依次”
 */

// #import "UIButton+Delay.h"
// 规定时间内只执行"最后一次"点击
- (void)mContinueClickButton3{

    UIButton *delaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delaybtn.frame = CGRectMake(50, originalY+140, 200, 50);
    [delaybtn setTitle:@"UIButton+Delay" forState:UIControlStateNormal];
    [delaybtn addTarget:self action:@selector(doSonmething) forControlEvents:UIControlEventTouchUpInside];
    delaybtn.backgroundColor = [UIColor grayColor];
//    delaybtn.isNeedDelay = YES;
//    delaybtn.delayInterval = 2.0;
    [self.view addSubview:delaybtn];
}

- (void)doSonmething{

    NSLog(@"doSonmething");
}

// #import "BlockButton.h"
// 规定时间内只执行"第一次"点击
- (void)mContinueClickButton4{
    
    BlockButton *blockbtn = [BlockButton buttonWithType:UIButtonTypeCustom];
    blockbtn.frame = CGRectMake(50, originalY+210, 200, 50);
    [blockbtn setTitle:@"BlockButton" forState:UIControlStateNormal];
    blockbtn.backgroundColor = [UIColor grayColor];
#warning 按钮被点击以后，就会调用相应的block实现。
    blockbtn.block = ^(BlockButton *btn){
        NSLog(@"按钮被点击了");
    };
    [self.view addSubview:blockbtn];
}
/*
 2016-11-21 14:54:11.821 UIButtonDemo[2270:592136] 按钮被点击了
 2016-11-21 14:54:13.953 UIButtonDemo[2270:592136] 按钮被点击了
 2016-11-21 14:54:16.053 UIButtonDemo[2270:592136] 按钮被点击了
 */

#pragma mark - 关联传值
- (void)mContinueClickButton5{

    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(50, originalY+280, 200, 50);
    [btn5 setTitle:@"Associated Value" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(AssociatedValue) forControlEvents:UIControlEventTouchUpInside];
    btn5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn5];
}

- (void)AssociatedValue{

    OBJC_ASSOCIATIONController *associationVC = [[OBJC_ASSOCIATIONController alloc] init];
    [self.navigationController pushViewController:associationVC animated:YES];
}

#pragma mark - block Usage
- (void)mContinueClickButton6{
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(50, originalY+350, 200, 50);
    [btn6 setTitle:@"Block Usage" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(blockUsageTest) forControlEvents:UIControlEventTouchUpInside];
    btn6.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn6];
}

- (void)blockUsageTest{
    
    //    BlockUsageController *blockUsageVC = [[BlockUsageController alloc] init];
    BlockTypeController *blockUsageVC = [[BlockTypeController alloc] init];
    [self.navigationController pushViewController:blockUsageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
