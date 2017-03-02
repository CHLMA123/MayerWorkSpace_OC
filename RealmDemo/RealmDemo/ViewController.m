//
//  ViewController.m
//  RealmDemo
//
//  Created by APP on 2017/2/21.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

/*
 Realm 通过确保每个线程始终拥有 Realm 的一个快照，以便让并发运行变得十分轻松。你可以同时有任意数目的线程访问同一个 Realm 文件，并且由于每个线程都有对应的快照，因此线程之间绝不会产生影响。需要注意的一件事情就是不能让多个线程都持有同一个 Realm 对象的 实例 。如果多个线程需要访问同一个对象，那么它们分别会获取自己所需要的实例（否则在一个线程上发生的更改就会造成其他线程得到不完整或者不一致的数据）。
 
 其实RLMRealm *realm = [RLMRealm defaultRealm]; 这句话就是获取了当前realm对象的一个实例，其实实现就是拿到单例。所以我们每次在子线程里面不要再去读取我们自己封装持有的realm实例了，直接调用系统的这个方法即可，能保证访问不出错。
 */

#import "ViewController.h"
#import "RLMUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatDataBaseWithName:@"CHLMA123.realm"];
    
//    [self insertData];
//    [self deleteData];
//    [self fetchData];
//    [self changeData];
//    [self fecthWhere];
//    [self cleanRealm];
    
    // 数据加解密
    [self encryption];
//    [self deEncryption];
}

// 加密
- (void)encryption
{
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.encryptionKey = [self getKey];
    RLMRealm *realm = [RLMRealm realmWithConfiguration:configuration
                                                 error:nil];
    // Add an object
    [realm beginWriteTransaction];
    
    RLMUser *temp = [[RLMUser alloc] init];
    temp.usrId = [NSString stringWithFormat:@"0002"];
    temp.usrName = @"测试2";
    temp.usrAge = 12;
    // 添加到数据库
    [realm addObject:temp];
    
    [realm commitWriteTransaction];
}

// 解密
- (void)deEncryption
{
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.encryptionKey = [self getKey];
    
    RLMRealm *realm = [RLMRealm realmWithConfiguration:configuration
                                                 error:nil];
    [self log:@"Saved object: %@", [[RLMUser allObjectsInRealm:realm] firstObject]];
}

- (NSData *)getKey {
    
    // Identifier for our keychain entry - should be unique for your application
    static const uint8_t kKeychainIdentifier[] = "io.Realm.EncryptionExampleKey";
    NSData *tag = [[NSData alloc] initWithBytesNoCopy:(void *)kKeychainIdentifier
                                               length:sizeof(kKeychainIdentifier)
                                         freeWhenDone:NO];
    
    // First check in the keychain for an existing key
    NSDictionary *query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
                            (__bridge id)kSecAttrApplicationTag: tag,
                            (__bridge id)kSecAttrKeySizeInBits: @512,
                            (__bridge id)kSecReturnData: @YES};
    
    CFTypeRef dataRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataRef);
    if (status == errSecSuccess) {
        return (__bridge NSData *)dataRef;
    }
    
    // No pre-existing key from this application, so generate a new one
    uint8_t buffer[64];
    status = SecRandomCopyBytes(kSecRandomDefault, 64, buffer);
    NSAssert(status == 0, @"Failed to generate random bytes for key");
    NSData *keyData = [[NSData alloc] initWithBytes:buffer length:sizeof(buffer)];
    
    // Store the key in the keychain
    query = @{(__bridge id)kSecClass: (__bridge id)kSecClassKey,
              (__bridge id)kSecAttrApplicationTag: tag,
              (__bridge id)kSecAttrKeySizeInBits: @512,
              (__bridge id)kSecValueData: keyData};
    
    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    NSAssert(status == errSecSuccess, @"Failed to insert new key in the keychain");
    
    return keyData;
}

- (void)log:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSString *strr = [[@"" stringByAppendingString:str]
                      stringByAppendingString:@"\n\n"];
    NSLog(@"str = %@",strr);
    
    
}

/**
 清理数据库文件，为测试环境做准备。
 */

- (void)cleanRealm {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    NSArray<NSURL *> *realmFileURLs = @[
                                        config.fileURL,
                                        [config.fileURL URLByAppendingPathExtension:@"lock"],
                                        [config.fileURL URLByAppendingPathExtension:@"management"],
                                        [config.fileURL URLByAppendingPathExtension:@"note"]];
    for (NSURL *URL in realmFileURLs) {
        NSError *error = nil;
        [manager removeItemAtURL:URL error:&error];
        if (error) {
            NSLog(@"clean realm error:%@", error);
        }
    }
}

// 新增字段操作
- (void)addNewProperty
{
    
}

// 按指定条件查询 断言查询 谓词查询 排序
- (void)fecthWhere
{
    RLMResults *results0 = [RLMUser objectsWhere:@"usrAge>18"];
    
    for (RLMUser *obj in results0) {

        NSLog(@"results0 = %@", obj);
    }
    
    RLMResults *results1 = [results0 sortedResultsUsingKeyPath:@"usrAge" ascending:NO];
    
    for (RLMUser *obj in results1) {
        
        NSLog(@"results1 = %@", obj);
    }
    
    // 使用断言字符串查询
    RLMResults *results2 = [results0 objectsWhere:@"usrAge = 1000 AND usrId BEGINSWITH '000'"];
    
    for (RLMUser *obj in results2) {
        
        NSLog(@"results2 = %@", obj);
    }
    
    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"usrAge = 19"];
    
    RLMResults * results3 = [results0 objectsWithPredicate:pred];
    for (RLMUser *obj in results3) {
        
        NSLog(@"results3 = %@", obj);
    }
    
}

- (void)changeData{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        
        RLMResults *results = [RLMUser allObjects];
        
        RLMUser *temp = results[0];
        temp.usrAge = 1000;
    }];
    
    //当有主键的情况下，有以下几个非常好用的API:
    /*
     [realm addOrUpdateObject:RLMUser];
     addOrUpdateObject会去先查找有没有传入的RLMUser相同的主键，如果有，就更新该条数据。
     这里需要注意，addOrUpdateObject这个方法不是增量更新，所有的值都必须有，如果有哪几个值是null，那么就会覆盖原来已经有的值，这样就会出现数据丢失的问题。
     
     [RLMUser createOrUpdateInRealm:realm withValue:@{@"id": @1, @"price": @9000.0f}];
     createOrUpdateInRealm：withValue：这个方法是增量更新的，后面传一个字典，使用这个方法的前提是有主键。方法会先去主键里面找有没有字典里面传入的主键的记录，如果有，就只更新字典里面的子集。如果没有，就新建一条记录。
     */
    
    //演示使用主键更新
     RLMUser *temp2 = [[RLMUser alloc] init];
     temp2.usrId = @"0005";
     temp2.usrName = @"busvarasdasdas";
    
     [realm beginWriteTransaction];
    
     [RLMUser createOrUpdateInRealm:realm withValue:temp2];
    
     [realm commitWriteTransaction];
}

- (void)fetchData{
    
    //当没有主键的情况下，需要先查询，再修改数据。
    RLMResults *results = [RLMUser allObjects];
    
    for (RLMUser *model in results) {
        NSLog(@"model = %@",model);
    }
//    RLMUser *model = results[0];
//    NSLog(@"model = %@",model);
}

- (void)deleteData{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        
        RLMResults *results = [RLMUser allObjects];
        [realm deleteObject:results.firstObject];
        
    }];
}

/*
 请注意，如果在进程中存在多个写入操作的话，那么单个写入操作将会阻塞其余的写入操作，并且还会锁定该操作所在的当前线程。
 Realm这个特性与其他持久化解决方案类似，我们建议您使用该方案常规的最佳做法：将写入操作转移到一个独立的线程中执行。
 */
- (void)insertData{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            
            for (int i = 2; i<5; i++) {
                
                RLMUser *temp = [[RLMUser alloc] init];
                temp.usrId = [NSString stringWithFormat:@"000%d", i];
                temp.usrName = @"小明";
                temp.usrAge = 10 + i;
                // 添加到数据库
                [realm addObject:temp];
                
            }
        }];
    });
    
    /* 第二种方式
     
     [realm beginWriteTransaction];
     for (int i = 5; i<10; i++) {
     
         RLMUser *temp = [[RLMUser alloc] init];
         temp.usrId = [NSString stringWithFormat:@"000%d", i];
         temp.usrName = @"小明";
         temp.usrAge = 10 + i;
         // 添加到数据库
         [realm addObject:temp];
     
     }
     [realm commitWriteTransaction];
     
     */
}

/**
 1. 创建数据库

 @param databaseName 数据库名称
 通常情况下，Realm 数据库是存储在硬盘中的，但是您能够通过设置inMemoryIdentifier而不是设置RLMRealmConfiguration中的 fileURL属性，以创建一个完全在内存中运行的数据库。
 RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
 config.inMemoryIdentifier = @"MyInMemoryRealm";
 RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
 */
- (void)creatDataBaseWithName:(NSString *)databaseName{

    // RLMRealmConfiguration:设置数据库名称和存储地址
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
    // 1.新增删除表，Realm不需要做迁移
    // 2.新增删除字段，Realm不需要做迁移。Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构。
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        
        // 这里是设置数据迁移的block
        NSLog(@"oldSchemaVersion = %llu",oldSchemaVersion);
        if (oldSchemaVersion < currentVersion) {
        }
        /*
         //在block里面分别有3种迁移方式，第一种是合并字段的例子，第二种是增加新字段的例子，第三种是原字段重命名的例子。
         // enumerateObjects:block: 遍历了存储在 Realm 文件中的每一个“Person”对象
         
         [migration enumerateObjects:Person.className block:^(RLMObject *oldObject, RLMObject *newObject) {        
         // 只有当 Realm 数据库的架构版本为 0 的时候，才添加 “fullName” 属性
         if (oldSchemaVersion < 1) {
         
            newObject[@"fullName"] = [NSString stringWithFormat:@"%@ %@", oldObject[@"firstName"], oldObject[@"lastName"]];
         }   
         // 只有当 Realm 数据库的架构版本为 0 或者 1 的时候，才添加“email”属性
         if (oldSchemaVersion < 2) {
         
            newObject[@"email"] = @"";
         }       
         // 替换属性名
         if (oldSchemaVersion < 3) { 
         // 重命名操作应该在调用 `enumerateObjects:` 之外完成
            [migration renamePropertyForClass:Person.className oldName:@"yearsSinceBirth" newName:@"age"]; }
         }];
         */
        
    };
    // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
