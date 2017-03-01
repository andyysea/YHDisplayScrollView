//
//  HorizontalScrollerView.m
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HorizontalScrollerView.h"
#import "HorizontalContentView.h"
#import "DownViewModel.h"

/** 用于记录当前是哪个视图字体是黑色,这样就不用每次循环设置了 */
static HorizontalContentView *currentCenterView = nil;


@interface HorizontalScrollerView ()<UIScrollViewDelegate>

/**
 初始化传递进来的数组数据
 */
@property (nonatomic, strong) NSArray *dataArray;

/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 添加子视图的数组 */
@property (nonatomic, strong) NSMutableArray *subViewsArray;

@end

@implementation HorizontalScrollerView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        [self setupUIWithData:dataArray];
    }
    return self;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self centerCurrentView];
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerCurrentView];
}


/**
    滚动的时候,计算滚动的位子以及滚动的子视图是哪个,让其滚动到中心
 */
- (void)centerCurrentView
{
    // 子视图的间距和宽度
    CGFloat margin = 5;
    CGFloat subViewW = (self.bounds.size.width - margin * 4) / 3;
    
    NSInteger xFinal = self.scrollView.contentOffset.x + (subViewW/2) + margin;
    NSInteger Index = xFinal / (subViewW + margin);
    xFinal = Index * (subViewW + margin);
    
    NSLog(@"--> %f, xf -> %zd -> %zd ", self.scrollView.contentOffset.x,xFinal,Index);
    [self.scrollView setContentOffset:CGPointMake(xFinal,0) animated:YES];
    
    // 调用代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(horizontalScrollerViewDelegate:indexOfCenterView:)]) {
        [self.delegate horizontalScrollerViewDelegate:self indexOfCenterView:Index];
        
        // 1> 将之前的视图颜色设置灰色
        currentCenterView.isBlackColor = NO;
        // 2> 取出当前居中的视图 设置成黑色
        HorizontalContentView *contentView = self.subViewsArray[Index];
        contentView.isBlackColor = YES;
        // 3> 记录当前黑色的视图
        currentCenterView = contentView;
    }
}



#pragma mark - 点击手势方法
- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    // 获取点击的位置
    CGPoint location = [gesture locationInView:gesture.view];
    // 遍历子视图
    for (NSInteger index = 0; index < self.subViewsArray.count; index++) {
        
        UIView *view = self.subViewsArray[index];

        if (CGRectContainsPoint(view.frame, location)) {
            // 能进来说明点击的是这个视图
            [self.scrollView setContentOffset:CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0) animated:YES];
            // 调用代理方法
            if (self.delegate && [self.delegate respondsToSelector:@selector(horizontalScrollerViewDelegate:indexOfCenterView:)]) {
                [self.delegate horizontalScrollerViewDelegate:self indexOfCenterView:index];
                
                // 1> 将之前的视图颜色设置灰色
                currentCenterView.isBlackColor = NO;
                // 2> 取出当前居中的视图 设置成黑色
                HorizontalContentView *contentView = self.subViewsArray[index];
                contentView.isBlackColor = YES;
                // 3> 记录当前黑色的视图
                currentCenterView = contentView;
            }
            break;
        }
    }
}



#pragma mark - 设置界面元素
- (void)setupUIWithData:(NSArray *)dataArray {
    self.backgroundColor = [UIColor whiteColor];

    //添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
    // 添加一个自定义的视图,讲数据传递进去
    CGFloat margin = 5;
    CGFloat width = (scrollView.bounds.size.width - margin * 4) / 3;
    CGFloat height = scrollView.bounds.size.height;
    
    self.subViewsArray = [NSMutableArray array]; // 实例化一下
    for (NSInteger i = 0; i < dataArray.count; i++) {
        
        HorizontalContentView *contentView = [[HorizontalContentView alloc] initWithFrame:CGRectMake(margin * 2 + width + (margin + width)* i, 0, width, height)];
        contentView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:contentView];
    
        // 传递模型数据
        NSArray *subArray = dataArray[i];
        DownViewModel *model = subArray.firstObject; // 任意去一个模型
        contentView.model = model;
        
        if (i == 0) {
            contentView.isBlackColor = YES;
            
            currentCenterView = contentView; // 记录当前的居中视图
        } else {
            contentView.isBlackColor = NO;
        }
        
        // 创建的时候要保存起来便于后面取出来用
        [self.subViewsArray addObject:contentView];
    }
    
    scrollView.contentSize = CGSizeMake((margin + width) * (dataArray.count + 2) + margin , 0);
    
    //添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [scrollView addGestureRecognizer:tapGesture];
    
    // 属性记录
    _scrollView = scrollView;
}



@end
