//
//  TestTableViewController.m
//  NSRunLoopDemo
//
//  Created by MCL on 2016/11/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "TestTableViewController.h"

// 在UITableViewController中启动一个NSTimer，每隔0.5秒刷新Label上的text,刷新100次后暂停。

@interface TestTableViewController ()

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) NSTimer *testTimer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation TestTableViewController

/*
 Run Loop开发中遇到的问题
 
 1） NSTimer, NSURLConnection和NSStream默认运行在Default Mode下，UIScrollView在接收到用户交互事件时，主线程Run Loop会设置为UITrackingRunLoopMode下，这个时候NSTimer不能fire，NSURLConnection的数据也无法处理。
 2）NSTimer的构造方法会对传入的target对象强引用，直到这个timer对象invalidated。在使用时需要注意内存问题，根据需要，要在适当的地方调用invalidated方法。
 
 3) 运行一次的Timer源也可能导致Run Loop退出：一次的Timer在执行完之后会自己从Run Loop中删除，如果使用while来驱动Run Loop的话，下一次再运行Run Loop就可能导致退出，因为此时已经没有其他的源需要监控。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 0;
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    [self.view addSubview:self.testLabel];
    
//    self.testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
    self.testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.testTimer forMode:NSRunLoopCommonModes];
}

- (void)updateTestLabel{
    
    self.count ++;
    self.testLabel.text = [NSString stringWithFormat:@"%ld", self.count];
    if (self.count == 100) {
        [self.testTimer invalidate];
        self.testTimer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
