//
//  MANSCodingData.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MANSCodingData.h"

#define kDATA_KEY @"dataKey"

@implementation MANSCodingData
- (id)init {
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 对象归档实例：Encoding
 
 对象归档
 
 “归档”是值另一种形式的序列化，对模型对象进行归档的技术可以轻松将复杂的对象写入文件，然后再从中读取它们，只要在类中实现的每个属性都是基本数据类型（如int或float）或都是符合NSCoding协议的某个类的实例，你就可以对你的对象进行完整归档。
 
 实现NSCoding协议
 
 NSCoding协议声明了两个方法：
 -(void)encodeWithCoder:(NSCoder *)aCoder，是将对象写入到文件中。
 
 -(id)initWithCoder:(NSCoder *)aDecoder，是将文件中数据读入到对象中。
 
 实现NSCopying协议
 
 NSCopying协议声明了一个方法： -(id)copyWithZone:(NSZone *)zone ，是将对象复制方法。
 */

#pragma mark - Encode & Decode

- (void)encodeWithCoder:(NSCoder *)enoder {
    [enoder encodeObject:_data forKey:kDATA_KEY];
}

- (id)initWithCoder:(NSCoder *)decoder {
    _data = [[decoder decodeObjectForKey:kDATA_KEY] copy];
    return [self init];
}

@end
