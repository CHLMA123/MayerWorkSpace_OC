//
//  MARawFileAPIsViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MARawFileAPIsViewController.h"

@interface MARawFileAPIsViewController ()

@end

@implementation MARawFileAPIsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _path = [NSTemporaryDirectory() stringByAppendingString:@"saveAsC.txt"];
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
    // File path
    const char * pFilePath = [_path cStringUsingEncoding:NSUTF8StringEncoding];
    
    // Create a new file
    FILE * pFile = fopen(pFilePath, "w+");
    
    if (pFile == NULL) {
        NSLog(@"Open File ERROR!");
        return;
    }
    
    const char * content = [_textField.text cStringUsingEncoding:NSUTF8StringEncoding];
    fwrite(content, sizeof(content), 1, pFile);
    fclose(pFile);
}

- (void)loadData {
    // File path
    const char * pFilePath = [_path cStringUsingEncoding:NSUTF8StringEncoding];
    
    // Create a new file
    FILE * pFile = fopen(pFilePath, "r+");
    
    if (pFile == NULL) {
        NSLog(@"Open File ERROR!");
        return;
    }
    
    int fileSize = ftell(pFile);
    NSLog(@"fileSize: %d", fileSize);
    
    char * content[20];
    
    fread(content, 20, 20, pFile);
    
    NSString * aStr = [NSString stringWithFormat:@"%s", &content];
    
    if (aStr != nil && ![aStr isEqualToString:@""]) {
        _textField.text = aStr;
    }
    
    fclose(pFile);
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
