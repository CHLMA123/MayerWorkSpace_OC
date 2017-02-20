//
//  ViewController.m
//  EmptyDataSetUIScrollview
//
//  Created by APP on 2017/2/20.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIColor+Hexadecimal.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *objDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"EmptyDataSet";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configurNavgationItem];
    
    NSArray *dataArr = [NSArray arrayWithObjects:@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1, nil];
    _objDataArray = [dataArr mutableCopy];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)configurNavgationItem{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setTitle:@"setupData" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(setupData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupData:(UIButton *)sender{

    sender.selected = !sender.selected;
    if (sender.selected) {
        [_objDataArray removeAllObjects];
    }else{
    
        NSArray *dataArr = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,nil];
        _objDataArray = [dataArr mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Photos";
    UIFont *font = [UIFont boldSystemFontOfSize:17.0];
    UIColor *textColor = [UIColor colorWithHex:@"545454"];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (!text) {
        return nil;
    }
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Get started by uploading a photo.";
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];
    UIColor *textColor = [UIColor colorWithHex:@"545454"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imageName = @"placeholder_remote";
    return [UIImage imageNamed:imageName];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.01;
}

#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{

    return YES;
}

- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView{

    return NO;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"app_cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"stringWithFormat %d", indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:0.35];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"用户点击了第 %ld cell", (long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        
    }
    return _tableView;
}

@end
