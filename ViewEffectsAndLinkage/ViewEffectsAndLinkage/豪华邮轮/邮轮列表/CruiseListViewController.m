//
//  CruiseListViewController.m
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import "CruiseListViewController.h"
#import "CruiseListViewCell.h"
#import "CruiseDetailViewController.h"
#import "CruiseListModel.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height





static NSString *cellId = @"cellId";

@interface CruiseListViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 表格视图
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelArray;

/**
 请求数据页数
 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation CruiseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    _modelArray = [NSMutableArray array];
    
    [self loadData];
    [self setupUI];
    
    
    
}

/**
 NSJSONReadingMutableContainers  解析器顶级节点可以是可变字典或者数组
 NSJSONReadingMutableLeaves      解析出来的是可变字符串
 NSJSONReadingAllowFragments     允许解析器顶级节点可以不是字典或者数组
 */

#pragma mark - 加载数据
- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"listJsonData.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *contentDict in dataArray) {
        
        CruiseListModel *model = [CruiseListModel cruiseViewModelWithDict:contentDict];
        
        [self.modelArray addObject:model];
    }
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转到详情
    CruiseDetailViewController *detailVC = [CruiseDetailViewController new];
    CruiseListModel *model = self.modelArray[indexPath.section];
    detailVC.shipId = model.id;
    detailVC.routeName = model.routeName;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CruiseListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.modelArray[indexPath.section];
    
    return cell;
}


#pragma mark - 设置界面元素
- (void)setupUI {
    self.title = @"豪华邮轮游";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width_Window, Height_Window - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[CruiseListViewCell class] forCellReuseIdentifier:cellId];
    
    // 属性记录
    _tableView = tableView;
}



@end
