//
//  RLMUser.h
//  RealmDemo
//
//  Created by APP on 2017/2/21.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

/*
 2. 建表
 
 需要继承 RLMObject或者一个已经存在的模型类，就可创建一个新的 Realm 数据模型对象。对应在数据库里面就是一张表。
 注意，RLMObject 官方建议不要加上 Objective-C的property attributes(如nonatomic, atomic, strong, copy, weak 等等）。假如设置了，这些attributes会一直生效直到RLMObject被写入realm数据库。
 */
#import <Realm/Realm.h>

@interface RLMUser : RLMObject

@property NSString      *usrId;//用户注册id
@property NSString      *usrName;//姓名
@property NSInteger     usrAge;//用户年龄
@property NSString      *usrHeadPicUrl;//头像大图url
//@property RLMArray      *cars;

@end
//RLM_ARRAY_TYPE(RLMUser)

// 定义RLMArray
@interface Car : RLMObject

@property NSString *carName;
@property RLMUser *owner;

@end
//RLM_ARRAY_TYPE(Car)

