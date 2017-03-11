//
//  ViewController.m
//  PrensentVCDemo
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"

#import "DirectionViewController.h"
#import "DirectionHelper.h"
#import "DirectionModel.h"
#import "DirectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(pushVCAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setTitle:@"Direction" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showDirections) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    NSArray *itemArr = @[item1, item2];
    
    [self.navigationItem setRightBarButtonItems:itemArr animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    // 新手指引
    DirectionModel *directionModel = [DirectionHelper sharedInstance].directionModel;
    if (directionModel.userLoginDirection) {
        [self showDirections];
        directionModel.userLoginDirection = NO;
    }
}

- (void)pushVCAction{

    NSLog(@"%s", __FUNCTION__);
    PushViewController *push = [[PushViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

- (void)showDirections{

    NSLog(@"%s", __FUNCTION__);
    NSArray *directionViews = @[[SliderDirectionView new], [AddDirectionView new]];
    DirectionViewController *vc = [[DirectionViewController alloc] initWithDirectionViews:directionViews];
    vc.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:vc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
