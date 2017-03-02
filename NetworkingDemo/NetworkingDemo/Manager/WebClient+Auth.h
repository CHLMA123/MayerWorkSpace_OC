//
//  WebClient+Auth.h
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "WebClient.h"

/**
 * WebClient+Auth类接口说明
 * 该分类接口适用于权限获取
 * 如：注册、登录、登出、密码找回等
 */

@interface WebClient (Auth)

/**
 * 云平台注册接口(OEM)
 * type: 接口类型
 * username: 账户名（email)
 * password: 账户的密码,MD5加密后再传给后台
 * country: 国家（查询注册国家接口获取的code）
 * language: CHS / ENU
 * accessType: 用户接入方式（1web，2foscam app，3NVR，4官网
 * appClientVersion: 客户端版本信息
 * oemCode: OEM厂商编号
 */
- (void)registerWithType:(WebClientInterfaceTypes)type
                username:(NSString *)username
                password:(NSString *)password
                 country:(NSString *)country
                language:(NSString *)language
              accessType:(NSString *)accessType
        appClientVersion:(NSString *)appClientVersion
                 oemCode:(NSString *)oemCode;

@end

@interface NSString (kMD5)

- (NSString *)stringForMD5;

@end
