//
//  FSUIKit.m
//  WidgetManagerDemo
//
//  Created by MCL on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "FSUIKit.h"

@implementation FSUIKit

#pragma mark - UILable

/** Lable 文字 字号*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize{
    
    return [FSUIKit lableText:text
                     fontSize:fontsize
                    textColor:[UIColor blackColor]
                numberOfLines:1
                textAlignment:NSTextAlignmentLeft
              backgroundColor:[UIColor clearColor]];
}

/** Lable 字色 字号*/
+ (UILabel *)lableTextColor:(UIColor *)textColor
                   fontSize:(CGFloat)fontsize{
    
    return [FSUIKit lableText:nil
                     fontSize:fontsize
                    textColor:textColor
                numberOfLines:1
                textAlignment:NSTextAlignmentLeft
              backgroundColor:[UIColor clearColor]];
}

/** Lable 文字 字号 字色 行数*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize
             textColor:(UIColor *)textColor
         numberOfLines:(NSInteger)numberOfLines{
    
    return [FSUIKit lableText:text
                     fontSize:fontsize
                    textColor:textColor
                numberOfLines:numberOfLines
                textAlignment:NSTextAlignmentLeft
              backgroundColor:[UIColor clearColor]];
}

/** Lable 文字 字号 字色 行数 对齐 背景色*/
+ (UILabel *)lableText:(NSString *)text
              fontSize:(CGFloat)fontsize
             textColor:(UIColor *)textColor
         numberOfLines:(NSInteger)numberOfLines
         textAlignment:(NSTextAlignment)textAlignment
       backgroundColor:(UIColor *)backgroundColor{

    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:fontsize];
    lable.textColor = textColor;
    lable.numberOfLines = numberOfLines;
    lable.textAlignment = textAlignment;
    lable.backgroundColor = backgroundColor;
    
    return lable;
}

#pragma mark --------- ImageView --------

+ (UIImageView *)imageViewWithImage:(UIImage *)image {
    
    return [FSUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image
             userInteractionEnabled:(BOOL)enabled {
    
    return [FSUIKit imageViewWithContentMode:UIViewContentModeScaleToFill userInteractionEnabled:enabled image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                                    image:(UIImage *)image {
    
    return [FSUIKit imageViewWithContentMode:mode userInteractionEnabled:NO image:image];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)mode
                   userInteractionEnabled:(BOOL)enabled
                                    image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.userInteractionEnabled = enabled;
    imageView.image = image;
    return imageView;
}

#pragma mark --------- UIButton --------

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
    
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    return [FSUIKit buttonWithBackgroundColor:backgroundColor titleColor:titleColor titleHighlightColor:titleColor title:title fontSize:size];
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                    titleHighlightColor:(UIColor *)titleHighlightColor
                                  title:(NSString *)title
                               fontSize:(CGFloat)size {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

#pragma mark --------- TableView --------

+ (UITableView *)tableViewWithFrame:(CGRect)frame
                              style:(UITableViewStyle)style
                           delegate:(id)delegate {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.backgroundColor = [UIColor whiteColor];
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    return tableView;
}


@end
