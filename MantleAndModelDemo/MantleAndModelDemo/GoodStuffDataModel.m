//
//  GoodStuffDataModel.m
//  MantleAndModelDemo
//
//  Created by APP on 2017/2/14.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "GoodStuffDataModel.h"

@implementation GoodStuffDataModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{

    return @{
             @"stuffID":@"num_iid",
             @"stuff_des":@"des",
             @"stuff_titles":@"title",
             @"stuff_picurl":@"pic_url",
             @"start_discount":@"start_discount",
             };
}


/**
 How to convert a JSON value to the given property key?
 假设我们声明的date是一个NSDate型，但网络请求返回的却是NSNumber。JSON数据里解析出来的就是NSNumber，那要怎么转化为我们期望的NSDate呢？
 Mantle没办法自动的帮我们做这种类型转换，但它提供了相关的Delegate，我们可以实现这些Delegate方法，这样，Mantle就能按照我们指定的方式进行转换了。
 
 Mantle提供了两种方式。
 */

//第一种是实现协议中的下面这个方法。
//Implement this optional method to convert a property from a different type when deserializing from JSON.(这种方式有个坏处，代码会很容易膨胀，if-else-if会很多，比较难维护。)
//+(NSValueTransformer *)JSONTransformerForKey:(NSString *)key{
//
//    //key is the key that applies to your model object; not the original JSON key.
//    return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        
//        if ([key isEqualToString:@"stuff_des"]) {
//            
////            return [NSValueTransformer valueTransformerForName:];
//            
//        }else if ([key isEqualToString:@"stuff_titles"]) {
//        
//        }
//        
//    }];
//}

//第二种方式的基本思路就是把第一种方式的if-else-if拆开，独立成一个个的小方法，便于维护。它的方法名必须遵循特定的规则，规则如下：SEL selector = MTLSelectorWithKeyPattern(key, "JSONTransformer");




@end
