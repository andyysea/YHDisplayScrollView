//
//  BottomContentCell.h
//  DemoScrollerView
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownViewModel;


@interface BottomContentCell : UICollectionViewCell

/**
 模型属性
 */
@property (nonatomic, strong) DownViewModel *downModel;

@end

