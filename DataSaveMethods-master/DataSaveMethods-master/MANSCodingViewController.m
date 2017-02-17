//
//  MANSCodingViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MANSCodingViewController.h"

#define DATA_FILE @"NSCodingData.plist"
#define DATA_KEY  @"data"

@interface MANSCodingViewController ()

@end

@implementation MANSCodingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _path = [NSTemporaryDirectory() stringByAppendingString:DATA_FILE];
        self.title = @"NSCoding";
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
    NSLog(@"init data");
    [self loadData];
}

#pragma mark - Data

- (void)saveData {
    
    if (aData == nil) {
        aData = [[MANSCodingData alloc] init];
    }
    
    aData.data = _textField.text;
    
    NSLog(@"save data...%@", aData.data);
    NSMutableData   * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:aData forKey:DATA_KEY];
    [archiver finishEncoding];
    [data writeToFile:_path atomically:YES];
    
    NSLog(@"save data: %@", aData.data);
}

- (void)loadData {
    NSLog(@"load file: %@", _path);
    NSData * codedData = [[NSData alloc] initWithContentsOfFile:_path];
    if (codedData == nil) return;
    
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    aData = [unarchiver decodeObjectForKey:DATA_KEY];
    [unarchiver finishDecoding];
    
    if (aData.data != nil) {
        _textField.text = aData.data;
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
