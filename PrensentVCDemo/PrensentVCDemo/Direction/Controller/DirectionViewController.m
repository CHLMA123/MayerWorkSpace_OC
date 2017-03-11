//
//  PresentViewController.m
//  PrensentVCDemo
//
//  Created by APP210 on 2017/3/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "DirectionViewController.h"
#import "Masonry.h"

@interface DirectionViewController ()

@property (nonatomic, strong) NSMutableArray *directionViews;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation DirectionViewController

#pragma mark - Life Cycle
- (instancetype)initWithDirectionViews:(NSArray *)directionViews{

    if (self = [super init]) {
        _directionViews = [[directionViews.reverseObjectEnumerator allObjects] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showDirectionView];
}

#pragma mark - Private Methods
- (void)showDirectionView {
    
    UIView *lastView = [self.view viewWithTag:1000];
    if (lastView) {
        [UIView animateWithDuration:0.25 animations:^{
            lastView.alpha = 0;
            [lastView removeFromSuperview];
        }];
    }
    
    lastView = _directionViews.lastObject;
    if (lastView) {
        [self.directionViews removeLastObject];
        
        lastView.tag = 1000;
        [self.view addSubview:lastView];
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        lastView.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            lastView.alpha = 1;
        }];
    } else {
        NSLog(@"... 当前视图展示完毕");
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - Event Response
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self showDirectionView];
}

#pragma mark - Getter && Setter
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
