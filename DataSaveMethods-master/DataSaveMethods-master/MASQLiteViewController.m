//
//  MASQLiteViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MASQLiteViewController.h"

@interface MASQLiteViewController ()

@end

@implementation MASQLiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"SQLite";
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
    if (_textField.text == nil || _textField.text.length == 0) {
        UIAlertView * aAlertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No Text!" delegate:nil cancelButtonTitle:@"I see" otherButtonTitles:nil, nil];
        [aAlertView show];
        return;
    }
    
    char * errorMsg;
    NSString * insertSQL = [NSString stringWithFormat:@"insert into datas (name) values('%@')", _textField.text];
    
    if (sqlite3_exec(_db, [insertSQL cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"insert ok.");
    }
}

- (void)loadData {
    [self openDB];
    
    const char * selectSql="select id,name from datas";
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(_db, selectSql, -1, &statement, nil)==SQLITE_OK) {
        NSLog(@"select ok.");
    }
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        int _id = sqlite3_column_int(statement, 0);
        NSString * name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
        NSLog(@"row>>id %i, name %@",_id,name);
        
        _textField.text = name;
    }
    
    sqlite3_finalize(statement);
}

#pragma mark - SQLite

- (void)openDB {
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                , NSUserDomainMask
                                                                , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"mydb"];
    
    if (sqlite3_open([databaseFilePath UTF8String], &_db) == SQLITE_OK) {
        NSLog(@"Successfully open database.");
        [self creatTable];
    }
}

- (void)closeDB {
    sqlite3_close(_db);
}

- (void)creatTable {
    char * errorMsg;
    const char * createSql="create table if not exists datas (id integer primary key autoincrement,name text)";
    
    if (sqlite3_exec(_db, createSql, NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"Successfully create data table.");
    }
    else {
        NSLog(@"Error: %s",errorMsg);
        sqlite3_free(errorMsg);
    }
}

- (void)dealloc {
    [self closeDB];
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
