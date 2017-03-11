//
//  DirectionView.h
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectionView : UIView

@property (nonatomic, strong) UILabel *tipsLabel;

@end

/**
 右滑提示视图
 */
@interface SliderDirectionView : DirectionView

@end

/**
 设备添加提示视图
 */
@interface AddDirectionView : DirectionView

@end

/**
 视频播放缩放提示视图
 */
@interface LivePlayZoomInView : DirectionView

@end

/**
 视频播放缩放提示视图
 */
@interface LivePlayZoomOutView : DirectionView

@end

/**
 设备设置提示视图
 */
@interface LiveSettingsDirectionView : DirectionView

@end

/**
 进入云录像提示视图
 */
@interface LiveHistoryDirectionView : DirectionView

@end

/**
 点击more按钮后的提示视图
 */
@interface LiveMoreDirectionView : DirectionView

@end

/**
 云录像时间轴缩放提示视图
 */
@interface HistoryZoomInView : DirectionView

@end

/**
 云录像时间轴缩放提示视图
 */
@interface HistoryZoomOutView : DirectionView

@end

