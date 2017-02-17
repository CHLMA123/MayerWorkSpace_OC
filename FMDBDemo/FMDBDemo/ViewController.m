//
//  ViewController.m
//  FMDBDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+MA.h"
#import "MACommon.h"

#define DBNAME  @"chlam123.sqlite"
#define ID        @"id"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    [self createNewFMDB];
    [self setupView];
}

- (void)createNewFMDB{
    
    NSString *documentory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    database_path = [documentory stringByAppendingPathComponent:DBNAME];
    NSLog(@"%@,/n%@",documentory,database_path);
    db = [FMDatabase databaseWithPath:database_path];
    [self createAndCheckDatabase];
    
}

- (void)createAndCheckDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:database_path];
    if(success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DBNAME];
    [fileManager copyItemAtPath:databasePathFromApp toPath:database_path error:nil];
}

- (void)setupView{
    
    CGFloat inity = 60;
    UIButton *openDBBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    openDBBtn.frame=CGRectMake(60, inity*1, 200, 50);
    [openDBBtn addTarget:self action:@selector(createTableAction) forControlEvents:UIControlEventTouchUpInside];
    [openDBBtn setTitle:@"createTable" forState:UIControlStateNormal];
    [self.view addSubview:openDBBtn];

    UIButton *insterBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    insterBtn.frame=CGRectMake(60, inity*2, 200, 50);
    [insterBtn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    [insterBtn setTitle:@"insertData" forState:UIControlStateNormal];
    [self.view addSubview:insterBtn];
    
    UIButton *updateBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    updateBtn.frame=CGRectMake(60, inity*3, 200, 50);
    [updateBtn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn setTitle:@"updateData" forState:UIControlStateNormal];
    [self.view addSubview:updateBtn];

    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteBtn.frame=CGRectMake(60, inity*4, 200, 50);
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"deleteData" forState:UIControlStateNormal];
    [self.view addSubview:deleteBtn];
    
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectBtn.frame=CGRectMake(60, inity*5, 200, 50);
    [selectBtn addTarget:self action:@selector(selectData) forControlEvents:UIControlEventTouchDown];
    [selectBtn setTitle:@"selectData" forState:UIControlStateNormal];
    [self.view addSubview:selectBtn];

    UIButton *multithreadBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    multithreadBtn.frame=CGRectMake(60, inity*6, 200, 50);
    [multithreadBtn addTarget:self action:@selector(multithread) forControlEvents:UIControlEventTouchDown];
    [multithreadBtn setTitle:@"multithread" forState:UIControlStateNormal];
    [self.view addSubview:multithreadBtn];
}

- (void)createTableAction{
    if ([db open]) {
        //sql 语句
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [db close];
    }else{
        NSLog(@"Could not open db.");
        return ;
    }
}

- (void)insertAction{
    NSLog(@"%s,  %d",__FUNCTION__,__LINE__);
    if ([db open]) {
        //SQLite中的text对应到的是NSString，integer对应NSNumber，blob则是NSData。
        //插入的资料会跟Objective-C的变数有关，所以在string里使用?号来代表这些变数。
        //NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Button_Large" ofType:@".png"];
        //BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (?,?,?,?,?,?)", @"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"1591990", @"Taiwan", [NSData dataWithContentsOfFile:filepath]];
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                               TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
        BOOL res = [db executeUpdate:insertSql1];
        NSString *insertSql2 = [NSString stringWithFormat:
                                @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                                TABLENAME, NAME, AGE, ADDRESS, @"李四", @"12", @"济南"];
        BOOL res2 = [db executeUpdate:insertSql2];
        if (!res && !res2) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        
    }
    [db close];
}

- (void)updateAction{
    NSLog(@"%s,  %d",__FUNCTION__,__LINE__);
    if ([db open]) {
        //BOOL res =[db executeUpdate:@"UPDATE PersonList SET Age = ? WHERE Name = ?",[NSNumber numberWithInt:30],@"John"];
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
                               TABLENAME,   AGE,  @"15" ,AGE,  @"13"];
        BOOL res = [db executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
    }
    [db close];
}

- (void)deleteAction{
    NSLog(@"%s,  %d",__FUNCTION__,__LINE__);
    if ([db open]) {
        //找地址
        //FMResultSet *res = [db executeQuery:@"SELECT * FROM PersonList WHERE Name = ?",@"John"];
        //while ([res next]){
            //NSLog(@"%@ %@",[res stringForColumn:@"Name"],[res stringForColumn:@"Age"]);
        //}
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'",
                               TABLENAME, NAME, @"张三"];
        BOOL res = [db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
    }
    [db close];
}

- (void)selectData{

    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",TABLENAME];
        FMResultSet * res = [db executeQuery:sql];
        while ([res next]) {
            int Id = [res intForColumn:ID];
            NSString * name = [res stringForColumn:NAME];
            NSString * age = [res stringForColumn:AGE];
            NSString * address = [res stringForColumn:ADDRESS];
            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
        [db close];
    }

}

- (void)multithread{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:database_path];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);

    dispatch_async(q1, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {

                NSString *insertSql1= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];

                NSString * name = [NSString stringWithFormat:@"jack %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];


                BOOL res = [db2 executeUpdate:insertSql1, name, age,@"济南"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });

    dispatch_async(q2, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                NSString *insertSql2= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];

                NSString * name = [NSString stringWithFormat:@"lilei %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];

                BOOL res = [db2 executeUpdate:insertSql2, name, age,@"北京"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
