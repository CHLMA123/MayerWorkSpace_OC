//
//  DirectionHelper.h
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionModel.h"

@interface DirectionHelper : NSObject

/**
 DirectionHelper 单例

 @return 返回DirectionHelper对象
 */
+ (DirectionHelper *)sharedInstance;

/**
 Direction数据模型
 */
@property (nonatomic, strong) DirectionModel *directionModel;

@end
