//
//  ViewController.m
//  MantleAndModelDemo
//
//  Created by APP on 2017/2/14.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
//#import "TestDataModel.h"
#import "GoodStuffDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //使用Mantle处理json和Model Object的基本要素:
    
    NSURL *url = [NSURL URLWithString:@"http://zhekou.repai.com/jkjby/view/rp_b2c_list_v5.php?limit=100&&access_token=&appkey=100071&app_oid=2ad000dbe962fff914983edbf273b427&app_id=594792631&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&pay=weixin&senddata=20150922"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               
                               if (!connectionError) {
                                   
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:nil];
                                   NSArray *array = [dict objectForKey:@"list"];
                                   NSDictionary *dictlist = array[0];
                                   //1 将JSON数据和Model的属性进行绑定
                                   GoodStuffDataModel *stuffmodel = [MTLJSONAdapter modelOfClass:[GoodStuffDataModel class] fromJSONDictionary:dictlist error:nil];
                                   NSLog(@"\n\n\nmodel = %@",stuffmodel);
                                   
//                                   //2 Model对象的存储
//                                   NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                                   NSString *filepath = [documentpath stringByAppendingPathComponent:@"NSKeyedArchiver.archiver"];
//                                   NSLog(@"\n\n\nfilepath = %@\n\n\n",filepath);
//                                   [NSKeyedArchiver archiveRootObject:stuffmodel toFile:filepath];
//                                   GoodStuffDataModel *model2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
//                                   NSLog(@"\n\n\nmodel2 = %@, stuff_titles = %@\n\n\n",model2, model2.stuff_titles);
//                                   
//                                   //3 Model Object转换为json格式，需要调用:
//                                   NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:stuffmodel error:nil];
//                                   NSLog(@"\n\n\njsonDictionary = %@\n\n\n",jsonDictionary.description);
                                   
                                   
                               }
                               
                           }];
}

/*iOS之教你用Xtrace读懂Mantle源码
 http://www.phperz.com/article/16/0405/209254.html
 
 Mantle是什么?
 Mantle makes it easy to write a simple model layer for your Cocoa or Cocoa Touch application. –Mantle是构建Cocoa或者Cocoa Touch应用程序的Model层的框架。
 Mantle地址:GitHub – Mantle/Mantle: Model framework for Cocoa and Cocoa Touch
 
 Xtrace是什么?
 Xtrace是ios中强大的调试的库，能详细打印出一个某个方法被调用的堆栈，方便调试时定位问题。
 Xtrace地址:GitHub – johnno1962/Xtrace: Trace Objective-C method calls by class or instance
 */

/*
 | From: __29-[ViewController viewDidLoad]_block_invoke
 | +[MTLJSONAdapter modelOfClass:<GoodStuffDataModel 0xe05b8> fromJSONDictionary:<__NSDictionaryM 0x1759fa50> error:0x0]
 
 [**方法一:modelOfClass:fromJSONDictionary:error:
 这个方法通过initWithModelClass方法初始化MTLJSONAdapter实例，之后调用modelFromJSONDictionary: error:将JSON字典转化成Model；
 *]
 
 |   [<MTLJSONAdapter 0x175c12a0> initWithModelClass:<GoodStuffDataModel 0xe05b8>]
 
 [**方法二:initWithModelClass:
 这个方法主要用来初始化变量，并返回MTLJSONAdapter实例。先是调用了JSONKeyPathsByPropertyKey来指定对象的属性如何映射到不同的key path，并将结果保存。再是调用propertyKeys方法获取model中所有属性(除了存储类型为MTLPropertyStorageNone)。接着遍历_JSONKeyPathsByPropertyKey变量，先判断是不是包含在propertyKeys集合中，如果未包含直接return掉；如果包含则获取对应属性keyPath，这里keyPath有两种形式，一种字符串的形式、一种数组的形式，所以这里做了一下判断。然后调用了valueTransformersForModelClass方法来获取model中每个属性对应的值转换器的字典。最后初始化了JSONAdaptersByModelClass变量并返回实例。
 *]
 
 |     +[GoodStuffDataModel JSONKeyPathsByPropertyKey]
 
 [**方法三:JSONKeyPathsByPropertyKey
 这是子类Model遵守MTLJSONSerializing协议必须实现的方法，主要指定对象的属性如何映射到不同的key path。
 *]
 
 |     +[GoodStuffDataModel/MTLModel propertyKeys]
 
 [**方法四:propertyKeys
 这个方法主要获取获取model中所有属性(除了存储类型为MTLPropertyStorageNone)。这里通过关联对象形式来获取缓存，如果缓存为Nil，则调用enumeratePropertiesUsingBlock一次遍历所有属性，通过调用storageBehaviorForPropertyWithKey获取每个属性的存储行为，并将存储行为不是MTLPropertyStorageNone的结果加入到集合中，最后结果关联到当前对象并返回。
 *]
 
 |       +[GoodStuffDataModel/MTLModel enumeratePropertiesUsingBlock:<__NSStackBlock__ 0x2c8054>]
 
 [**方法五:enumeratePropertiesUsingBlock
 这个方法主要来循环获取model及其父类(非MTLModel)的所有属性，并执行block。这里运用到了runtime函数class_copyPropertyList来获取属性列表。
 *]
 
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuffID"]
 
 [**方法六:storageBehaviorForPropertyWithKey
 这个方法主要用来获取指定属性的存储行为。先是通过runtime获取属性，并通过mtl_copyPropertyAttributes获取属性内部结构。之后的判断逻辑相对比较复杂，同时也说明作者考虑比较周到。从这个逻辑判断我们可以知道，Mantle实际将存储类型分类为两种(可存储和不可存储)，而不可存储的属性是没有变量空间ivar,readonly属性往往会是这种情况。这里内部出现嵌套调用的情况，主要是考虑到了一个被覆盖的readonly属性其父类可能存在变量空间。
 *]
 
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_des"]
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_titles"]
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_picurl"]
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"start_discount"]
 |         +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"hash"]
 |       +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"superclass"]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"description"]
 |   +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"debugDescription"]
 | From: -[MTLJSONAdapter initWithModelClass:]
 | +[MTLJSONAdapter valueTransformersForModelClass:<GoodStuffDataModel 0xe05b8>]
 
 [**方法七:valueTransformersForModelClass
 这个方法用来获取model中属性对应的值转换器集合。先去判断了是否实现”属性名称”+”JSONTransformer”方法，如果实现进行动态调用并返回。如果未实现则判断是否实现JSONTransformerForKey这个方法，如果实现则进行调用并返回。如果未实现，则对属性结构进行判断，返回合适的值转换器。
 *]
 
 |   +[GoodStuffDataModel/MTLModel propertyKeys]
 |   +[MTLJSONAdapter transformerForModelPropertiesOfObjCType:"i"]
 |   +[MTLJSONAdapter transformerForModelPropertiesOfClass:<NSString 0x3acd9d4c>]
 |   +[MTLJSONAdapter transformerForModelPropertiesOfClass:<NSString 0x3acd9d4c>]
 |   +[MTLJSONAdapter transformerForModelPropertiesOfClass:<NSString 0x3acd9d4c>]
 |   +[MTLJSONAdapter transformerForModelPropertiesOfClass:<NSString 0x3acd9d4c>]
 | From: +[MTLJSONAdapter modelOfClass:fromJSONDictionary:error:]
 
 [**方法八:modelOfClass:fromJSONDictionary:error:
 这个方法是将JSON转换为Model最主要的方法，前面做的都是一些初始化工作。先是判断当前类是否实现了classForParsingJSONDictionary方法，这个方法在存在类族的情况下判断具体哪个类来执行转换工作。接着遍历model的所有属性，通过kvc获取每个属性的值，并判断相应属性是否存在值转换器，若果存在，则对值进行相应转换。最后将所有的值存储在字典中，并调用modelWithDictionary: error通过kvc的方式验证并设置值。
 *]
 
 | [<MTLJSONAdapter 0x175c12a0> modelFromJSONDictionary:<__NSDictionaryM 0x1759fa50> error:0x0]
 |   +[GoodStuffDataModel/MTLModel propertyKeys]
 |   +[GoodStuffDataModel/MTLModel modelWithDictionary:<__NSDictionaryM 0x17588110> error:0x0]
 
 [**方法九:modelWithDictionary: error
 这个方法只是调用了initWithDictionary: error:自定义实现。
 *]
 
 |     [<GoodStuffDataModel 0x17589670>/MTLModel initWithDictionary:<__NSDictionaryM 0x17588110> error:0x0]
 
 [**方法十:initWithDictionary: error:
 这个方法通过kvc的方式初始化model实例。先是遍历了字典，获取值并验证是否为NSNull.null类型，接着通过KVC的方式为model实例验证并设置值。*]
 
 |       [<GoodStuffDataModel 0x17589670>/MTLModel init]
 |       [<GoodStuffDataModel 0x17589670> setStuff_des:@"加厚PP材质 敞口设计 一体式设计"]
 |       [<GoodStuffDataModel 0x17589670> setStart_discount:@"2017-02-15 00:00:00"]
 |       [<GoodStuffDataModel 0x17589670> setStuffID:1811095291]
 |       [<GoodStuffDataModel 0x17589670> setStuff_titles:@"5包装 400张三层 抽纸 面巾纸餐巾纸卫生纸 纯木浆纸巾"]
 |       [<GoodStuffDataModel 0x17589670> setStuff_picurl:@"https://pic.repaiapp.com/pic/ee/af/90/eeaf90252e28cc78d70ad2a24b0170fd76e5fa48.jpg"]
 |   [<GoodStuffDataModel 0x17589670>/MTLModel validate:0x0]
 |     +[GoodStuffDataModel/MTLModel propertyKeys]
 | From: -[MTLModel description]
 | +[GoodStuffDataModel/MTLModel permanentPropertyKeys]
 |   +[GoodStuffDataModel/MTLModel generateAndCacheStorageBehaviors]
 |     +[GoodStuffDataModel/MTLModel propertyKeys]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuffID"]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_des"]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_titles"]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"start_discount"]
 |     +[GoodStuffDataModel/MTLModel storageBehaviorForPropertyWithKey:@"stuff_picurl"]
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
