//
//  MACommon.h
//  CoreDataTestDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef MACommon_h
#define MACommon_h

#define GetImageByName(x) [UIImage imageNamed:x]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#endif /* MACommon_h */
