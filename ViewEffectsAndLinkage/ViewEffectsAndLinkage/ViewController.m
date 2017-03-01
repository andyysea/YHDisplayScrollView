//
//  ViewController.m
//  ViewEffectsAndLinkage
//
//  Created by junde on 2017/3/1.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "ViewController.h"
#import "CruiseListViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 点击跳转
- (void)buttonClick {
    CruiseListViewController *listVC = [CruiseListViewController new];
    
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
