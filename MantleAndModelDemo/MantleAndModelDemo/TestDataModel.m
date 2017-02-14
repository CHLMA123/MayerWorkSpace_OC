//
//  TestDataModel.m
//  MantleAndModelDemo
//
//  Created by APP on 2017/2/14.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "TestDataModel.h"

@implementation TestDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"date": @"dt", //将JSON字典里dt键对应的值，赋值给date属性
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",//这个点是什么意思呢，表示将main键对应的子字典里，
             //temp键对应的值赋给temperature属性。
             //我们不用再写 objectForKey]objectForKey]..这种代码了。
             //注意了：当main键对应的是数组时，main.temp返回的
             //为所有temp键对应值的数组合集
             
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.main",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed",
             };
}


/**
 How to convert a JSON value to the given property key?
 假设我们声明的date是一个NSDate型，但网络请求返回的却是NSNumber。JSON数据里解析出来的就是NSNumber，那要怎么转化为我们期望的NSDate呢？
 Mantle没办法自动的帮我们做这种类型转换，但它提供了相关的Delegate，我们可以实现这些Delegate方法，这样，Mantle就能按照我们指定的方式进行转换了。
 
 Mantle提供了两种方式。
 */
////第一种是实现协议中的下面这个方法。(这种方式有个坏处，代码会很容易膨胀，if-else-if会很多，比较难维护。)
//+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key{
//    
//    if ([key isEqualToString:@"date"]) {
//        
//        return [MTLValueTransformer reversibleTransformerWithForwardBlock:
//                ^id(NSNumber *number)
//                {
//                    NSTimeInterval secs = [number doubleValue];
//                    return [NSDate dateWithTimeIntervalSince1970:secs];
//                } reverseBlock:^id(NSDate *d) {
//                    return @([d timeIntervalSince1970]);
//                }];
//        
//    } else if ([key isEqualToString:@"condition"]) {
//        return [MTLValueTransformer reversibleTransformerWithForwardBlock:
//                ^id(NSArray *values) {
//                    return [values firstObject];
//                } reverseBlock:^id(NSString *str) {
//                    return @[str];
//                }];
//        
//    }
//    
//    return nil;
//}

//第二种方式的基本思路就是把第一种方式的if-else-if拆开，独立成一个个的小方法，便于维护。它的方法名必须遵循特定的规则，规则如下：SEL selector = MTLSelectorWithKeyPattern(key, "JSONTransformer");
+ (NSValueTransformer *)dateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^id(NSNumber *number)
            {
                NSTimeInterval secs = [number doubleValue];
                return [NSDate dateWithTimeIntervalSince1970:secs];
            } reverseBlock:^id(NSDate *d) {
                return @([d timeIntervalSince1970]);
            }];
}

+ (NSValueTransformer *)sunriseTimeJSONTransformer
{
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetTimeJSONTransformer
{
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)conditionJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:
            ^id(NSArray *values) {
                return [values firstObject];
            } reverseBlock:^id(NSString *str) {
                return @[str];
            }];
}


@end
