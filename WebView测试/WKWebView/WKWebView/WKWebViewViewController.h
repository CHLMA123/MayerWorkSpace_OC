//
//  ViewController.h
//  WKWebView
//
//  Created by MCL on 2017/1/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

// WKWebView从iOS8才有，网页加载速度有提升.更多的支持HTML5的特性,将UIWebViewDelegate与UIWebView拆分成了14类与3个协议
// 另外用的比较多的，增加加载进度属性：estimatedProgress

#import <UIKit/UIKit.h>

@interface WKWebViewViewController : UIViewController


@end

/*
 相比UIWebview，WKWebView也支持各种文件格式，并新增了loadFileURL函数，顾名思义加载本地文件。
 /// 模拟器调试加载mac本地文件
 - (void)loadLocalFile {
 // 1.创建webview，并设置大小，"20"为状态栏高度
 WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
 // 2.创建url  userName：电脑用户名
 NSURL *url = [NSURL fileURLWithPath:@"/Users/userName/Desktop/bigIcon.png"];
 // 3.加载文件
 [webView loadFileURL:url allowingReadAccessToURL:url];
 // 最后将webView添加到界面
 [self.view addSubview:webView];
 }
 
 
 网页导航刷新相关函数
 和UIWebview几乎一样，不同的是有返回值，WKNavigation(已更新)，另外增加了函数reloadFromOrigin和goToBackForwardListItem。
 
 reloadFromOrigin会比较网络数据是否有变化，没有变化则使用缓存，否则从新请求。
 goToBackForwardListItem：比向前向后更强大，可以跳转到某个指定历史页面

 
 代理协议使用
 
 一共有三个代理协议：
 
 WKNavigationDelegate：最常用，和UIWebViewDelegate功能类似，追踪加载过程，有是否允许加载、开始加载、加载完成、加载失败。下面会对函数做简单的说明，并用数字标出调用的先后次序：1-2-3-4-5
 
 三个是否允许加载函数：
 
     /// 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
     - (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
     /// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
     - (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
     /// 1 在发送请求之前，决定是否跳转
     - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
 
 追踪加载过程函数:
 
     /// 2 页面开始加载
     - (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
     /// 4 开始获取到网页内容时返回
     - (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
     /// 5 页面加载完成之后调用
     - (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
     /// 页面加载失败时调用
     - (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigatio
 
 
 
 */
