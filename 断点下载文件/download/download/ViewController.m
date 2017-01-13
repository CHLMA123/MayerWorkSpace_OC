//
//  ViewController.m
//  download
//
//  Created by zengjia on 17/1/8.
//  Copyright © 2017年 zengjia. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIImageView *imagev;

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) UIButton *sessionBtn;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, strong) NSData *resumeData; // 恢复操作需要resumeData
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self smallFileDoenload];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationWillBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    [self downloadSession];
    
   NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:@"downLoadStore"];
    NSLog(@"Dic -=%@",dic);
    
    
    
}


- (UIButton *)sessionBtn
{
    if (!_sessionBtn) {
        
        _sessionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sessionBtn.frame = CGRectMake(100, 200, 80, 40);

        [_sessionBtn setTitle:@"开始" forState: UIControlStateNormal];
        _sessionBtn.backgroundColor = [UIColor blueColor];
        [_sessionBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sessionBtn;

}


- (void)downloadAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        // 开始执行 && 恢复操作
        if (_resumeData!=nil) {
            // 恢复操作
            self.downloadTask =  [self.session downloadTaskWithResumeData:self.resumeData];
            [self.downloadTask resume];
        }else
        {
            // 从本地获取上次任务信息
            // NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"downLoadStore"];
            [self.downloadTask resume]; // 开始任务
        };
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }else
    {
        // 暂停
        [self .downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
           
            //记录位置 后台退出或异常退出需要保存该位置，可以在下载启动时继续下载
            if (resumeData) {
                NSDictionary *doladTask = @{self.downloadTask.currentRequest.URL.path:resumeData};
                
                [[NSUserDefaults standardUserDefaults] setObject:doladTask forKey:@"downLoadStore"];
            }
            
    
            
            self.resumeData = resumeData;
            
            
            NSLog(@"url = %@",self.downloadTask.currentRequest.URL);
            
            //  self.dowanloadTask.response.suggestedFilename 文件名
            // self.dowanloadTask.currentRequest.URL 文件请求链接
            // self.dowanloadTask.countOfBytesExpectedToReceive 文件总大小
            
            
            // 取消任务
            self.downloadTask = nil;
            
        }];
        
        [sender setTitle:@"开始" forState:UIControlStateNormal];

        
        
        
    }
}

// 使用NSURLSession  实现下载
- (void)downloadSession
{
    [self.view addSubview:self.sessionBtn];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"];
    self.downloadTask = [_session downloadTaskWithURL:url];
}

- (void)UIApplicationWillBecomeActive
{
    if (_sessionBtn.selected) {
        [self.downloadTask resume];  // 恢复
    }
}

- (void)UIApplicationWillResignActive{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self.downloadTask suspend]; // 挂起任务
}

#pragma mark NSURLSessionDownloadDelagate
// 下载结束
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // 下载到temp 文件夹中
    // 在下载结束之后会 自动删除文件，将文件复制到其他路径下
    NSLog(@"loacation = %@",location);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *filMange = [NSFileManager defaultManager];
    
    [filMange moveItemAtPath:location.path toPath:path error:nil];
    
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"提示" message:@"下载结束" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 正在下载
/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"这次写入的大小:%lld  已经写入沙盒的大小 :%lld 文件总大小:%lld",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    
    
}

// 恢复下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}
//2017-01-08 17:02:08.635 download[1297:58085] 这次写入的大小:85760  已经写入沙盒的大小 :8050504 文件总大小:34425437



















// 常规小文件下载

- (UIImageView *)imagev

{
    if (!_imagev) {
        _imagev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)
                   ];
    }
    return _imagev;
}



- (void)smallFileDoenload
{
    NSURL *url = [NSURL URLWithString:@"https://picjumbo.imgix.net/HNCK8461.jpg?q=40&w=1650&sharp=30"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];

       dispatch_async(dispatch_get_main_queue(), ^{
           
           self.imagev.image = [UIImage imageWithData:data];
           [self.view addSubview:self.imagev];
       });
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
