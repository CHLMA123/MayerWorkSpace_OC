//
//  UIView+Layout.m
//  WidgetManagerDemo
//
//  Created by MACHUNLEI on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "UIView+Layout.h"
#import <Foundation/Foundation.h>


@implementation UIView (Layout)

- (UIView *(^)(CGRect))mcl_Frame{

    return ^(CGRect rect){
        self.frame = rect;
        return self;
        
    };
}
-(UIView *(^)(id))add
{
    return ^(id obj){
        [self addSubview:obj];
        return self;
    };
}
- (UIView *(^)(UIColor *))mcl_BackgroundColor{

    return ^(UIColor *backgroundColor){
    
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIView *(^)(NSString *))mcl_Text{

    return ^(NSString *text){
    
        UILabel *label = (UILabel *)self;
        label.text = text;
        return label;
    };
}

@end
