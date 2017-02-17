//
//  ViewController.m
//  NotificationDemo
//
//  Created by MCL on 15/12/25.
//  Copyright © 2015年 MCL. All rights reserved.
//

#import "ViewController.h"

#import "BossViewController.h"
#import "finance.h"
#import "HumanResources.h"

@interface ViewController ()

@property (nonatomic,strong)BossViewController* boss;
@property (nonatomic,strong)finance* finance;
@property (nonatomic,strong)HumanResources* HumanResources;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpView];
}

- (void)setUpView {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:btn];
    btn.backgroundColor =[UIColor blueColor];
    [btn setTitle:@"BOSS" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bossTouchUp) forControlEvents:UIControlEventTouchUpInside];
}

-(void)bossTouchUp{
    
    [BossViewController sendMessage];//类方法调用
    
    //对象必须先要实例化
    _boss  = [[BossViewController alloc] init];
    _finance  = [[finance alloc] init];
    _HumanResources  = [[HumanResources alloc] init];
    
//    [_boss postMessage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
