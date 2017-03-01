//
//  BottomContentView.h
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownViewModel;


@interface BottomContentView : UIView

/**
 模型数组
 */
@property (nonatomic, strong) NSArray <DownViewModel *>*bottomModelArray;


@end
