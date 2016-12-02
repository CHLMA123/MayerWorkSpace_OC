//
//  ViewController.m
//  WidgetManagerDemo
//
//  Created by MCL on 2016/12/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "FSUIKit.h"
#import "LayoutButton.h"

#import "UIView+Layout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *title = [FSUIKit lableText:@"123" fontSize:14 textColor:[UIColor redColor] numberOfLines:1 textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor blackColor]];
    

    //左右结构，图片在左边，文字在右边。
    {
        LayoutButton * searchBtn = [LayoutButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn setTitle:@"搜索按钮图片在左边" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [searchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        searchBtn.imageRect = CGRectMake(10, 10, 20, 20);
        searchBtn.titleRect = CGRectMake(35, 10, 120, 20);
        [self.view addSubview:searchBtn];
        searchBtn.frame = CGRectMake(self.view.frame.size.width * 0.5 - 80, 250, 160, 40);
        searchBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
    }
    
    //左右结构，图片在右边，文字在左边。
    {
        LayoutButton * cancelBtn = [LayoutButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消按钮图片在右边" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        cancelBtn.titleRect = CGRectMake(10, 10, 120, 20);
        cancelBtn.imageRect = CGRectMake(135, 10, 20, 20);
        [self.view addSubview:cancelBtn];
        cancelBtn.frame = CGRectMake(self.view.frame.size.width * 0.5 - 80, 350, 160, 40);
        cancelBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:210/255.0 alpha:1];
    }

    
    
    UILabel *lable = [[UILabel alloc] init];
    lable.mcl_Frame(CGRectMake(50, 70, 200, 50)).mcl_BackgroundColor([UIColor redColor]).mcl_Text(@"xiaoming");
    
    self.view.add(lable);
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
