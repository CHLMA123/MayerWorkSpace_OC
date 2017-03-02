//
//  WBError.m
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "WBError.h"

@interface WBError ()

@property (nonatomic, readwrite, assign) WBErrorTypes errorType;

@property (nonatomic, readwrite, copy) NSString *errorCode;

@property (nonatomic, readwrite, copy) NSString *localizedDescription;

@end

@implementation WBError

+ (instancetype)errorWithErrorType:(WBErrorTypes)errorType
                         errorCode:(NSString *)errorCode
              localizedDescription:(NSString *)localizedDescription{
    
    WBError *error = [[WBError alloc] init];
    
    error.errorType = errorType;
    error.errorCode = errorCode;
    error.localizedDescription = localizedDescription;
    
    return error;
}

#pragma mark - NSObject
- (NSString *)description{
    return [self debugDescription];
}

- (NSString *)debugDescription{
    NSDictionary *params = @{@"errorType"           : @(self.errorType),
                             @"errorCode"           : self.errorCode ?: @"NULL",
                             @"localizedDescription": self.localizedDescription ?: @"NULL",
                             };
    return [NSString stringWithFormat:@"%@", params];
}

@end
