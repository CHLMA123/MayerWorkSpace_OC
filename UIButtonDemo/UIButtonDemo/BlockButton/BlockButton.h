//
//  BlockButton.h
//  UIButtonDemo
//
//  Created by MCL on 2016/11/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlockButton;
#warning 声明一个block类型
typedef void(^TouchBlock)(BlockButton *);

@interface BlockButton : UIButton

#warning 全局block要用copy，这样会将block从堆复制到栈里面。
@property (nonatomic, copy) TouchBlock block;

@end
