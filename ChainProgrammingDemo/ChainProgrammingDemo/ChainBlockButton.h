//
//  ChainBlockButton.h
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef ChainBlockButtonNew
#define ChainBlockButtonNew ([ChainBlockButton buttonWithType:UIButtonTypeCustom])
#endif

@interface ChainBlockButton : UIButton

- (ChainBlockButton *(^)(NSString *))btnTitle;

- (ChainBlockButton *(^)(UIImage *, UIControlState))btnBackgroundImg;

- (ChainBlockButton *(^)(UIColor *))btnBackgroundColor;

- (ChainBlockButton *(^)(CGRect))btnFrame;

- (ChainBlockButton *(^)(UIView *))btnAddedView;

//- (ChainBlockButton *(^)())


@end
