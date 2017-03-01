//
//  BottomContentLayout.m
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "BottomContentLayout.h"

@implementation BottomContentLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 获取 collectionView 的大小
    CGSize size = self.collectionView.bounds.size;

    // 设置 item 大小
    self.itemSize = CGSizeMake(size.width - 20, size.height);
    // 设置最小间距,和滚动方向垂直的方向的间距
    self.minimumLineSpacing = 20;
    // 设置组内间距
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置 collectionView 的分页
    self.collectionView.pagingEnabled = YES;
    // 隐藏指示器
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

}


@end
