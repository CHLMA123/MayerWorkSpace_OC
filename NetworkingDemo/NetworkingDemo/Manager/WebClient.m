//
//  WebClient.m
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "WebClient.h"

@interface WebClient ()

@property (nonatomic, strong) NSString *domain;

@end

@implementation WebClient

- (instancetype)initWithBaseURLString:(NSString *)urlString{
    if (self = [super initWithBaseURL:[NSURL URLWithString:urlString]]){
        //self.securityPolicy.allowInvalidCertificates = YES;//是否可以使用自建证书
        //先导入证书，找到证书的路径
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"cert" ofType:@"cer"];
        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
        
        //AFSSLPinningModeNone 这个模式表示不做 SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
        //AFSSLPinningModeCertificate 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
        //AFSSLPinningModePublicKey 这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        if (certData) {
            securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
        }
        self.securityPolicy = securityPolicy;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    return self;
}

#pragma mark - Private Methods
- (void)webClientInterfaceType:(WebClientInterfaceTypes)type sessionDataTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error{
    if (!error){
        //网络请求成功
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *errorCode = dict[@"errorCode"];
        NSString *descrption = dict[@"failureDetails"];
        if ([errorCode isEqualToString:@""]){//业务请求成功
            //代理回掉
            if ([_delegate respondsToSelector:@selector(webClient:interfaceType:didReceiveResponse:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate webClient:self interfaceType:type didReceiveResponse:responseObject];
                });
            }
        }else{//业务请求失败
            
            WBError *wbError = [WBError errorWithErrorType:WBErrorInServer errorCode:errorCode localizedDescription:descrption];
            //代理回掉
            if ([_delegate respondsToSelector:@selector(webClient:interfaceType:didFailWithError:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate webClient:self interfaceType:type didFailWithError:wbError];
                });
            }
        }
    }else{
        //网络请求失败
        NSDictionary *userInfo = error.userInfo;
        NSString *errorCode = [NSString stringWithFormat:@"%ld", [userInfo[@"_kCFStreamErrorCodeKey"] integerValue]];
        NSString *localizedDescription = [NSString stringWithFormat:@"%@", userInfo[@"NSLocalizedDescription"]];
        WBError *wbError = [WBError errorWithErrorType:WBErrorInNetwork errorCode:errorCode localizedDescription:localizedDescription];
        //代理回掉
        if ([_delegate respondsToSelector:@selector(webClient:interfaceType:didFailWithError:)]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_delegate webClient:self interfaceType:type didFailWithError:wbError];
            });
        }
    }
}

#pragma mark - Getter && Setter
- (NSString *)domain{
    if (!_domain){
        _domain = ([NSBundle mainBundle].infoDictionary)[@"CFBundleIdentifier"];
    }
    return _domain;
}

@end
