//
//  FSUIKit.h
//  WidgetManagerDemo
//
//  Created by MCL on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FSUIKit : NSObject

#pragma mark - UILable

/** Lable 文字 字号*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize;

/** Lable 字色 字号*/
+ (UILabel *)lableTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)fontsize;

/** Lable 文字 字号 字色 行数*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize
             textColor:(UIColor *)textColor
         numberOfLines:(NSInteger)numberOfLines;

/** Lable 文字 字号 字色 行数 对齐 背景色*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize
             textColor:(UIColor *)textColor
         numberOfLines:(NSInteger)numberOfLines
         textAlignment:(NSTextAlignment)textAlignment
       backgroundColor:(UIColor *)backgroundColor;

//+ (void)make:(id)first,...NS_REQUIRES_NIL_TERMINATION;
#pragma mark - UIImageView

//+ (UIImageView *)




@end
