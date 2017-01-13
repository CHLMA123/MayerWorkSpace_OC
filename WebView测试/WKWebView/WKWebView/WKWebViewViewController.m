//
//  ViewController.m
//  WKWebView
//
//  Created by MCL on 2017/1/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

/// WebView基本使用，打开本地文件，打开网站，与js交互等等

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *mWKWebView;

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"WKWebView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mWKWebView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKWebView WKNavigationDelegate 相关

/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    NSLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSLog(@"protocolHead=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark Setter && Getter
/**
 1.创建webview，并设置大小，"20"为状态栏高度
 2.创建请求
 3.加载网页
 */
- (WKWebView *)mUIWebView{
    
    if (_mWKWebView == nil) {
        
        _mWKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
        _mWKWebView.navigationDelegate = self;
        [_mWKWebView loadRequest:request];
    }
    return _mWKWebView;
}

@end
