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

/** 初始化底部控制器的时候,当船舱类型太多超出屏幕的通知名 */
NSString *const CabinTypeExceedScreenHeightByInitializeNotification = @"CabinTypeExceedScreenHeightByInitializeNotification";
/** 当点击不同月份对应的航期,当船舱类型不同时来修改底部控制器的滚动范围的通知名 */
NSString *const CabinTypeExceedScreenHeightByClickNotification = @"CabinTypeExceedScreenHeightByClickNotification";
/** 需要设置的滚动高度对应的key */
NSString *const DownVCScrollHeightKey = @"DownVCScrollHeightKey";

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

/** 之前选中的月份下标 */
@property (nonatomic, assign) NSInteger preIndex;

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
    if (index == self.preIndex) {
        return;
    }
    self.preIndex = index;
    
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
            
            // 上面循环遍历的是每个月份不同期中最大的房间类型数量
        }
        // 如果先前的最大数量与现在的不一样,就发送通知, 一样就不发送通知
        if (self.preMaxCount != self.currentMaxCount) {
            self.preMaxCount = self.currentMaxCount;
            
                NSInteger scrollHeight = 373 + self.preMaxCount * 25 + 30;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:CabinTypeExceedScreenHeightByClickNotification object:nil userInfo:@{DownVCScrollHeightKey: @(scrollHeight)}];
        }
        
        [self.bottomView removeFromSuperview];
        
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
    
    /** 当房间类型在下面不同手机型号上超过屏幕的时候,发送通知, 修改滚动范围 */
    // 如果是 5s 超过 7 个 -> 滚动范围 373 + self.preMaxCount * 25
    // 如果是 6  超过 11 个 -> 滚动范围 373 + self.preMaxCount * 25
    // 如果是 6p 超过 14 个 -> 滚动范围 373 + self.preMaxCount * 25
    if ((Width_Window == 320 && self.preMaxCount > 7) || (Width_Window == 375 && self.preMaxCount > 11) || (Width_Window == 414 && self.preMaxCount > 14) ) {
        NSInteger scrollHeight = 373 + self.preMaxCount * 25 + 30;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CabinTypeExceedScreenHeightByInitializeNotification object:nil userInfo:@{DownVCScrollHeightKey: @(scrollHeight)}];
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
