//
//  ViewController.m
//  MantleAndModelDemo
//
//  Created by APP on 2017/2/14.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
//#import "TestDataModel.h"
#import "GoodStuffDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //使用Mantle处理json和Model Object的基本要素:
    
    NSURL *url = [NSURL URLWithString:@"http://zhekou.repai.com/jkjby/view/rp_b2c_list_v5.php?limit=100&&access_token=&appkey=100071&app_oid=2ad000dbe962fff914983edbf273b427&app_id=594792631&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&pay=weixin&senddata=20150922"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               
                               if (!connectionError) {
                                   
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:nil];
                                   NSArray *array = [dict objectForKey:@"list"];
                                   NSDictionary *dictlist = array[0];
                                   //1 将JSON数据和Model的属性进行绑定
                                   GoodStuffDataModel *stuffmodel = [MTLJSONAdapter modelOfClass:[GoodStuffDataModel class] fromJSONDictionary:dictlist error:nil];
                                   NSLog(@"model = %@",stuffmodel);
                                   
                                   //2 Model对象的存储
                                   NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                                   NSString *filepath = [documentpath stringByAppendingPathComponent:@"NSKeyedArchiver.txt"];
                                   NSLog(@"filepath = %@",filepath);
                                   [NSKeyedArchiver archiveRootObject:stuffmodel toFile:filepath];
                                   GoodStuffDataModel *model2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
                                   NSLog(@"model2 = %@, stuff_titles = %@",model2, model2.stuff_titles);
                                   
                                   //3 Model Object转换为json格式，需要调用:
                                   NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:stuffmodel error:nil];
                                   NSLog(@"jsonDictionary = %@",jsonDictionary.description);
                                   
                                   
                               }
                               
                           }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
