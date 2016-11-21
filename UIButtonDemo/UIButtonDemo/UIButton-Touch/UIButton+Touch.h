//
//  UIButton+Touch.h
//  UIButtonDemo
//
//  Created by MCL on 2016/11/21.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval .5  //默认时间间隔

@interface UIButton (Touch)

/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;

@end

/*
 iOS点击event分类:
 
 1.连续点击是 执行第一次点击事件，忽略后续点击啊。 2.设置单个按钮不需要hook 3.多次点击按钮，只执行最后一次点击事件
 */
