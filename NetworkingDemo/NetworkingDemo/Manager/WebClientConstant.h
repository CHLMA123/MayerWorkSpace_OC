//
//  WebClientConstant.h
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#ifndef WebClientConstant_h
#define WebClientConstant_h

/**
 * 网络请求的基地址
 */

#pragma mark - WebClient Values

#if 1
#define kWebClientBaseURL           @"https://api.mycloudipc.com"
#else
#define kWebClientBaseURL           @"https://test-api.mycloudipc.com"
#endif

#pragma mark - Value Words
/**
 * 值关键字
 */
#define kWebClientUsername          @"username"
#define kWebClientPassword          @"password"
#define kWebClientCountry           @"country"
#define kWebClientLanguage          @"language"
#define kWebClientAccessType        @"accessType"
#define kWebClientAppClientVersion  @"version"
#define kWebClientOemCode           @"oemCode"
//...

#pragma mark - WebClient Interface Types
/**
 * WebClient 中API对应类型
 */
typedef NS_ENUM(NSInteger, WebClientInterfaceTypes) {
    /*权限相关接口*/
    WebClientRegister                       = 100,  //用户注册
    WebClientLogin,                                 //用户登录
    WebClientLogout,                                //用户登出
    
    /*推送相关接口*/
    WebClientSubscribeStatus                = 200,  //查询订阅状态
    
    //...
};

/**
 * 网络请求方法
 */
typedef enum {
    GET,
    POST,
} HTTPMethods;

#endif /* WebClientConstant_h */
