//
//  WebViewViewController.h
//  WKWebView
//
//  Created by MCL on 2017/1/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

//UIWebView自iOS2就有，UIWebView不仅可以加载HTML页面，还支持pdf、word、txt、各种图片等等的显示。缺点是占用过多内存，且内存峰值更是夸张。

#import <UIKit/UIKit.h>

@interface UIWebViewViewController : UIViewController

@end

/*
 与js交互
 主要有两方面：js执行OC代码、oc调取写好的js代码
 
 js执行OC代码：js是不能执行oc代码的，但是可以变相的执行，js可以将要执行的操作封装到网络请求里面，然后oc拦截这个请求，获取url里面的字符串解析即可，这里用到代理协议的- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType函数。
 oc调取写好的js代码：这里用到UIwebview的一个方法。示例代码一个是网页定位，一个是获取网页title：
     // 实现自动定位js代码, htmlLocationID为定位的位置(由js开发人员给出)，实现自动定位代码，应该在网页加载完成之后再调用
     NSString *javascriptStr = [NSString stringWithFormat:@"window.location.href = '#%@'",htmlLocationID];
     // webview执行代码
     [self.webView stringByEvaluatingJavaScriptFromString:javascriptStr];
     
     // 获取网页的title
     NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]

 */
