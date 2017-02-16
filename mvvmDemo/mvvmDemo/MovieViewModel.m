//
//  MovieViewModel.m
//  mvvmDemo
//
//  Created by 张家欢 on 16/7/18.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "MovieViewModel.h"
#import "NetworkService.h"
#import "MovieModel.h"
#import "MovieViewController.h"

@implementation MovieViewModel

- (void)getMovieData{
    [NetworkService requestWithURL:@"/v2/movie/coming_soon" params:nil success:^(id result) {
        NSLog(@"%@",result);
        
        NSArray *subjects = result[@"subjects"];
        NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:subjects.count];
        for (NSDictionary *subject in subjects) {
            MovieModel *model = [[MovieModel alloc] init];
            model.movieName = subject[@"title"];
            model.year = subject[@"year"];
            NSString *urlStr = subject[@"images"][@"medium"];
            model.imageUrl = [NSURL URLWithString:urlStr];
            model.detailUrl = subject[@"alt"];
            [modelArr addObject:model];
        }
        _returnBlock(modelArr);
        
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
        _errorBlock(error);
    }];
    
}

- (void)movieDetailWithPublicModel: (MovieModel *)movieModel WithViewController: (UIViewController *)superController{
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    movieVC.url = movieModel.detailUrl;
    [superController.navigationController pushViewController:movieVC animated:YES];
}
@end
