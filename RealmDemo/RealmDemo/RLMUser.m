//
//  RLMUser.m
//  RealmDemo
//
//  Created by APP on 2017/2/21.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "RLMUser.h"

@implementation RLMUser

// 主键
+ (NSString *)primaryKey{
    return @"usrId";
}

//设置属性默认值
+ (NSDictionary *)defaultPropertyValues{
    return @{@"usrId":@"0001",
             @"usrName":@"测试1",
             @"usrAge":@10,
             };
}

//设置忽略属性,即不存到realm数据库中
+ (NSArray *)ignoredProperties{
    return @[@"usrHeadPicUrl"];
}

//一般来说,属性为nil的话realm会抛出异常,但是如果实现了这个方法的话,就只有usrId和usrName为nil会抛出异常,也就是说现在cover属性可以为空了
+ (NSArray *)requiredProperties{
    return @[@"usrId",
             @"usrName",
             @"usrAge"];
}

//设置索引,可以加快检索的速度
+ (NSArray *)indexedProperties{
    return @[@"usrId"];
}

@end

@implementation Car

@end
