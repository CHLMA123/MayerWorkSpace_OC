//
//  BlockButton.m
//  UIButtonDemo
//
//  Created by MCL on 2016/11/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickAction{
#warning _block是一个代码块，self是一个button,点击按钮的时候，就会调用按钮实例中相应的_block的实现。
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(changeSelfStatus) withObject:nil afterDelay:2.0];
    _block(self);
}

/*
    Usage: 用户快速点击某个按钮，导致页面重复push或者重复发送网络请求
*/
- (void)changeSelfStatus{

    self.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
