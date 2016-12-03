//
//  LinkBlock.h
//  ChainProgrammingDemo
//
//  Created by MCL on 2016/12/3.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#ifndef LinkBlock_h
#define LinkBlock_h

//////////////////////////////////////////////////////////////////////
//MARK:控制
//////////////////////////////////////////////////////////////////////
//引用类型的返回值时的预处理
#define LinkHandle_REF(currType)\
__kindof currType* _self = (currType*)self;



#endif /* LinkBlock_h */

/**
 id, instancetype, __kindof作为返回值时的比较:
 
 1  id :
 
 优点:可以调用任何对象方法
 
 缺点:不能使用点语法,不能做编译检查.
 Xcode5之前,返回id
 2  instancetype:
 优点:会自动识别当前类的对象
 xcode5:instancetype
 
 3  __kindof : 相当于
 
 优点:调用方法时,通过返回值提示, 可以看到具体的返回类型, 如: Person *, 而前两者不会看到.
 xcode7:__kindof:表示当前类或者子类
 
 ///////////////////////////////////////////////////////////////////////////////////
 __kindof 关键字：既明确表明了返回值，又让使用者不必写强转。举个带泛型的例子，UIView 的 subviews 属性被修改成了：
 
 @property (nonatomic, readonly, copy) NSArray<__kindof UIView *> *subviews;
 
 这样，写下面的代码时就没有任何警告了：
 
 UIButton *button = view.subviews.lastObject;
 ///////////////////////////////////////////////////////////////////////////////////
 
 
 文／凡路（简书作者）
 原文链接：http://www.jianshu.com/p/6131ed3ac796
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 */
