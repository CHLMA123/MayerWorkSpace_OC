//
//  ViewController.h
//  FMDBDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface ViewController : UIViewController{
    
    FMDatabase *db;
    NSString *database_path;
}
@end

