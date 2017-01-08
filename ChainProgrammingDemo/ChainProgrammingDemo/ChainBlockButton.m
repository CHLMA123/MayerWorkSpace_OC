//
//  ChainBlockButton.m
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ChainBlockButton.h"

@implementation ChainBlockButton

- (ChainBlockButton *(^)(NSString *))btnTitle{

    return ^(NSString *titleText){
    
        [self.titleLabel setText:titleText];
        return self;
    };
}

- (ChainBlockButton *(^)(UIImage* , UIControlState))btnBackgroundImg{

    return ^(UIImage *bgImage, UIControlState state){
        
        [self setBackgroundImage:bgImage forState:state];
        return self;
    };
}

- (ChainBlockButton *(^)(UIColor *))btnBackgroundColor{

    return ^(UIColor *color){
    
        [self setBackgroundColor:color];
        return self;
    };
}

- (ChainBlockButton *(^)(CGRect))btnFrame{

    return ^(CGRect rect){
    
        [self setFrame:rect];
        return self;
    };
}

- (ChainBlockButton *(^)(UIView *))btnAddedView{

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
