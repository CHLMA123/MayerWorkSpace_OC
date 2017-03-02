# FDFullscreenPopGesture 是一个支持全屏POP手势的iOS第三方库

/*
一个第三方库 :https://github.com/CHLMA123/FDFullscreenPopGesture
对系统的侧滑返回手势进行拓展，不用从边缘滑动，只要右滑即可返回。最重要的是，只需要加入项目中即可，不需要一行代码即可实现。

just add 2 files and no need for any setups, all navigation controllers will be able to use fullscreen pop gesture automatically.

To disable this pop gesture of a navigation controller:

navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
To disable this pop gesture of a view controller:

viewController.fd_interactivePopDisabled = YES;
*/



定义基于UINavigationController的一个Category，好处就是不用继承就可以直接使用。

把它添加到工程里面，什么代码都不用写，所有 UINavigationController 就自带这个全屏返回（屏幕边缘右划返回）效果了。

一个 UINavigationController 管理了串行的 N 个 UIViewController 栈式的 push 和 pop，而 UINavigationBar 由 UINavigationController 管理，这就导致了 UIViewController 无法控制自己上面的 bar 单独的隐藏或显示。 这非常像 UIApplication 全局的 status bar，牵一发还得动全身，不过 Apple 在 iOS7 之后为 vc 控制自己的 status bar 提供了下面几个方法：

- (UIStatusBarStyle)preferredStatusBarStyle NS_AVAILABLE_IOS(7_0);
- (BOOL)prefersStatusBarHidden NS_AVAILABLE_IOS(7_0);
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation NS_AVAILABLE_IOS(7_0);

终于让这个全局变量变成了局部变量，虽然写起来费劲了些。
但是对 UINavigationBar 的控制，依然是全局的，可能 Apple 觉得 App 不应该有这种奇怪的页面结构？

解决这个问题的方法也不难，在滑动返回的后要出现的那个 view controller 中写下面的代码：

- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
[self.navigationController setNavigationBarHidden:YES animated:animated];
}

系统就会把有 bar 和 无 bar 的 transition 动画衔接起来。