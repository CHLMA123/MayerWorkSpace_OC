//
//  MAMainViewController.h
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAUserDefaultsViewController.h"
#import "MAPlistViewController.h"
#import "MARawFileAPIsViewController.h"
#import "MANSCodingViewController.h"
#import "MASQLiteViewController.h"

@interface MAMainViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataAry;
    UITableView * _tableView;
}

@end
