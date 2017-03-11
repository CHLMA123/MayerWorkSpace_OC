//
//  DirectionHelper.m
//  Foscam
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "DirectionHelper.h"
#import <objc/runtime.h>

static NSString * const kDirectionPlistFileName = @"DirectionPlist.plist";
static NSString * const kDirectionModel = @"directionModel";

@interface DirectionHelper ()

/**
 Plist 文件路径
 */
@property (nonatomic, strong, readonly) NSString *plistFilepath;

@end

@implementation DirectionHelper

+ (DirectionHelper *)sharedInstance {
    static DirectionHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DirectionHelper alloc] init];
    });
    return helper;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
        [self registerObserve];
    }
    return self;
}

#pragma mark - Private Methods
- (void)setup {
    NSString *fileptah = self.plistFilepath;
    if (nil == fileptah) return;
    
    _directionModel = [DirectionModel new];
    NSMutableDictionary *modelDict = [[_directionModel dict] mutableCopy];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:fileptah];
    [plistDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        modelDict[key] = obj;
    }];
    
    _directionModel = [[DirectionModel alloc] instanceWithDict:modelDict];
    [self synchronize];
}

- (void)synchronize {
    if (nil == _directionModel || nil == self.plistFilepath) {
        return ;
    }
    
    NSDictionary *dict = [_directionModel dict];
    [dict writeToFile:self.plistFilepath atomically:YES];
}

- (void)registerObserve {
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([DirectionModel class], &outCount);
    
    for (unsigned int i = 0; i != outCount; ++ i) {
        NSString *keyPath = [NSString stringWithFormat:@"%@.%s", kDirectionModel, property_getName(properties[i])];
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
}

#pragma mark - Event Response
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath hasPrefix:kDirectionModel]) {
        NSLog(@"... keyPath:%@ change:%@", keyPath, change);
        [self synchronize];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Getter && Setter
- (NSString *)plistFilepath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    if (nil == documentPath) {
        return nil;
    }
    NSString *filepath = [documentPath stringByAppendingPathComponent:kDirectionPlistFileName];
    return filepath;
}

@end
