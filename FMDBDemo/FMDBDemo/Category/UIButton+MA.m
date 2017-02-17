//
//  UIButton+MA.m
//  CoreDataTestDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "UIButton+MA.h"
@implementation UIButton (MA)

+ (instancetype)GrayBoxesButton:(ButtonSize)btnSize
{
    UIImage *imgBtn = nil;
    UIImage *imgBtnHight = nil;
    
    switch (btnSize) {
        case ButtonSizeSmall:
        {
            imgBtn = GetImageByName(@"Button_Small.png");
            imgBtnHight = GetImageByName(@"Button_Small_Hight.png");
        }
            break;
        case ButtonSizeMedium:
        {
            imgBtn = GetImageByName(@"Button_Medium.png");
            imgBtnHight = GetImageByName(@"Button_Medium_Hight.png");
        }
            break;
        case ButtonSizeLarge:
        {
            imgBtn = GetImageByName(@"Button_Large.png");
            imgBtnHight = GetImageByName(@"Button_Large_Hight.png");
        }
            break;
        case ButtonSizeLongest:
        {
            imgBtn = GetImageByName(@"Button_Longest.png");
            imgBtnHight = GetImageByName(@"Button_Longest_Hight.png");
        }
            break;
        default:
        {
            imgBtn = GetImageByName(@"Button_Large.png");
            imgBtnHight = GetImageByName(@"Button_Large_Hight.png");
        }
            break;
    }
    
    UIButton *grayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [grayButton setBackgroundImage:imgBtn forState:UIControlStateNormal];
    [grayButton setBackgroundImage:imgBtnHight forState:UIControlStateSelected];
    [grayButton setBackgroundImage:imgBtnHight forState:UIControlStateHighlighted];
    [grayButton.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [grayButton setTitleColor:RGBCOLOR(120, 120, 120) forState:UIControlStateNormal];
    [grayButton setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateSelected | UIControlStateSelected];
    
    [grayButton setTitleColor:RGBCOLOR(180, 180, 180) forState:UIControlStateDisabled];
    grayButton.frame = CGRectMake(0, 0, imgBtn.size.width, imgBtn.size.height);
    return grayButton;
}

@end
