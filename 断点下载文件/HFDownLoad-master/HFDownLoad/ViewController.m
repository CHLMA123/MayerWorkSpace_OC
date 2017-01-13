//
//  ViewController.m
//  HFDownLoad
//
//  Created by 洪峰 on 15/9/7.
//  Copyright (c) 2015年 洪峰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"sandbox:%@", NSHomeDirectory());
    NSLog(@"NSDocumentDirectory:%@", [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]);
    /*
     2017-01-09 14:35:26.909 HFDownLoad[1092:383623] sandbox:/var/mobile/Containers/Data/Application/0EFD4EC3-835F-4292-AEFD-C8B0268AB83F
     2017-01-09 14:35:26.911 HFDownLoad[1092:383623] NSDocumentDirectory:(
     "file:///var/mobile/Containers/Data/Application/0EFD4EC3-835F-4292-AEFD-C8B0268AB83F/Documents/"
     )
     */
    
    /*
     小文件下载
     
     小文件可以是一张图片，或者一个文件，这里指在现行的网络状况下基本上不需要等待很久就能下载好的文件。
     // 1.NSData dataWithContentsOfURL
     // 2.NSURLConnection
     
     PS:上面的两个方法去下载大文件是不合理的，因为这两个方法都是一次性返回整个下载到的文件，返回的data在内存中，如果下载一个几百兆的东西，内存肯定会爆的。
     */

    NSURL* url = [NSURL URLWithString:@"https://picjumbo.imgix.net/HNCK8461.jpg?q=40&w=1650&sharp=30"];
    
//    [self downloadImageWithUrl:url];
    [self downloadImage2WithUrl:url];
}

/**
 *  NSData dataWithContentsOfURL 下载文件
 */
- (void)downloadImageWithUrl:(NSURL *)url
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 其实是发送一个Get 请求
        NSData* data = [NSData dataWithContentsOfURL:url];
        
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = [UIImage imageWithData:data];
        });
    });
}

/**
 *  NSURLConnection 下载文件
 */
- (void)downloadImage2WithUrl:(NSURL *)url
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        self.imageView.image = [UIImage imageWithData:data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
