# MayerWorkSpace_OC
不积跬步无以至千里

#UIButtonDemo   #
<ol>
	<li>解决问题：</li>
	<li>iOS防止按钮快速连续点击造成多次响应</li>
</ol>

<ol>
	<li>关联传值：</li>
	<li>#import <objc/runtime.h>头文件</li>
	<li> 
		<div>objc_setAssociatedObject需要四个参数：源对象，关键字，关联的对象和一个关联策略</div>
		<div>   1 源对象alert
    			2 关键字 唯一静态变量key associatedkey
    			3 关联的对象 sender
    			4 关键策略  OBJC_ASSOCIATION_ASSIGN
		</div>

	</li>
<li>让按钮无法点击的2种方法
•	button.enabled = NO;
◦	【会】进入UIControlStateDisabled状态
•	button.userInteractionEnabled = NO;
◦	【不会】进入UIControlStateDisabled状态，继续保持当前状态
</li>
	<li></li>
	<li></li>
</ol>

#blockUsage   #

blcok在内存中的分析

block内存中的三个位置 NSGlobalBlock，NSStackBlock, NSMallocBlock

NSGlobalBlock : 和函数类似，位于text代码段
NSStackBlock : 栈内存,函数返回后Block将无效

NSMallocBlock : 堆内存

/**

*  分类总结
1.没有用到外界变量或只用到全局变量、静态变量的block为全局block，生命周期从创建到应用程序结束
2.用到局部变量、成员属性\变量的block为栈block，生命周期系统控制，函数返回即销毁
3.有强指针引用或copy修饰的成员属性引用的block会被复制一份到堆中成为堆block，没有强指针引用即销毁，生命周期由程序员控制
*/

