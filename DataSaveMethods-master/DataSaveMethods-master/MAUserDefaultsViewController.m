//
//  MAUserDefaultsViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MAUserDefaultsViewController.h"

@interface MAUserDefaultsViewController ()

@end

@implementation MAUserDefaultsViewController

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
    
    if (_textField.text == nil || _textField.text.length == 0) {
        UIAlertView * aAlertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No Text!" delegate:nil cancelButtonTitle:@"I see" otherButtonTitles:nil, nil];
        [aAlertView show];
        return;
    }
    NSUserDefaults * aUserDefaults = [NSUserDefaults standardUserDefaults];
    [aUserDefaults setObject:_textField.text forKey:@"Text"];
    
    // 这里是为了把设置及时写入文件，防止由于崩溃等情况App内存信息丢失
    [aUserDefaults synchronize];
}

- (void)loadData {

    NSUserDefaults *aUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *aStr = [aUserDefaults objectForKey:@"Text"];
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
