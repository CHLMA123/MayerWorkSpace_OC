//
//  AppDelegate.h
//  RealmDemo
//
//  Created by APP on 2017/2/21.
//  Copyright © 2017年 CHLMA. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

/*
 https://realm.io/docs/objc/latest/#getting-started
 
 Download the latest release of Realm and extract the zip.
 Drag Realm.framework from the ios/static/ directory to the File Navigator of your Xcode project. Make sure Copy items if needed is selected and click Finish.
 Click on your project in the Xcode File Navigator. Select your app’s target and go to the Build Phases tab. Under Link Binary with Libraries click + and add libc++.tbd and libz.tbd.
 */
/*
 Realm 中的相关术语
 
 RLMRealm：Realm是框架的核心所在，是我们构建数据库的访问点，就如同Core Data的管理对象上下文（managed object context）一样。出于简单起见，realm提供了一个默认的defaultRealm( )的便利构造器方法。
 
 RLMObject：这是我们自定义的Realm数据模型。创建数据模型的行为对应的就是数据库的结构。要创建一个数据模型，我们只需要继承RLMObject，然后设计我们想要存储的属性即可。
 
 关系(Relationships)：通过简单地在数据模型中声明一个RLMObject类型的属性，我们就可以创建一个“一对多”的对象关系。同样地，我们还可以创建“多对一”和“多对多”的关系。
 
 写操作事务(Write Transactions)：数据库中的所有操作，比如创建、编辑，或者删除对象，都必须在事务中完成。“事务”是指位于write闭包内的代码段。
 
 查询(Queries)：要在数据库中检索信息，我们需要用到“检索”操作。检索最简单的形式是对Realm( )数据库发送查询消息。如果需要检索更复杂的数据，那么还可以使用断言（predicates）、复合查询以及结果排序等等操作。
 
 RLMResults：这个类是执行任何查询请求后所返回的类，其中包含了一系列的RLMObject对象。RLMResults和NSArray类似，我们可以用下标语法来对其进行访问，并且还可以决定它们之间的关系。不仅如此，它还拥有许多更强大的功能，包括排序、查找等等操作。
 */
