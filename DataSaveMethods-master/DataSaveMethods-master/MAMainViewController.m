//
//  MAMainViewController.m
//  DataSaveMethods-master
//
//  Created by MACHUNLEI on 16/1/22.
//  Copyright © 2016年 MACHUNLEI. All rights reserved.
//

#import "MAMainViewController.h"

@interface MAMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation MAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = @"数据存储的几种方式";
    [self initData];
}

- (void)initData {
    
    _dataAry = [[NSMutableArray alloc] initWithObjects:@"NSUserDefault", @"Plist File", @"Raw File APIs", @"NSCoding", @"SQLite", @"CoreData", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataAry != nil && _dataAry.count > 0) {
        NSLog(@"_dataAry.count: %lu", (unsigned long)_dataAry.count);
        return _dataAry.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    cell.textLabel.text = [_dataAry objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            // NSUserDefaults
        {
            MAUserDefaultsViewController * aUDController = [[MAUserDefaultsViewController alloc] init];
            [self.navigationController pushViewController:aUDController animated:YES];
        }
            break;
            
        case 1:
            // Plist File
        {
            MAPlistViewController * aPlistViewController = [[MAPlistViewController alloc] init];
            [self.navigationController pushViewController:aPlistViewController animated:YES];
        }
            break;
            
        case 2:
            // Raw File APIs
        {
            MARawFileAPIsViewController * aRawViewController = [[MARawFileAPIsViewController alloc] init];
            [self.navigationController pushViewController:aRawViewController animated:YES];
        }
            break;
            
        case 3:
            // NSCoding
        {
            MANSCodingViewController * aNSCodingViewController = [[MANSCodingViewController alloc] init];
            [self.navigationController pushViewController:aNSCodingViewController animated:YES];
        }
            break;
            
        case 4:
            // SQLite
        {
            MASQLiteViewController * aSQLiteViewController = [[MASQLiteViewController alloc] init];
            [self.navigationController pushViewController:aSQLiteViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
