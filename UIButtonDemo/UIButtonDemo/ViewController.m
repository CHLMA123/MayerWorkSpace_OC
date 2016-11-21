//
//  ViewController.m
//  UIButtonDemo
//
//  Created by MCL on 2016/11/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "BlockButton.h"
#import "UIButton+Delay.h"

typedef int(^MyBlock)(int);

@interface ViewController ()

@property (nonatomic, strong) UIButton *ClickButton1;
@property (nonatomic, strong) UIButton *ClickButton2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    [self blockUsage];
    
    [self mContinueClickButton1];
    
    [self mContinueClickButton2];
    
    [self mContinueClickButton3];
    
    [self mContinueClickButton4];
}

#pragma mark - iOS防止按钮快速连续点击造成多次响应的方法:
// 规定时间内只执行"最后一次"点击
- (void)mContinueClickButton1{

    _ClickButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _ClickButton1.frame = CGRectMake(50, 100, 200, 50);
    [_ClickButton1 setTitle:@"ResponseLastClick" forState:UIControlStateNormal];
    [_ClickButton1 addTarget:self action:@selector(mResponseLastClick:) forControlEvents:UIControlEventTouchUpInside];
    _ClickButton1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ClickButton1];
}

- (void)mResponseLastClick:(UIButton*)sender{
    
    [self performSelector:@selector(play::) withObject:@"basketball" withObject:@"ssd"];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(responseLastClickTaskBegin) object:nil];
    [self performSelector:@selector(responseLastClickTaskBegin) withObject:nil afterDelay:5.0];
    NSLog(@"ResponseLastClick 按钮被点击了");
}

// performSelector 传参
- (void)play:(NSString *)str :(NSString *)str1
{
    NSLog(@"str = %@,%@",str,str1);
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
    _ClickButton2.frame = CGRectMake(50, 170, 200, 50);
    [_ClickButton2 setTitle:@"ResponseFirstClick" forState:UIControlStateNormal];
    [_ClickButton2 addTarget:self action:@selector(mResponseFirstClick:) forControlEvents:UIControlEventTouchUpInside];
    _ClickButton2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ClickButton2];
}

- (void)mResponseFirstClick:(UIButton*)sender{
    
    sender.enabled = NO;
    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:5.0];
    NSLog(@" ResponseFirstClick 按钮被点击了");
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

    UIButton *blockbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blockbtn.frame = CGRectMake(50, 240, 200, 50);
    [blockbtn setTitle:@"UIButton+Delay" forState:UIControlStateNormal];
    [blockbtn addTarget:self action:@selector(doSonmething) forControlEvents:UIControlEventTouchUpInside];
    blockbtn.backgroundColor = [UIColor grayColor];
    blockbtn.isNeedDelay = YES;
    blockbtn.delayInterval = 2.0;
    [self.view addSubview:blockbtn];
}

- (void)doSonmething{

    NSLog(@"doSonmething");
}

// #import "BlockButton.h"
// 规定时间内只执行"第一次"点击
- (void)mContinueClickButton4{
    
    BlockButton *blockbtn = [BlockButton buttonWithType:UIButtonTypeCustom];
    blockbtn.frame = CGRectMake(50, 310, 200, 50);
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
#pragma mark - block Usage
- (void)blockUsage{

    //---------------------Block的声明----------------------
//#warning Block的声明
//    int(^myBlock)(int);
//#warning 创建block，这里不会执行block
//    myBlock = ^(int a){
//        NSLog(@"参数：%d",a);
//        return 10;
//    };
//#warning 调用block，这里会执行block
//    int ret = myBlock(20);
//    NSLog(@"返回结果是%d", ret);
    
    //--------------------MyBlock类型的对象--------------------------
//#warning 申明一个MyBlock类型的对象
//    MyBlock test = ^(int a){
//        int result = a * a;
//        NSLog(@"%d",result);
//        return result;
//    };
//    test(10);
    
    //----------------------block作为参数传递-------------------------
//    MyBlock myblock = ^(int a)
//    {
//        NSLog(@"这是block代码块a = %d",a);
//        return a*a;
//    };
//
//    [self testBlock:myblock];
    
    //------------------------block引用局部变量---------------------------------
//    int number = 20;
//    __block int number1 = 10;
//    MyBlock myblock2 = ^(int a){
//#warning 局部变量在block中是不可以修改的，只能作为常量使用。__block修饰的局部变量可以修改
//        NSLog(@"局部变量值%d",number);
//        number1 = number1 + 5;
//        NSLog(@"可以修改的局部变量%d",number1);
//        return 10*a;
//    };
//#warning block调用__block局部变量的值是此时局部变量中存的值。在block中对局部变量的修改在block以外也有用。指向的都是一个值。
//    number = 25; //没有__block修饰的局部变量的修改，对block中没有影响，相当于block复制了一份。
//    number1 = 35;
//    myblock2(5);
    
}

#warning block作为参数
-(void)testBlock:(MyBlock)myBlock{
#warning 这里就是block的回调，调用其他地方实现的代码。实际上是调用代码实现的首地址
    int  a = myBlock(10);
    NSLog(@"block返回值%d", a);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
