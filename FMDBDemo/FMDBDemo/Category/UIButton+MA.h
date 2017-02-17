//
//  UIButton+MA.h
//  CoreDataTestDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonSize) {
    ButtonSizeSmall,
    ButtonSizeMedium,
    ButtonSizeLarge,
    ButtonSizeLongest
};

@interface UIButton (MA)

+ (instancetype)GrayBoxesButton:(ButtonSize)btnSize;

@end
