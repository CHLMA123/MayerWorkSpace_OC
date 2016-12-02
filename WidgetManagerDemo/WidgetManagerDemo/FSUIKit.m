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

@end
