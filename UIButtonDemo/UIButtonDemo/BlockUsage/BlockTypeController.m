//
//  BlockTypeController.m
//  UIButtonDemo
//
//  Created by MCL on 2016/11/22.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BlockTypeController.h"

@interface BlockTypeController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic,   copy) void(^testBlock2)();
@property (nonatomic, assign) int k;
@property (nonatomic, strong) NSString *str2;

@end

NSString *str = @"Global_Var";
int i1 = 10;
NSString *str1 = @"123";

@implementation BlockTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:1.0];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    backBtn.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [backBtn addTarget:self action:@selector(backToFrontPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    self.name = @"@property_name";
    _k =0;
    self.str2 = @"456";
    
    [self StackBlockTest];
    [self MallocBlockTest];
    [self GlobalBlockTest];
    
    [self BlockAndVarTest];
    
}

- (void)backToFrontPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  分类总结
 1.没有用到外界变量或只用到全局变量、静态变量的block为全局block，生命周期从创建到应用程序结束
 2.用到局部变量、成员属性\变量的block为栈block，生命周期系统控制，函数返回即销毁
 3.有强指针引用或copy修饰的成员属性引用的block会被复制一份到堆中成为堆block，没有强指针引用即销毁，生命周期由程序员控制
 */
- (void)StackBlockTest{
    /*
     1. 栈block
     特点：生命周期由系统控制，函数返回即销毁
     用到局部变量、成员属性\变量，且没有强指针引用的block都是栈block
     */
    
    //a.用到局部变量，i为局部变量，block直接在NSLog中打印，没有被指针引用
    int i = 0;
    NSLog(@"%@",^{
        NSLog(@"%d",i);
    });
    
    //b.用到成员属性\变量，name为成员属性
    NSLog(@"%@",^{
        NSLog(@"%@",self.name);
    });
    
    /*
     2016-04-10 15:58:57.634 XRCarouselViewDemo[6286:4375819] <__NSStackBlock__: 0x19b7a0>
     2016-04-10 15:58:57.634 XRCarouselViewDemo[6286:4375819] <__NSStackBlock__: 0x19b788>
     */
}

- (void)MallocBlockTest{
    /*
     2. 堆block
     特点：没有强指针引用即销毁，生命周期由程序员手动管理
     栈block如果有强指针引用或copy修饰的成员属性引用就会被拷贝到堆中，变成堆block
     */
    
    //a.强指针引用，block被testBlock引用，testBlock就是一个block类型的强指针（ARC环境下默认就是强指针）
    int i = 0;
    void(^testBlock)() = ^{
        NSLog(@"%d",i);
    };
    NSLog(@"%@",testBlock);
    
    //b.copy修饰的成员属性引用
    self.testBlock2 = ^{
        NSLog(@"%d",i);
    };
    NSLog(@"%@",self.testBlock2);
    
    /*
     2016-04-10 15:58:57.634 XRCarouselViewDemo[6286:4375819] <__NSMallocBlock__: 0x17531eb0>
     2016-04-10 15:58:57.634 XRCarouselViewDemo[6286:4375819] <__NSMallocBlock__: 0x1752c190>
     */
}

- (void)GlobalBlockTest{
    /*
     3. 全局block
     特点：命长，有多长？很长很长，人在塔在（应用程序在它就在）
     没有用到外界变量，或者只用到全局变量、静态(static)变量的block就是全局block
     
     对于全局block，有没有指针引用都不影响，block类型的成员属性无论是用assign、weak、strong还是copy修饰都无所谓，不过开发中很少用到全局block，所以不要用weak或assign
     */
    
    //a.没有用到外界变量
    self.testBlock2 = ^{};
    NSLog(@"%@",self.testBlock2);
    
    //b.只用到全局变量、静态(static)变量（图6），str为全局变量，str1为静态变量，只用到其中一个也是全局block
    static NSString *str1 = @"static_Var";
    void (^testBlock)()= ^{
        NSLog(@"%@-----%@",str,str1);
    };
    NSLog(@"%@",testBlock);
    
    /*
     2016-04-10 15:58:57.635 XRCarouselViewDemo[6286:4375819] <__NSGlobalBlock__: 0x8d138>
     2016-04-10 15:58:57.635 XRCarouselViewDemo[6286:4375819] <__NSGlobalBlock__: 0x8d15c>
     */
}

/**
 *  block对外界变量的捕获:
 */
- (void)BlockAndVarTest{
    /*
     a.基本数据类型---局部变量
     block会拷贝该变量的值当做常量使用，外界修改变量的值不会影响block内部，且block内部不能对其修改
     
     block内部修改外界变量i的值直接报错，如果想要修改，可以在int i = 0前面加上关键字__block，此时i等效于全局变量或静态变量
     */
    int i = 1;
    void(^testBlock)() = ^{
//        i++;//error
    };
    
    //外界变量i从0变成了1，block内部打印依然是0
    void(^testBlock1)() = ^{
        NSLog(@"Block 内部 i == %d",i);
    };
    i++;
    NSLog(@"i == %d",i);
    testBlock1();
    /*
     2016-04-10 15:58:57.635 XRCarouselViewDemo[6286:4375819] i == 2
     2016-04-10 15:58:57.635 XRCarouselViewDemo[6286:4375819] Block 内部 i == 1
     */
    
    /*
     b.基本数据类型---静态变量、全局变量、成员属性\变量
     block直接访问变量地址，在block内部可以修改变量的值，并且外部变量被修改后，block内部也会跟着变
     
     _k为成员属性\变量，初始值i = 10，j = 20，k = 0，block内部只对i、j、k进行一次自增操作，打印结果却是i = 12，j = 22，k = 2，所以外部的自增操作也影响了内部，即访问的是同一个内存地址
     */
    
    static int j = 20;
    void(^testBlock2)() = ^{
        i1++;
        j++;
        _k++;
        NSLog(@"Block 内部 i1 = %d,\nj = %d,\n_k = %d",i1,j,_k);
    };
    i1++;
    j++;
    _k++;
    NSLog(@"i1 = %d,\nj = %d,\n_k = %d",i1,j,_k);
    testBlock2();
   
    /*
     2016-04-10 16:10:30.253 XRCarouselViewDemo[6290:4377550] i1 = 11,
     j = 21,
     _k = 1
     2016-04-10 16:10:30.253 XRCarouselViewDemo[6290:4377550] Block 内部 i1 = 12,
     j = 22,
     _k = 2
     */
    
    /*
     c.指针类型---局部变量
     block会复制一份指针并强引用指针所指对象，且内部不能修改指针的指向
     
     被注释掉的代码试图修改指针指向，所以会报错（如果想要修改，在前面加上__block），但是可以修改所指对象的值，如str从“abc”变成了“abcdef”
     */
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"abc"];
//    __block NSMutableString *str = [[NSMutableString alloc] initWithString:@"abc"];
    void(^testBlock3)() = ^{
//        str = [[NSMutableString alloc] initWithString:@"abcdef"];
        [str appendString:@"def"];
        NSLog(@" Block 内部: %@",str);
    };
    NSLog(@"%@",str);
    testBlock3();
    /*
     2016-04-10 16:24:50.302 XRCarouselViewDemo[6297:4379984] abc
     2016-04-10 16:24:50.302 XRCarouselViewDemo[6297:4379984]  Block 内部: abcdef
     */
    
    /*
     d.指针类型---全局变量、静态变量、成员变量\属性
     block不会复制指针，但是会强引用该对象，内部可修改指针指向，block会强引用成员属性\变量所属的对象，这也是为什么block属性内部用到self.xxx会引起循环引用的原因
     
     str2为成员属性，由于NSString是不可变的，所以从打印结果可以看出，在block内部修改了外界指针变量的引用，指向了新的字符串
     */
    static NSString *str3 = @"789";
    void(^testBlock4)() = ^{
        str1 = @"abc";
        self.str2 = @"def";
        str3 = @"ghn";
        NSLog(@"Block 内部 str1 = %@,\nself.str2 = %@,\nstr3 = %@",str1,self.str2,str3);
    };
    NSLog(@"str1 = %@,\nself.str2 = %@,\nstr3 = %@",str1,self.str2,str3);
    testBlock4();
    
    /*
     2016-04-10 16:33:36.702 XRCarouselViewDemo[6301:4381367] str1 = 123,
     self.str2 = 456,
     str3 = 789
     2016-04-10 16:33:36.702 XRCarouselViewDemo[6301:4381367] Block 内部 str1 = abc,
     self.str2 = def,
     str3 = ghn
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
