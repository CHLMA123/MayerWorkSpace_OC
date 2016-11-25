# MayerWorkSpace_OC
不积跬步无以至千里

# 理解iPhone高清分辨率的问题可以有两个关键切入点：
1.像素坐标普通屏是480*320，Retina屏是960*640,而逻辑坐标系同为480*320；
2.Retina屏幕一个逻辑坐标点坐标包含4个像素，而普通屏幕一个逻辑点的坐标只包含1个像素。
于是可以理解的是，对于同一张图，像素数目是固定的，在Retina屏幕上，肯定比在普通屏幕上在逻辑坐标尺寸上要小2倍。
举例来说：一张图片像素尺寸为100*100，在Retina屏幕上逻辑坐标只有50*50，因为虽然逻辑尺寸50*50，但实际像素尺寸依然是100*100，这也就是为什么高清屏幕显示图片更细腻和更清楚的原因，因为在同样逻辑尺寸的屏幕上，单位尺寸像素的密度更高，于是就更好看。
还有一个问题是，在Mac上的iOS设备模拟器为什么在Retina时要变得更大，这个原因我想是因为Mac的屏幕不是Retina屏幕，所以没办法在不改变模拟器屏幕尺寸的情况下直接模拟Retina iOS设备的效果，即模拟器上的屏幕和Mac上像素点是一一对应的，所以为了模拟iOS设备Retina屏幕（像素点是以前的4倍），只能将模拟器的屏幕变大。

# UINavigationController：同级页面之间的跳转，界面典型的特点就是页面上部有一UINavigationBar导航条，导航条可以设置标题、左上角的按钮（一般用于返回），右上角的按钮，也可以自定义这些元素。

# UITabBarController：父子页面之间的嵌套关系，界面典型的特点是耍耍下部有一UITabBar选项组，通过点击Tab，可切换上面的视图的变换。

# UIViewController、UINavigationController、UITabBarController三者的整合使用，可以开发出大部分的App应用页面框架。


1、AsyncDisplayKit

https://github.com/facebook/AsyncDisplayKit


2、ReactiveCocoa

https://github.com/ReactiveCocoa/ReactiveCocoa


3、BeeFramework

https://github.com/gavinkwoe/BeeFramework


4、nimbus

https://github.com/jverkoey/nimbus


5、facebook

https://github.com/facebook

https://github.com/facebook/facebook-ios-sdk

https://github.com/facebook/facebook-android-sdk



熟练掌握C/C++/Objective-C/Swift语言；

熟悉Cocoa Touch(Foundation，UIKit)、Objective-C中block，gcd，NSOperation等；

熟悉Object消息传递等机制，Objective-C Runtime，阅读源码；

熟练使用大部分iOS平台常用库，开源库（AFNetworking，SDWebImage，fmdb），开源控件（EGOTableViewPullRefresh，MRProgress）；

关注Github上iOS平台上开源项目最近趋势，尝试fork一些著名开源库；

iOS App UI develop，熟练使用Interface Builder，理解ReactiveCocoa框架理念，阅读源码；

理解Restful Api概念，会使用Restkit，进行网络资源传输；

理解Beeframework类hybird框架结构原理，掌握HTML5，CSS，JavaScript等前端知识，掌握jQuery等常用库；

熟练使用各种工具debug，调试应用性能；

使用Git进行版本控制管理；

研究每年WWDC上推荐的最近方法技术，对代码进行重构升级；

阅读iOS开发书籍，开发者博客（objc.io/shipster.com）；

计算机基础知识扎实（计算机结构，数据结构，算法）。
