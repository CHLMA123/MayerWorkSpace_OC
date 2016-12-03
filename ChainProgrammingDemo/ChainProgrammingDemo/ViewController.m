//
//  ViewController.m
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "ChainBlockLabel.h"
#import "ChainBlockButton.h"

//#import "NSObject+UILabelLinkBlock.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ChainBlockLabel *lable = ChainBlockLabelNew.lblFrame(CGRectMake(50, 80, self.view.frame.size.width - 100, 45)).lblText(@"我是Lable").lblTextColor([UIColor redColor]).lblNumberOfLines(2).lblTextAlignment(NSTextAlignmentCenter).lblBackgroundColor([UIColor lightGrayColor]).lblAddedView(self.view);
    NSLog(@"%@", lable.text);
    
    ChainBlockButton *button = ChainBlockButtonNew.btnFrame(CGRectMake(50, 135, self.view.frame.size.width - 100, 45)).btnBackgroundColor([UIColor blueColor]).btnTitle(@"我是Button").btnAddedView(self.view);
    NSLog(@"%@", button.titleLabel.text);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
