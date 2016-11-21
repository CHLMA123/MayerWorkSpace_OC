# MayerWorkSpace_OC
不积跬步无以至千里

#pragma mark - NSNotificationDemo

Notification的总结 :

1 对象之间通信的标准方式是发送消息，一个object直接调用另一个object的方法。前提是你需要知道两个对象及要发送的消息的内容。而且这样子耦合度太高，绑定了两个本来是独立的object。
2 NSNotification包含 a name, an object, and an optional dictionary
3 Any object may post a notification
4 NSNotificationCenter处理单进程之间的通知
5 NSDistributedNotificationCenter处理单个计算机上不同的进程之间的通知。
6 每个进程都会创建一个NotificationCenter，这个center通过NSNotificationCenter defaultCenter获取。
7 NoticiationCenter以同步（非异步，会等待，会阻塞）的方式发送请求，即，当发送通知时，center会一直等待所有的observer都收到并且处理了通知才会返回到poster。如果需要异步发送通知，请使用notificationQueue
8 在一个多线程的应用程序中，通知会发送到所有的线程中。
9 每个进程都有一个distrubuted notification center， 可以通过NSDistributedNotificationCenter +defaultCenter 访问，这个distributed notification center 处理 单个机器不同线程之间的通知。若需要不同的机器之间通信，需要使用distrubted object
10 发送distrubuted notification是非常消耗资源的操作，distrubted notification需要被发送到系统级别的服务中，然后分发给有object注册过次通知的进程中，distrubted通知发送之后与收到通知之间的延迟是不确定的，如果有太多通知发送出去天充满了系统的sever，则这个distrubuted noification可能会被丢弃。
11 Distributed notifications是通过进程的runloop发送的。要接受distrubuted notifiation，这个进程必须以通常的普通的run loop模式运行，比如NSDefaultRunLoopMode，如果接受的进程是多线程的，那么就不要指望着通知会发送到主线程，虽然通常distrubuted notification是发送到主线程，但是其他线程也可能收到通知，。
12 普通通知包含的object可以为object指针，但distrubuted的object必须为string，因为不同的进程中指针是不同的。
13 NSNotificationQueue，就像是notification的缓冲池。它有两个重要的feature，合并notifications以及异步发送通知。
14 NSNotificationQueue通常以FIFO(先进先出)的原则处理通知，当一个notification到了队列前面，queue把它发送到notification Center，然后notification center再把它发送到observer。
15 每个线程都有一个与notification center相关的queue，你也可以创建自己的queue，这样就形成一个center和多个queue。
16 用NSNotificationQueue’s enqueueNotification:postingStyle: and enqueueNotification:postingStyle:coalesceMask:forModes:的方法，你可以把通知放到queue里面异步的发送给线程。把通知放到queue以后这些方法会立刻返回，不做等待。
17 notification有三种style放到queue， NSPostASAP, NSPostWhenIdle, and NSPostNow. 
18 可以通过设置第三个参数coalesce，使多个相同的notification在queue里可以被合并为一个。


//=========================================================================

Notifications

Notification包装了事件的信息, 比如窗口正在获取焦点或者网络连接正在断开. 需要订阅事件(例如, 一个文件想要知道正在编辑它的窗口将要被关闭)的object需要在notification center注册, 之后当事件发生的时候就会得到通知. 当事件发生的时候, 一个notification会被发送到notification center, 而后notification center马上就会把这个notification转发给所有订阅过这个事件的object. 当需要的时候, notification会被缓存在notification queue中….

Notification的原理

在两个object之间传递信息最标准的方法是传递消息 – 一个object调用另外一个object的方法. 但是, 传递的消息这种方法要求发送消息的object知道消息的接收者和它能接收的消息类型. 这将会把两个object紧密的绑定起来 – 最值得注意的是这会让两个本来独立的子系统耦合在一起. 为了解决这些问题, 广播模型被提了出来. Object只是负责发送notification, 而NSNotificationCenter将负责把这个notification转发给所有相关的object.

一个NSNotification(在这片文章里面简称notification)包含一个name, 一个object和一个可选的dictionary. Name是notification的标识. Object包含notification发送者想要发送的任意类型的object(一般来说就是发送这个notification的object本身). Dictionary用来保存其他相关的东西(如果有的话).

任意object都可以发送notification. 任意object都可以在notification center注册以便在某个事件发生的时候能够得到通知. Notification center负责把接受的notification发送给所有注册过的消息接收者. 发送notification的object, notification里面包含的object和接收这个notification的object可以是同一个object, 也可以是三个不同的object. 发送notification的object不需要知道关于接受者的任何信息. 但是, 接受者至少需要知道notification的name和其所包含dictionary的key(如果有的话).

Notification和Delegation

就使用上看, notification系统和delegate很像, 但是他们有以下不同:

*Notification的接受者可以是多个object. 但是delegate object只能有一个. 这就阻止了返回值.
*一个object可以从notification center接受它想要的任意数量个notification, 而delegate只能接受预先定义好的delegate方法.
*发送notification的object完全不知到接受者是否存在.

Notification Centers

Notification center负责接收和发送notification. 当它接受到notification的时候会通知所有符合特定条件的接受者. Notification信息被包装在NSNotification里. Notification接收者在notification center里面注册以获得其他object发出的notification. 当事件发生的时候, 一个object发送相关的notification到notification center. Notification center将消息分发给每一个注册过的接受者. 发送notification的object和接受者可能是同一个.

Cocoa包含两种notification center:

*NSNotificationCenter类管理单个进程内部的notification.
*NSDistributedNotificationCenter管理一台机器上跨进程的notification.

NSNotificationCenter

每一个进程都有一个默认的notification center, 你可以通过访问 NSNotificationCenter 的 +defaultCenter方法来得到它. 这种类型的notification center负责管理单个进程内部的notification. 如果需要管理同一台机器上不同进程之间的notification则需要用到NSDistributedNotificationCenter.

Notification center发送notification给接收者的方法是同步的. 也就是说, 当发送一个notification的时候, 除非所有的接收者都接到和处理了这个notification, 否则不会返回. 想要发送异步notification的话就需要用到notification queue了.

在一个多线程应用程序里, notification总是和发送者处于同一个线程里, 但是接受者可以在其他线程里.

NSDistributedNotificationCenter

每一个进程都有一个默认的distributed notification center, 你可以通过访问 NSDistributedNotificationCenter 的 +defaultCenter方法来得到它. 这种类型的notification center负责管理一台机器上多个进程之间的notification. 如果需要在多台机器间通讯的话, 使用distributed objects.

发送一个distributed notification是非常昂贵的. Notification首先会被发送到一个系统级别的服务器上, 然后在分别分发到每一个注册过的进程里. 从发从消息到消息被接受到之间的延迟理论上来说是无限的. 事实上, 如果太多的notification被发送到服务器上, 那么服务器上的notification队列可能会被撑满, 这就有可能会造成notification的丢失.

Distributed notification会在一个进程的主循环里被发送出去. 一个进程必须保证有一个主循环在其内部运行, 例如 NSDefaultRunLoopMode, 然后才能接受到distributed notification. 如果接收进程是多线程的, 那么notification并不一定会被主线程接受到. 一般来说notification会被分发到主线程的主循环, 但是其他线程一样可以接收到.

一般类型的notification center可以注册所有object的notification, 但是 distributed notification center只能注册字符串类型的notification. 因为发送者和接受者可能在不同进程里, notification里面包含的object不能保证指向同一个object. 所以, distributed notification center只能接受包含字符串类型的notification. Notification会基于字符串来匹配.

http://www.cnblogs.com/xiaouisme/archive/2012/04/06/2434753.html
http://blog.csdn.net/robincui2011/article/details/9410181

