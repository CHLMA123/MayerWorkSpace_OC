//
//  BlockLabel.m
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ChainBlockLabel.h"

@implementation ChainBlockLabel

/** <^(NSString* text)> */
- (ChainBlockLabel *(^)(NSString *))lblText{

    return ^(NSString *m_text){//返回临时变量的block
    
        if ([self isKindOfClass:[UILabel class]]) {
            
            NSLog(@"label");
        }else
        {
            NSLog(@"no label");
            NSParameterAssert(@"nil label");
        }
        self.text = m_text;//block执行一些功能
        return self;//block执行完毕的返回值
    };
}

/** <^(UIColor* textcolor)> */
- (ChainBlockLabel *(^)(UIColor *))lblTextColor{

    return ^(UIColor *m_textcolor){
        
        self.textColor = m_textcolor;
        return self;
    };
}

/** <^(UIFont* font)> */
- (ChainBlockLabel *(^)(UIFont *))lblFont{

    return ^(UIFont *m_font){
    
        self.font = m_font;
        return self;
    };
}

/** <^(CGFloat fontSize)> */
- (ChainBlockLabel *(^)(CGFloat))lblFontSystemSize{

    return ^(CGFloat m_fontsize){
    
        self.font = [UIFont systemFontOfSize:m_fontsize];
        return self;
    };
}

/** <^(NSInteger lines)> */
- (ChainBlockLabel *(^)(NSInteger))lblNumberOfLines{

    return ^(NSInteger m_lines){
    
        self.numberOfLines = m_lines;
        return self;
    };
}

/** <^(NSTextAlignment alighment)> */
- (ChainBlockLabel *(^)(NSTextAlignment))lblTextAlignment{

    return ^(NSTextAlignment m_alighment){
    
        self.textAlignment = m_alighment;
        return self;
    };
}

- (ChainBlockLabel *(^)(UIColor *))lblBackgroundColor{

    return ^(UIColor *color){
    
        self.backgroundColor = color;
        return self;
    };
}

- (ChainBlockLabel *(^)(CGRect))lblFrame{
    
    return ^(CGRect rect){
        
        self.frame = rect;
        return self;
    };
}

- (ChainBlockLabel *(^)(UIView *))lblAddedView{

    return ^(UIView *superview){
    
        [superview addSubview:self];
        return self;
    };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
