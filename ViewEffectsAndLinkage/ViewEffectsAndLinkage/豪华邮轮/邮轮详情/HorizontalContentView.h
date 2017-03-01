//
//  HorizontalContentView.h
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownViewModel;

@interface HorizontalContentView : UIView

/**
 给视图传递数据的模型
 */
@property (nonatomic, strong) DownViewModel *model;


/**
    是否是滚到中心的黑色
 */
@property (nonatomic, assign) BOOL isBlackColor;

@end
