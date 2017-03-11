//
//  DirectionModel.m
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "DirectionModel.h"

static NSString * const kDMUserLoginDirection = @"userLoginDirection";
static NSString * const kDMDeviceLoginDirection = @"deviceLoginDirection";
static NSString * const kDMMoreButtonDirection = @"moreButtonDirection";
static NSString * const kDMVideoPlayDirection = @"videoPlayDirection";
static NSString * const kDMScanVideoDirection = @"scanVideoDirection";

@implementation DirectionModel

- (instancetype)init {
    if (self = [super init]) {
        _userLoginDirection = YES;
        _deviceLoginDirection = YES;
        _moreButtonDirection = YES;
        _videoPlayDirection = YES;
        _scanVideoDirection = YES;
    }
    return self;
}

- (DirectionModel *)instanceWithDict:(NSDictionary *)dict {
    
    if (dict[kDMUserLoginDirection]) _userLoginDirection = [dict[kDMUserLoginDirection] boolValue];
    if (dict[kDMDeviceLoginDirection]) _deviceLoginDirection = [dict[kDMDeviceLoginDirection] boolValue];
    if (dict[kDMMoreButtonDirection]) _moreButtonDirection = [dict[kDMMoreButtonDirection] boolValue];
    if (dict[kDMVideoPlayDirection]) _videoPlayDirection = [dict[kDMVideoPlayDirection] boolValue];
    if (dict[kDMScanVideoDirection]) _scanVideoDirection = [dict[kDMScanVideoDirection] boolValue];
    
    return self;
}

- (NSDictionary *)dict {
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    [mutableDict setObject:@(_userLoginDirection) forKey:kDMUserLoginDirection];
    [mutableDict setObject:@(_deviceLoginDirection) forKey:kDMDeviceLoginDirection];
    [mutableDict setObject:@(_moreButtonDirection) forKey:kDMMoreButtonDirection];
    [mutableDict setObject:@(_videoPlayDirection) forKey:kDMVideoPlayDirection];
    [mutableDict setObject:@(_scanVideoDirection) forKey:kDMScanVideoDirection];
    
    return mutableDict.copy;
}

@end
