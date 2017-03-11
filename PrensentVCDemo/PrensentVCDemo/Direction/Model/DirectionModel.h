//
//  DirectionModel.h
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionModel : NSObject

/**
 首次用户登录成功后显示的指引
 */
@property (nonatomic, assign) BOOL userLoginDirection;

/**
 首次设备登录成功后显示的指引
 */
@property (nonatomic, assign) BOOL deviceLoginDirection;

/**
 首次点击更多按钮后显示的指引
 */
@property (nonatomic, assign) BOOL moreButtonDirection;

/**
 首次云录像回放页面显示的指引
 */
@property (nonatomic, assign) BOOL videoPlayDirection;

/**
 首次扫描添加，显示视频
 */
@property (nonatomic, assign) BOOL scanVideoDirection;

/**
 实例化方法

 @param dict 字典
 @return DirectionModel实例对象
 */
- (DirectionModel *)instanceWithDict:(NSDictionary *)dict;

/**
 字典

 @return 返回实例对应字典
 */
- (NSDictionary *)dict;

@end
