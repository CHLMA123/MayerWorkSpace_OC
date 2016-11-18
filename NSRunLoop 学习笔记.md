# MayerWorkSpace_OC
不积跬步无以至千里

OSX/iOS 的系统架构：

苹果官方将整个系统大致划分为上述4个层次：
应用层包括用户能接触到的图形应用，例如 Spotlight、Aqua、SpringBoard 等。
应用框架层即开发人员接触到的 Cocoa 等框架。
核心框架层包括各种核心框架、OpenGL 等内容。
Darwin 即操作系统的核心，包括系统内核、驱动、Shell 等内容，这一层是开源的，其所有源码都可以在 opensource.apple.com 里找到。

苹果用 RunLoop 实现的功能：
    AutoreleasePool
    事件响应
    手势识别
    界面更新
    定时器
    PerformSelecter
    关于GCD
    关于网络请求

系统默认注册了5个Mode:
1. kCFRunLoopDefaultMode: App的默认 Mode，通常主线程是在这个 Mode 下运行的。
2. UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用。
4: GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到。
5: kCFRunLoopCommonModes: 这是一个占位的 Mode，没有实际作用。


NSRunLoop 学习笔记
http://blog.iostalks.com/2016/05/25/NSRunLoop-study-note/

1. 什么是 NSRunLoop

一般来说，一个线程一次只能执行一个任务，任务执行完毕后线程便会退出。如果我们想让线程持续的为我们处理事件（比如点击屏幕），就需要有一个循环来阻止线程的退出。
实际中，我们的应用程序是可以随时响应外部事件的，这就是 NSRunLoop 起的作用，RunLoop 为线程提供了事件循环的入口，并管理其需要处理的事件和消息。

2. RunLoop 和线程之间的关系

iOS 中线程默认会绑定有 RunLoop，每一个线程对应一个 RunLoop 对象。我们并不能自己创建 RunLoop，但是可以在当前线程使用 + currentRunLoop 获取，如果不主动获取，它就一直不会有。

NSRunLoop 是基于 CFRunLoopRef 的封装，提供面向对象的 API， 但是 NSRunLoop 是线程不安全的。除了主线程外，只能在当前线程内部获取其 RunLoop。

主线程的 RunLoop 会在 App 启动时自动的运行，子线程需要手动运行。在子线程中若只需要线性执行任务，那可以不用理会 RunLoop ；但是当需要在子线程中处理循环事件时，比如 NSTimer 事件，就必须要手动获取 RunLoop ，并保证线程不退出。

3. RunLoop 退出（返回）是什么意思和线程退出有什么关系？

在自定义线程中，RunLoop 的退出和线程的退出本质上并没有什么联系。接口文档中 RunLoop 有一下几种方式进入循环状态：

// 运行 NSRunLoop，运行模式为默认的 NSDefaultRunLoopMode 模式，没有超时限制
- (void)run; 


// 运行 NSRunLoop: 参数为运时间期限，运行模式为默认的 NSDefaultRunLoopMode 模式
- (void)runUntilDate:(NSDate *)limitDate;


// 运行 NSRunLoop: 参数为运行模式、时间期限，返回值为 YES 表示是处理事件后返回的，NO 表示是超时、强制停止运行或者当前 mode 下没有任何事件导致的返回
- (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;

进入循环状态后，就类似进入了一个 do-while 循环。之后只有两种情况，要么退出循环，要么一直循环。退出循环代表 RunLoop 返回了，一直循环若没有事件加入 RunLoop 便会沉睡，接收到下一次事件时又会被唤醒。

若 RunLoop 从循环状态中退出了，且线程的 main 函数中没有其他的循环包裹，那么执行完 main 方法后整个线程便会退出。

为了保证线程的不退出，我们一般会在运行 Runloop 的外层用 while 循环包裹，形势如下：

- (void)main
{
    // 添加事件源
    [self myInstallCustomInputSource];
    while (!self.isCancelled)
    {
        [self doSomeTask];
        BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
        beforeDate:[NSDate distantFuture]];
        NSLog(@"Exiting runloop: %d", ret);

    }
}

当线我们需要持续处理事件时，保持外部循环条件为 YES，这样即使 RunLoop 在执行事件时候退出了一次，也不会导致整个线程退出。

4. RunLoop 何时退出？

RunLoop 的退出与当前 mode 下的 item 密切相关。一个 RunLoop 包含若干个 Mode，每个 mode 又包含若干个 Source/Timer/Observer。 在子线程的 main 函数中启动 RunLoop，都需要指定一种 mode，默认情况下为 NSDefaultRunLoopMode。

Source/Timer/Observer 被称为 mode item，若 mode 中一个 item 也没有，那么 RunLoop 就会从这种 mode 中退出。

我们也可以手动调用 CFRunLoopStop(CFRunLoopRef rl) 方法来强制 RunLoop 退出，然而它只对 -runMode:beforeDate: 启动的 RunLoop 有效，对 -run 启动的无效。

处理完 Input Source item 事件之后 RunLoop 就会退出，而处理 Timer item 事件不会导致 RunLoop 退出。

系统提供的几个 -performSelector: API调用的 selector 被分发一次就会导致 RunLoop 退出，然而 performSelector:onThread: 和 performSelector:afterDelay: 比调特殊，它会向当前线程中加入 Timer，当再次进入 RunLoop 时，若无其他事件处理，RunLoop不会退出，而是进入睡眠状态。

5. 什么时候需要用到 RunLoop？

    需要使用 Port 或者自定义 Input Source 与其他线程进行通信;
    需要在线程中使用 NSTimer;（应用场景举例：主线程的 RunLoop 里有两个预置的 Mode：kCFRunLoopDefaultMode 和 UITrackingRunLoopMode。这两个 Mode 都已经被标记为"Common"属性。DefaultMode 是 App 平时所处的状态，TrackingRunLoopMode 是追踪 ScrollView 滑动时的状态。当你创建一个 Timer 并加到 DefaultMode 时，Timer 会得到重复回调，但此时滑动一个TableView时，RunLoop 会将 mode 切换为 TrackingRunLoopMode，这时 Timer 就不会被回调，并且也不会影响到滑动操作。在有 ScrollView 的界面，为了防止定时器失效，需要将定时器加入到 NSRunLoopCommonModes 中去。）
    在子线程外部 performSelector:onThread: 方法到该线程。
    使用子线程执行周期性的任务;(在子线程中持续处理定时器事件)
    NSURLConnection 在子线程发起异步请求调用;

NSRunLoop Guide:
https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW1

NSRunLoop Guide:
http://blog.ibireme.com/2015/05/18/runloop/

一个机制，让线程能随时处理事件但并不退出。通常的代码逻辑是这样的：
function loop() {
initialize();
do {
var message = get_next_message();
process_message(message);
} while (message != quit);
}
这种模型通常被称作 Event Loop。实现这种模型的关键点在于：如何管理事件/消息，如何让线程在没有处理消息时休眠以避免资源占用、在有消息到来时立刻被唤醒。
RunLoop 实际上就是一个对象，这个对象管理了其需要处理的事件和消息，并提供了一个入口函数来执行上面 Event Loop 的逻辑。线程执行了这个函数后，就会一直处于这个函数内部 "接受消息->等待->处理" 的循环中，直到这个循环结束（比如传入 quit 的消息），函数返回。

RunLoop 与线程的关系：

线程和 RunLoop 之间是一一对应的，其关系是保存在一个全局的 Dictionary 里。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。RunLoop 的创建是发生在第一次获取时，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其 RunLoop（主线程除外）。


RunLoop 的实际应用举例


AsyncDisplayKit

AsyncDisplayKit 是 Facebook 推出的用于保持界面流畅性的框架，其原理大致如下：

UI 线程中一旦出现繁重的任务就会导致界面卡顿，这类任务通常分为3类：排版，绘制，UI对象操作。

排版通常包括计算视图大小、计算文本高度、重新计算子式图的排版等操作。
绘制一般有文本绘制 (例如 CoreText)、图片绘制 (例如预先解压)、元素绘制 (Quartz)等操作。
UI对象操作通常包括 UIView/CALayer 等 UI 对象的创建、设置属性和销毁。

其中前两类操作可以通过各种方法扔到后台线程执行，而最后一类操作只能在主线程完成，并且有时后面的操作需要依赖前面操作的结果 （例如TextView创建时可能需要提前计算出文本的大小）。ASDK 所做的，就是尽量将能放入后台的任务放入后台，不能的则尽量推迟 (例如视图的创建、属性的调整)。

为此，ASDK 创建了一个名为 ASDisplayNode 的对象，并在内部封装了 UIView/CALayer，它具有和 UIView/CALayer 相似的属性，例如 frame、backgroundColor等。所有这些属性都可以在后台线程更改，开发者可以只通过 Node 来操作其内部的 UIView/CALayer，这样就可以将排版和绘制放入了后台线程。但是无论怎么操作，这些属性总需要在某个时刻同步到主线程的 UIView/CALayer 去。

ASDK 仿照 QuartzCore/UIKit 框架的模式，实现了一套类似的界面更新的机制：即在主线程的 RunLoop 中添加一个 Observer，监听了 kCFRunLoopBeforeWaiting 和 kCFRunLoopExit 事件，在收到回调时，遍历所有之前放入队列的待处理的任务，然后一一执行。
具体的代码可以看这里：_ASAsyncTransactionGroup。

















