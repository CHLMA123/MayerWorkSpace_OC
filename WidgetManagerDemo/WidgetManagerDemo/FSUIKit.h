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

#pragma mark --------- UILabel --------

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
#pragma mark --------- UIImageView --------

/** ImageView 图片 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image;

/** ImageView 图片 交互 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
             userInteractionEnabled:(BOOL)enabled;

/** ImageView 填充方式 图片 */
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                                    image:(UIImage *)image;

/** ImageView 填充方式 交互 图片 */
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                   userInteractionEnabled:(BOOL)enabled
                                    image:(UIImage *)image;
#pragma mark --------- UIButton --------

/** UIButton 前景图 */
+ (UIButton *)buttonWithImage:(UIImage *)image;

/** UIButton 背景色 标题色 标题 字号 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size;

/** UIButton 背景色 标题色 标题高亮色 标题 字号 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                    titleHighlightColor:(UIColor *)titleHighlightColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size;

#pragma mark --------- TableView --------

+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id)delegate;


@end
