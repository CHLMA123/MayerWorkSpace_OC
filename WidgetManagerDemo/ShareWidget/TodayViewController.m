//
//  TodayViewController.m
//  ShareWidget
//
//  由于沙盒机制，拓展应用是不允许访问宿主应用的沙盒路径的
//  Created by MCL on 2016/12/27.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding> 

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // CGSize size = [UIScreen mainScreen].bounds.size;
    self.title = @"Hello World";
    self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25];
}

/**
 * 用来设置widget控制器边框间距的方法
 */
// "This method will not be called on widgets linked against iOS versions 10.0 and later."
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


/**
 * 用来设置widget是展开还是折叠状态 可以设置相关preferredContentSize的大小
 */
// The widget may wish to change its preferredContentSize to better accommodate the new display mode.
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
