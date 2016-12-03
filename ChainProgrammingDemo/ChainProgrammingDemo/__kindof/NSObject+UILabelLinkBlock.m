//
//  NSObject+UILabelLinkBlock.m
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "NSObject+UILabelLinkBlock.h"
#import "LinkBlock.h"

@implementation NSObject (UILabelLinkBlock)

/** <^(NSString* text)> */

- (UILabel *(^)(NSString *))lblText{

    return ^(NSString * m_text){
    
        __kindof UILabel *_self = (UILabel *)self;
        _self.text = m_text;
        return _self;
    };
}

/** <^(UIColor* textcolor)> */
- (UILabel *(^)(UIColor*))lblTextColor{

    return ^(UIColor *m_textcolor){
        __kindof UILabel *_self = (UILabel *)self;
        _self.textColor = m_textcolor;
        return _self;
    };
}

/** <^(UIFont* font)> */
- (UILabel *(^)(UIFont*))lblFont{

    return ^(UIFont *m_font){
    
        __kindof UILabel *_self = (UILabel *)self;
        _self.font = m_font;
        return _self;
    };
}

/** <^(CGFloat fontSize)> */
- (UILabel *(^)(CGFloat))lblFontSystemSize{
    
    return ^(CGFloat m_fontsize){
        
        __kindof UILabel *_self = (UILabel *)self;
        _self.font = [UIFont systemFontOfSize:m_fontsize];
        return _self;
    };
}

/** <^(NSInteger lines)> */
- (UILabel *(^)(NSInteger))lblNumberOfLines{

    return ^(NSInteger m_lines){
    
        __kindof UILabel *_self = (UILabel *)self;
        _self.numberOfLines = m_lines;
        return _self;
    };
}

/** <^(NSTextAlignment alighment)> */
- (UILabel *(^)(NSTextAlignment))lblTextAlignment{

    return ^(NSTextAlignment m_alighment){
    
        __kindof UILabel *_self = (UILabel *)self;
        _self.textAlignment = m_alighment;
        return _self;
    };
}

@end
