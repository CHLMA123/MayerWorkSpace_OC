//
//  UIView+Layout.h
//  WidgetManagerDemo
//
//  Created by MACHUNLEI on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (nonatomic, copy) UIView*(^mcl_Frame)(CGRect rect);
@property (nonatomic, copy) UIView*(^mcl_BackgroundColor)(UIColor *backgroundColor);
@property (nonatomic, copy) UIView*(^mcl_Text)(NSString *text);

- (UIView *(^)(id obj))add;

@end
