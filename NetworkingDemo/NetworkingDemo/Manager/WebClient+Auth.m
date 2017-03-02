//
//  WebClient+Auth.m
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "WebClient+Auth.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation WebClient (Auth)

#pragma mark - register
- (void)registerWithType:(WebClientInterfaceTypes)type
                username:(NSString *)username
                password:(NSString *)password
                 country:(NSString *)country
                language:(NSString *)language
              accessType:(NSString *)accessType
        appClientVersion:(NSString *)appClientVersion
                 oemCode:(NSString *)oemCode{
    
    NSDictionary *params = @{kWebClientUsername        : username,
                             kWebClientPassword        : [password stringForMD5],
                             kWebClientCountry         : country,
                             kWebClientLanguage        : language,
                             kWebClientAccessType      : accessType,
                             kWebClientAppClientVersion: appClientVersion,
                             kWebClientOemCode         : @"123456",
                             };
    NSLog(@"... register params:%@", params);
    
    [self POST:@"" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self webClientInterfaceType:type sessionDataTask:task responseObject:responseObject error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self webClientInterfaceType:type sessionDataTask:task responseObject:nil error:error];
    }];
}

@end

@implementation NSString (kMD5)

- (NSString *)stringForMD5{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return [hash lowercaseString];
}

@end


