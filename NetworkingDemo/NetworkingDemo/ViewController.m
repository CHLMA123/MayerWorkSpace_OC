//
//  ViewController.m
//  NetworkingDemo
//
//  Created by APP on 2017/3/2.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "WebClient+Auth.h"

@interface ViewController ()<WebClientDelegate>

@property (nonatomic, strong)WebClient *webClient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.webClient registerWithType:WebClientRegister username:@"" password:@"" country:@"" language:@"" accessType:@"" appClientVersion:@"1.0.0" oemCode:@"11111"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebClientDelegate
- (void)webClient:(WebClient *)webClient interfaceType:(WebClientInterfaceTypes)type didFailWithError:(WBError *)error{
    NSLog(@"获取数据Fail");
}

- (void)webClient:(WebClient *)webClient interfaceType:(WebClientInterfaceTypes)type didReceiveResponse:(id)response{
    NSLog(@"获取数据Ok");
}

#pragma mark - Getter && Setter
- (WebClient *)webClient{
    if (!_webClient){
        _webClient = [[WebClient alloc] initWithBaseURLString:kWebClientBaseURL];
        _webClient.delegate = self;
    }
    return _webClient;
}

@end
