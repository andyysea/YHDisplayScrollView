//
//  DownViewController.m
//  添加上下控制器
//
//  Created by junde on 2017/2/21.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "DownViewController.h"
#import "HorizontalScrollerView.h"
#import "BottomContentView.h"
#import "DownViewModel.h"
#import "UIView+Common.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height


@interface DownViewController ()<HorizontalScrollerViewDelegate>


/**
 模型数据数组 (内部元素是数组,内部元素的元素才是模型)
 */
@property (nonatomic, strong) NSArray *modelArray;

/**
 底部添加的封装视图
 */
@property (nonatomic, weak) BottomContentView *bottomView;

/** 刚进入的时候 默认的首月,一个月的几个航期中房型最多的那一期数量 */
@property (nonatomic, assign) NSInteger preMaxCount;

/** 点击视图上方不同月,该月对应的不同航期中房型数量最多的那一期的数量 */
@property (nonatomic, assign) NSInteger currentMaxCount;

@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDownVCData];
}


#pragma mark - 加载底部控制器的数据,也是本控制器的数据
- (void)loadDownVCData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"downVCJsonData.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    
    if (dataArray.count) {
        
        NSMutableArray *outArrayM = [NSMutableArray array];
        for (NSArray *outArray in dataArray) {
            if (outArray.count) {
                NSMutableArray *arrayM = [NSMutableArray array];
                for (NSDictionary *dict in outArray) {
                    DownViewModel *model = [DownViewModel downViewModelWithDict:dict];
                    [arrayM addObject:model];
                }
                [outArrayM addObject:arrayM];
            }
        }
        self.modelArray = outArrayM.copy;
    }
    
    // 拿到数据之后再创建界面元素
    [self setupUI];
}


#pragma mark - HorizontalScrollerViewDelegate
// 顶部滚动视图代理方法,回调哪个滚到中间了
- (void)horizontalScrollerViewDelegate:(HorizontalScrollerView *)scrollerView indexOfCenterView:(NSInteger)index {
    NSLog(@"index --> %zd", index);

    if (index < self.modelArray.count) {
        
        NSArray *array = self.modelArray[index];
        if (array.count) {
            BOOL IsFist = YES;
            for (DownViewModel *model in array) {
                if (IsFist) {
                    IsFist = NO;
                    self.currentMaxCount = model.cabinTypePrice.count;
                }
                if (self.currentMaxCount < model.cabinTypePrice.count) {
                    self.currentMaxCount = model.cabinTypePrice.count;
                }
            }
        }
        
        [self.bottomView removeFromSuperview];
        self.preMaxCount = self.currentMaxCount;
        
        BottomContentView *bottomView = [[BottomContentView alloc] initWithFrame:CGRectMake(0, 209, Width_Window, 90 + 20 + 25 * self.preMaxCount  + 30)];
        bottomView.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
        [self.view addSubview:bottomView];
        
        self.bottomView = bottomView;
        
        self.bottomView.bottomModelArray = self.modelArray[index];
    }
}



#pragma mark - 设置界面元素
- (void)setupUI {
    self.view.backgroundColor =  [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat bgHeight = 120;
    
    // 1> 添加顶部滚动视图
//**** 这里的初始化方法,要同时把数据传递进去,所以创建要在请求数据之后再创建,同时初始化方法要改进
    HorizontalScrollerView *horView = [[HorizontalScrollerView alloc] initWithFrame:CGRectMake(0, 64, Width_Window, bgHeight) withData:self.modelArray];
    horView.backgroundColor = [UIColor whiteColor];
    horView.delegate = self;
    
    [self.view addSubview:horView];
    
    // 2> 添加一个固定的定不是图的中心线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(Width_Window / 2 - (Width_Window - 30) / 3 / 2, horView.bottom - 2, (Width_Window - 30) / 3, 2)];
    lineView.backgroundColor =  [UIColor redColor];
    [self.view addSubview:lineView];
    
    // 自定义底部视图
    // 根据底部房型数量 确定底部视图到底有多高
//    NSInteger count = 0;
//    NSArray *cabinTypeArray = nil;
    if (self.modelArray.count) {
        NSArray *array = self.modelArray.firstObject;
        if (array.count) {
            for (DownViewModel *model in array) {
                if (model.cabinTypePrice.count > self.preMaxCount) {
                    self.preMaxCount = model.cabinTypePrice.count;
                }
            }
        }
    }
    
    BottomContentView *bottomView = [[BottomContentView alloc] initWithFrame:CGRectMake(0, horView.bottom + 25, Width_Window, 90 + 20 + 25 * self.preMaxCount  + 30)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    [self.view addSubview:bottomView];

    // 传递初始数据
    if (self.modelArray.count) {
        bottomView.bottomModelArray = self.modelArray.firstObject;
    }
    
    // 属性记录
    _bottomView = bottomView;
}



@end
