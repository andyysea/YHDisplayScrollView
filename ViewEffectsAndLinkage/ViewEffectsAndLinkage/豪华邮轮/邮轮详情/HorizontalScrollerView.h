//
//  HorizontalScrollerView.h
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HorizontalScrollerView;

@protocol HorizontalScrollerViewDelegate <NSObject>

/** 
    代理方法,回调给控制器滚到中间的是哪个视图对应的 index
    控制器拿到 index 之后可以取出模型,然后刷新底部视图数据
 */
- (void)horizontalScrollerViewDelegate:(HorizontalScrollerView *)scrollerView indexOfCenterView:(NSInteger)index;

@end

@interface HorizontalScrollerView : UIView


/**
 代理属性用于调用代理方法
 */
@property (nonatomic, weak) id <HorizontalScrollerViewDelegate>delegate;


/**
 初始化视图
 
 @param frame 视图大小
 @param dataArray
 @return 返回根据数据创建好的水平滚动视图
 */
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray;

@end
