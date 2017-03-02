//
//  WebClientDelegate.h
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebClientConstant.h"

@class WebClient;
@class WBError;

@protocol WebClientDelegate <NSObject>

@optional
- (void)webClient:(WebClient *)webClient interfaceType:(WebClientInterfaceTypes)type didReceiveResponse:(id)response;

- (void)webClient:(WebClient *)webClient interfaceType:(WebClientInterfaceTypes)type didFailWithError:(WBError *)error;

@end
