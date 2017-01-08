//
//  BlockLabel.h
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef ChainBlockLabelNew
#define ChainBlockLabelNew ([[ChainBlockLabel alloc]init])
#endif

@interface ChainBlockLabel : UILabel

/** <^(NSString* text)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblText)(NSString *m_text);
/** <^(UIColor* textcolor)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblTextColor)(UIColor *m_textcolor);
/** <^(UIFont* font)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblFont)(UIFont *m_font);
/** <^(CGFloat fontSize)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblFontSystemSize)(CGFloat m_fontsize);
/** <^(NSInteger lines)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblNumberOfLines)(NSInteger m_lines);
/** <^(NSTextAlignment alighment)> */
@property (nonatomic, copy, readonly) ChainBlockLabel *(^lblTextAlignment)(NSTextAlignment m_alighment);

- (ChainBlockLabel *(^)(UIColor *))lblBackgroundColor;

- (ChainBlockLabel *(^)(CGRect))lblFrame;

- (ChainBlockLabel *(^)(UIView *))lblAddedView;

@end
