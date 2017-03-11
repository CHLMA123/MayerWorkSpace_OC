//
//  DirectionView.m
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "DirectionView.h"
#import "Masonry.h"

#define FSLocalizedString(key) NSLocalizedString(key, nil)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE_4  480.f

#define IS_IPHONE_5  568.f

#define IS_IPHONE_6  667.f

#define IS_IPHONE_6p 736.f

@interface DirectionView ()

@end

@implementation DirectionView

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.font = [UIFont systemFontOfSize:16];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.numberOfLines = 0;
    }
    return _tipsLabel;
}

@end


@interface SliderDirectionView ()

@property (nonatomic, strong) UIImageView *imageView1;

@property (nonatomic, strong) UIImageView *imageView2;

@end

@implementation SliderDirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_SliderTips");
    
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView1];
    [self addSubview:self.imageView2];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(26);
        make.left.offset(6);
        make.size.mas_equalTo(CGSizeMake(77, 87));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView1.mas_bottom);
        make.width.mas_equalTo(225);
        make.height.mas_lessThanOrEqualTo(89);
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(20);
        make.left.equalTo(self.imageView1);
        make.size.mas_equalTo(CGSizeMake(44, 40));
    }];
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_help1"]];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_help1_2"]];
    }
    return _imageView2;
}

@end



@interface AddDirectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AddDirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_AddTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26);
        make.right.mas_equalTo(-6);
        make.size.mas_equalTo(CGSizeMake(78, 90));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.right.mas_equalTo(-45);
        make.width.mas_equalTo(130);
        make.height.mas_lessThanOrEqualTo(89);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_help2"]];
    }
    return _imageView;
}

@end



@interface LivePlayZoomInView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LivePlayZoomInView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_LiveZoomInTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.centerX.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(10 / 16.0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(tempView);
        make.size.mas_equalTo(CGSizeMake(35, 47));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.imageView);
        make.width.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_help_zoomin"]];
    }
    return _imageView;
}

@end



@interface LivePlayZoomOutView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LivePlayZoomOutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_LiveZoomOutTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.centerX.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(10 / 16.0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(tempView);
        make.size.mas_equalTo(CGSizeMake(35, 47));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.imageView);
        make.width.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_help_zoomout"]];
    }
    return _imageView;
}

@end

@interface LiveSettingsDirectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LiveSettingsDirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_SettingsTips");
    
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.right.offset(-6);
        make.size.mas_equalTo(CGSizeMake(78, 90));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.right.offset(-20);
        make.width.mas_equalTo(165);
        make.height.mas_lessThanOrEqualTo(89);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_help4"]];
    }
    return _imageView;
}

@end

@interface LiveHistoryDirectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LiveHistoryDirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_ViewHistoryTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.centerX.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(10 / 16.0);
    }];
    
    // 参考LivePlay的frame
    CGFloat offsetY = (SCREEN_HEIGHT > IS_IPHONE_6) ? 215 : ((SCREEN_HEIGHT >IS_IPHONE_5) ? 210 : ((SCREEN_HEIGHT >IS_IPHONE_4) ? 185 : 170));
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tempView.mas_bottom).offset(offsetY);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 39));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
        make.centerX.width.equalTo(self);
        make.height.mas_lessThanOrEqualTo(44);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_help3"]];
    }
    return _imageView;
}

@end



@interface LiveMoreDirectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LiveMoreDirectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_MoreButtonTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(325, 124));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView.mas_top).offset(-20);
        make.centerX.equalTo(self);
        make.height.mas_lessThanOrEqualTo(89);
        make.width.mas_equalTo(225);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_help5"]];
    }
    return _imageView;
}

@end

@interface HistoryZoomInView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HistoryZoomInView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_HistoryZoomInTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.centerX.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(9 / 16.0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tempView.mas_bottom).offset(232);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(33, 40));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
        make.centerX.width.equalTo(self);
        make.height.mas_lessThanOrEqualTo(44);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history_help1"]];
    }
    return _imageView;
}

@end



@interface HistoryZoomOutView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HistoryZoomOutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.tipsLabel.text = FSLocalizedString(@"FS_Direction_HistoryZoomOutTips");
    [self addSubview:self.tipsLabel];
    [self addSubview:self.imageView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.centerX.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(9 / 16.0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tempView.mas_bottom).offset(232);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(33, 40));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
        make.centerX.width.equalTo(self);
        make.height.mas_lessThanOrEqualTo(44);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history_help2"]];
    }
    return _imageView;
}

@end
