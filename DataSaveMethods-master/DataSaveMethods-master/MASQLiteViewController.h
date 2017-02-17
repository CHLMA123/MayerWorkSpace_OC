//
//  MASQLiteViewController.h
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <sqlite3.h>

@interface MASQLiteViewController : UIViewController
{
    UITextField * _textField;
    sqlite3 * _db;
}
@end
