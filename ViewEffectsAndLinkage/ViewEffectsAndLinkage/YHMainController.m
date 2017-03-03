//
//  YHMainController.m
//  ViewEffectsAndLinkage
//
//  Created by junde on 2017/3/3.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "YHMainController.h"
#import "CruiseListViewController.h"


@interface YHMainController ()

@end

@implementation YHMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - 设置界面元素
- (void)setupUI {
    
    CruiseListViewController *listVC = [CruiseListViewController new];
    UINavigationController *navListVC = [[UINavigationController alloc] initWithRootViewController:listVC];
    
    
    self.viewControllers = @[navListVC];
    
}




@end




