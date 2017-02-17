//
//  ViewController.m
//  DISPATCHQUEUE
//
//  Created by MCL on 16/3/5.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self SetupView];
}

- (void)SetupView{
    self.view.backgroundColor = [UIColor blueColor];
    self.view.alpha = 0.5;
    
    [self task];
    
}

- (void)task{
    // insert code here...
    NSLog(@"Hello, World!");
    
    /*
     iOS中的多线程技术主要有NSThread, GCD和NSOperation。他们的封装层次依次递增，其中：
     
     NSThread封装性最差，最偏向于底层，主要基于thread使用
     GCD是基于C的API，直接使用比较方便，主要基于task使用
     NSOperation是基于GCD封装的NSObject对象，对于复杂的多线程项目使用比较方便，主要基于队列使用
     */
    
    
//    //一、NSThread
//    //创建并启动
//
//    //先创建线程类，再启动
//    // 创建
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    // 启动
//    [thread start];
//
//    //创建并自动启动
//    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
//
//    //使用 NSObject 的方法创建并自动启动
//    [self performSelectorInBackground:@selector(run) withObject:nil];
    
    
    
//    //二、GCD
//    /*
//     自动管理线程的生命周期（创建线程、调度任务、销毁线程）
//     
//     在 GCD 中就是一个 Block，所以添加任务十分方便。任务有两种执行方式： 同步执行 和 异步执行，他们之间的区别是是否会创建新的线程。
//     
//     同步执行：只要是同步执行的任务，都会在当前线程执行，不会另开线程。
//     
//     异步执行：只要是异步执行的任务，都会另开线程，在别的线程执行。
//     */

//    //1 async ex:
//    /*
//     先在main queue中执行第一个nslog
//     dispatch_async会将block提交到globalQueue中，提交成功之后立即返回
//     main queue执行第二个nslog
//     等global queue中block前面的任务执行完成之后，block被执行。
//     */
//    NSLog(@"1 this is main queue, i want to throw a task to global queue");
//    dispatch_queue_t globalQueue = dispatch_queue_create("com.mcl.global_queue",DISPATCH_QUEUE_SERIAL);
//    dispatch_async(globalQueue, ^{
//        NSLog(@"2 async task begin ...");
//    });
//    NSLog(@"3 this is main queue, throw task completed");
//
//    //2 sync ex:
//    /*
//     先在main queue中执行第一个nslog
//     dispatch_sync会将block提交到global queue中，等待block的执行
//     global queue中block前面的任务执行完成之后，block执行
//     block执行完成之后，dispatch_sync返回
//     dispatch_sync之后的代码执行
//     */
//    NSLog(@"4 this is main queue, i want to throw a task to global queue");
//    dispatch_sync(globalQueue, ^{
//        NSLog(@"5 sync task begin ...");
//    });
//    NSLog(@"6 this is main queue, throw task completed");
//
//    //3 sync ex:
//    /*
//     由于dispatch_sync需要等待block被执行，这就非常容易发生死锁。如果一个串行队列，使用dispatch_sync提交block到自己队列中，就会发生死锁.
//     如果queue是并行队列，或者将任务加入到其他队列中，这是不会发生死锁的。
//
//     死锁需要2个条件：
//
//     代码运行的当前队列是串行队列
//     使用sync将任务加入到自己队列中
//     */
//    dispatch_sync(globalQueue, ^{
//        NSLog(@"7 到达串行队列");
//        dispatch_sync(globalQueue, ^{
//            //发生死锁
//            NSLog(@"8 给队列7加入队列任务8");
//        });
//    });
//    NSLog(@"9 all task over");
//
//
//    //获取队列
//    dispatch_queue_t mainqueue = dispatch_get_main_queue();
//    dispatch_async(mainqueue, ^{
//        NSLog(@"10 获取主线程队列 updateUI");
//    });
//    NSLog(@"11 获取主线程队列over");
//
//    /*全局并行队列：这应该是唯一一个并行队列，只要是并行任务一般都加入到这个队列。*/
//    // 创建队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 设置延时，单位秒
//    double delay = 3;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, ^{
//        // 3秒后需要执行的任务
//    });
//
//    //NSTimer
//    /*
//     NSTimer 是iOS中的一个计时器类，除了延迟执行还有很多用法，不过这里直说延迟执行的用法。同样只写 OC 版的，Swift 也是相同的。
//     */
//    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(run:) userInfo:@"abc" repeats:NO];
    
//    //队列组
//    /*
//     队列组可以将很多队列添加到一个组里，这样做的好处是，当这个组里所有的任务都执行完了，队列组会通过一个方法通知我们。下面是使用方法，这是一个很实用的功能。
//     */
//    //1.创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    //2.创建队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //3.多次使用队列组的方法执行任务, 只有异步方法
//    //3.1.执行3次循环
//    dispatch_group_async(group, queue, ^{
//        for (NSInteger i = 0; i < 3; i++) {
//            NSLog(@"group-01 - %@", [NSThread currentThread]);
//        }
//    });
//    //3.2.主队列执行8次循环
//    dispatch_group_async(group, dispatch_get_main_queue(), ^{
//        for (NSInteger i = 0; i < 8; i++) {
//            NSLog(@"group-02 - %@", [NSThread currentThread]);
//        }
//    });
//    //3.3.执行5次循环
//    dispatch_group_async(group, queue, ^{
//        for (NSInteger i = 0; i < 5; i++) {
//            NSLog(@"group-03 - %@", [NSThread currentThread]);
//        }
//    });
//    //4.都完成后会自动通知
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"完成 - %@", [NSThread currentThread]);
//    });
    
//    //设置目标队列
//
//    NSLog(@"12 设置目标队列begin");
//    dispatch_queue_t queue1 = dispatch_queue_create("com.company.queue1", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue2 = dispatch_queue_create("com.company.queue2", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue1, ^{    // block1
//        for (int i = 0; i < 5; i ++) {
//            NSLog(@"+++++");
//        }
//    });
//    dispatch_async(queue1, ^{ // block2
//        for (int i = 0; i < 5; i ++) {
//            NSLog(@"=====");
//        }
//    });
//    dispatch_async(queue2, ^{    // block3
//        for (int i = 0; i < 5; i ++) {
//            NSLog(@"----");
//        }
//    });
//    NSLog(@"13 设置目标队列over");
    
//    //三、NSOperation和NSOperationQueue
//    /*
//     NSOperation 和 NSOperationQueue 分别对应 GCD 的 任务 和 队列 。操作步骤也很好理解：
//     
//     将要执行的任务封装到一个 NSOperation 对象中。
//     将此任务添加到一个 NSOperationQueue 对象中。
//     */
//    
//    /*添加任务
//     
//     值得说明的是，NSOperation 只是一个抽象类，所以不能封装任务。但它有 2 个子类用于封装任务。分别是：NSInvocationOperation 和 NSBlockOperation 。创建一个 Operation 后，需要调用 start 方法来启动任务，它会 默认在当前队列同步执行。当然你也可以在中途取消一个任务，只需要调用其 cancel 方法即可。
//
//     */
//    //NSInvocationOperation : 需要传入一个方法名。
//    //1.创建NSInvocationOperation对象
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
//    //2.开始执行
//    [operation start];
    
    //NSBlockOperation
//    //1.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    //2.开始任务
//    [operation start];
    
//    //NSBlockOperation 还有一个方法：addExecutionBlock: ，通过这个方法可以给 Operation 添加多个执行 Block。这样 Operation中的任务会并发执行，它会在主线程和其它的多个线程执行这些任务
//    //1.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    //添加多个Block
//    for (NSInteger i = 0; i < 5; i++) {
//        //NOTE：addExecutionBlock 方法必须在 start() 方法之前执行，否则就会报错：
//        [operation addExecutionBlock:^{
//            NSLog(@"第%ld次：%@", (long)i, [NSThread currentThread]);
//        }];
//    }
//    //2.开始任务
//    [operation start];
    
    //队列 NSOperationQueue，按类型来说的话一共有两种类型：主队列、其他队列。只要添加到队列，会自动调用任务的 start() 方法
    
//    //主队列
//    /*
//     每套多线程方案都会有一个主线程（说的是iOS中，像 pthread 这种多系统的方案并没有，因为 UI线程 理论需要每种操作系统自己定制）。这是一个特殊的线程，必须串行。所以添加到主队列的任务都会一个接一个地排着队在主线程处理
//     */
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
//    //其他队列
//    /*
//     因为主队列比较特殊，所以会单独有一个类方法来获得主队列。那么通过初始化产生的队列就是其他队列了，因为只有这两种队列，除了主队列，其他队列就不需要名字了。
//     
//     注意：其他队列的任务会在其他线程并行执行。
//     */
//    //1.创建一个其他队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    //2.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    //3.添加多个Block
//    for (NSInteger i = 0; i < 5; i++) {
//        [operation addExecutionBlock:^{
//            NSLog(@"第%ld次：%@", (long)i, [NSThread currentThread]);
//        }];
//    }
//    //4.队列添加任务
//    [queue addOperation:operation];
    
//    /*
//     NSOperation 有一个非常实用的功能，那就是添加依赖。比如有 3 个任务：A: 从服务器上下载一张图片，B：给这张图片加个水印，C：把图片返回给服务器。这时就可以用到依赖了:
//     
//     注意：
//     
//     不能添加相互依赖，会死锁，比如 A依赖B，B依赖A。
//     可以使用 removeDependency 来解除依赖关系。
//     可以在不同的队列之间依赖，反正就是这个依赖是添加到任务身上的，和队列没关系。
//     */
//    //1.任务一：下载图片
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"下载图片 - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    //2.任务二：打水印
//    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"打水印   - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    //3.任务三：上传图片
//    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"上传图片 - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    //4.设置依赖
//    [operation2 addDependency:operation1];      //任务二依赖任务一
//    [operation3 addDependency:operation2];      //任务三依赖任务二
//    //5.创建队列并加入任务
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
    
    
    /*
     线程同步
     
     所谓线程同步就是为了防止多个线程抢夺同一个资源造成的数据安全问题，所采取的一种措施。当然也有很多实现方法，请往下看：
     */
    
//    //互斥锁 ：给需要同步的代码块加一个互斥锁，就可以保证每次只有一个线程访问此代码块。
//    @synchronized(self) {
//        //需要执行的代码块
//    }
    
//    //同步执行 ：我们可以使用多线程的知识，把多个线程都要执行此段代码添加到同一个串行队列，这样就实现了线程同步的概念。当然这里可以使用 GCD 和 NSOperation 两种方案。
//    //GCD
//    //需要一个全局变量queue，要让所有线程的这个操作都加到一个queue中
//    dispatch_sync(queue, ^{
//        NSInteger ticket = lastTicket;
//        [NSThread sleepForTimeInterval:0.1];
//        NSLog(@"%ld - %@",ticket, [NSThread currentThread]);
//        ticket -= 1;
//        lastTicket = ticket;
//    });
//    //NSOperation & NSOperationQueue
//    //重点：1. 全局的 NSOperationQueue, 所有的操作添加到同一个queue中
//    //       2. 设置 queue 的 maxConcurrentOperationCount 为 1
//    //       3. 如果后续操作需要Block中的结果，就需要调用每个操作的waitUntilFinished，阻塞当前线程，一直等到当前操作完成，才允许执行后面的。waitUntilFinished 要在添加到队列之后！
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSInteger ticket = lastTicket;
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"%ld - %@",ticket, [NSThread currentThread]);
//        ticket -= 1;
//        lastTicket = ticket;
//    }];
//    [queue addOperation:operation];
//    [operation waitUntilFinished];
//    //后续要做的事续要做的事
    
    
}

- (void)run{
    
    NSLog(@"%s:%d",__func__, __LINE__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
