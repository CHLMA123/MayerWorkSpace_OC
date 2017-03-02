//
//  WBError.h
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 网络请求错误类型
 */
typedef NS_ENUM(NSInteger, WBErrorTypes) {
    WBErrorInNetwork        = 1000,     //网络错误
    WBErrorInServer,                    //服务器返回错误
};

/**
 * 网络请求错误类
 */
@interface WBError : NSObject

//网络错误类型
@property (nonatomic, readonly, assign) WBErrorTypes errorType;

//网络错误代码
@property (nonatomic, copy, readonly) NSString *errorCode;

//网络错误本地描述
@property (nonatomic, readonly, copy) NSString *localizedDescription;

/**
 * 类的初始化方法
 * errorType: 错误类型
 * errorCode: 错误代码
 * localizedDescription: 本地化错误描述
 */
+ (instancetype)errorWithErrorType:(WBErrorTypes)errorType
                         errorCode:(NSString *)errorCode
              localizedDescription:(NSString *)localizedDescription;

@end
