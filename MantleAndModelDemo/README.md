# MantleAndModelDemo

[Mantle 初步使用 

在开发的过程中，我们常常会从网络获取数据，而数据通常又为JSON格式。这时比较常见的做法是把JSON数据转为Model对象，这样我们可以从Model对象的属性读取数据。但是常常会面临如下一些问题:

    1 每次都要用 -initWithDictionarty:(NSDictionary *)dict 等类似的方法初始化，把JSON数据里的值一个一个的赋值给Modeld对象的属性
    2 当你需要的某个数据在JSON字典数据里层次很深时，需要不断的使用 ((obj objectForKey:@"key") objectAtIndex:index) objectForKey:@"")... 这样很长的代码，感觉很不爽！
    3 服务器给你返回的数据不是你期望的，例如：有些时候你需要的是一个NSString类型，但给你的是一个NSNumber。 有时你需要的是一个NSDate类型，但给你的是一个NSString类型，你还不得不去做一些判断，写一些转换的代码。 还有一种严重的情况，由于服务器故障，给你返回了一个NSNull，如果你没有做一些判断处理，那么这时你的程序崩溃的几率很大！
    4 如何从这个Model对象，再还原成之前的JSON字典数据？ 其次，你想把这个Model对象存储下来的话，那么你不得不自己去处理NSCoding协议等一些烦人的问题，又是一些重复工作！

什么是Mantle？
https://github.com/Mantle/Mantle
Mantle makes it easy to write a simple model layer for your Cocoa or Cocoa Touch application.   

我们常用到的就是MTLJSONAdapter和MTLModle.MTLModel是一个抽象类，它帮我们做了很多工作，比如解决前言里提出的一些问题。 我们要建的Model类应该继承于它，此外你的继承类一定还要实现MTLJSONSerializing协议。 MTLJSONAdapter则是帮我们把JSON数据绑定到Model的属性里，当然，你不用担心会出现NSNull的情况，因为转换后它会自动设置成nil;

Model对象的存储:

MTLModel已经帮我们实现了NSCoding协议， 要把一个Model对象存储到本地就相当简单了，只需一行代码：
[NSKeyedArchiver archiveRootObject:model toFile:path);

解档时同样简单：
TestDataModel *unachiveModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path);

]

