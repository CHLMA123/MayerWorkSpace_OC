//
//  WebClient.h
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "WebClientDelegate.h"
#import "WebClientConstant.h"
#import "WBError.h"

@interface WebClient : AFHTTPSessionManager

@property (nonatomic, weak)id<WebClientDelegate> delegate;

- (instancetype)initWithBaseURLString:(NSString *)urlString;

- (void)webClientInterfaceType:(WebClientInterfaceTypes)type sessionDataTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error;

@end
