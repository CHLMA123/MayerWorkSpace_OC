//
//  NSObject+UILabelLinkBlock.h
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef UILabelNew
#define UILabelNew ([[UILabel alloc]init])
#endif

@interface NSObject (UILabelLinkBlock)

/** <^(NSString* text)> */
@property (nonatomic, copy, readonly) UILabel *(^lblText)(NSString *m_text);
/** <^(UIColor* textcolor)> */
@property (nonatomic, copy, readonly) UILabel *(^lblTextColor)(UIColor *m_textcolor);
/** <^(UIFont* font)> */
@property (nonatomic, copy, readonly) UILabel *(^lblFont)(UIFont *m_font);
/** <^(CGFloat fontSize)> */
@property (nonatomic, copy, readonly) UILabel *(^lblFontSystemSize)(CGFloat m_fontsize);
/** <^(NSInteger lines)> */
@property (nonatomic, copy, readonly) UILabel *(^lblNumberOfLines)(NSInteger m_lines);
/** <^(NSTextAlignment alighment)> */
@property (nonatomic, copy, readonly) UILabel *(^lblTextAlignment)(NSTextAlignment m_alighment);


@end
