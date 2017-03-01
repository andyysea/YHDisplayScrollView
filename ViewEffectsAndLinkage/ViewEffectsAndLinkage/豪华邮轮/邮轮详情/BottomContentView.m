//
//  BottomContentView.m
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "BottomContentView.h"
#import "BottomContentLayout.h"
#import "BottomContentCell.h"
#import "DownViewModel.h"

static NSString *cellId = @"cellId";

@interface BottomContentView ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 集合视图 */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 分页控件 */
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation BottomContentView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 模型属性setter方法
- (void)setBottomModelArray:(NSArray<DownViewModel *> *)bottomModelArray {
    _bottomModelArray = bottomModelArray;
    
    if (bottomModelArray.count) {
        
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = bottomModelArray.count;
        
        [self.collectionView reloadData];
    }
}



#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
 
    CGFloat offsetX = self.collectionView.contentOffset.x;
    
    // 设置分页控件当前页
    self.pageControl.currentPage = offsetX / self.bounds.size.width;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.bottomModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BottomContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (self.bottomModelArray.count) {
        
        DownViewModel *model = self.bottomModelArray[indexPath.item];
        cell.downModel = model;
    }
    
    return cell;
}

#pragma mark - 设置界面元素
- (void)setupUI {

    // 上面由collectionView做
    BottomContentLayout *layout = [[BottomContentLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 30) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    [self addSubview:collectionView];
    
    
    [collectionView registerClass:[BottomContentCell class] forCellWithReuseIdentifier:cellId];
    collectionView.dataSource = self;
    collectionView.delegate = self;

    
    
    // 下面添加 翻页控件
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];

    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self addSubview:pageControl];
    
    
    // 属性记录
    _collectionView = collectionView;
    _pageControl = pageControl;
}



@end
