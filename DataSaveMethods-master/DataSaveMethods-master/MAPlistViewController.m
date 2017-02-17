//
//  MAPlistViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MAPlistViewController.h"

@interface MAPlistViewController ()

@end

@implementation MAPlistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /**
         IOS应用程序采用沙盒原理设计，ios每个应用程序都有自己的3个目录(Document,Library,tmp)，互相之间不能访问。
         
         1  Documents存放应用程序的数据。
             - (NSString*)filePath:(NSString*)fileName {
                 //获得应用程序的Documents文件夹。
                 NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString* myDocPath = [myPaths objectAtIndex:0];
                 //获取文件的完整路径。
                 NSString* filePath = [myDocPath stringByAppendingPathComponent:fileName];
                 return filePath;
             }
         
         2  Library目录下面还有Preferences和Caches目录，Preferences目录存放应用程序的使用偏好，Caches目录与Documents很相 似可以存放应用程序的数据。
         
         3  tmp目录供应用程序存储临时文件。
            使用函数NSTemporaryDirectory ()可以获得tmp目录路径。
                NSString* tempPath = NSTemporaryDirectory();
            获取文件的完整路径。
                NSString* tempFile = [tempPath stringByAppendingPathComponent:@"properties.plist"];
         */
        _path = [NSTemporaryDirectory() stringByAppendingString:@"save.plist"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (void)initView {
    // Init View
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44)];
    _textField.backgroundColor = [UIColor lightGrayColor];
    _textField.placeholder = @"No data saved yet.";
    _textField.center = CGPointMake(self.view.center.x, _textField.center.y);
    _textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textField];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveData)];
}

- (void)initData {
    // Init Data
    [self loadData];
}

#pragma mark - Data
- (void)saveData {
    
    NSFileManager * aFileManager = [NSFileManager defaultManager];
    if (![aFileManager fileExistsAtPath:_path]){
        // 文件不存在，创建之
        NSMutableDictionary * aDefaultDict = [[NSMutableDictionary alloc] init];
        [aDefaultDict setObject:@"test" forKey:@"TestText"];
        
        if (![aDefaultDict writeToFile:_path atomically:YES]) {
            NSLog(@"OMG!!!");
        }

    }
    // 写入数据
    NSMutableDictionary * aDataDict = [NSMutableDictionary dictionaryWithContentsOfFile:_path];
    [aDataDict setObject:_textField.text forKey:@"TestText"];
    if (![aDataDict writeToFile:_path atomically:YES]) {
        NSLog(@"OMG!!!");
    }
}

- (void)loadData {
    NSMutableDictionary * aDataDict = [NSMutableDictionary dictionaryWithContentsOfFile:_path];
    NSString * aStr = [aDataDict objectForKey:@"TestText"];
    if (aStr != nil && aStr.length > 0) {
        _textField.text = aStr;
    }
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
