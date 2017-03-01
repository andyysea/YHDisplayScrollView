//
//  PlaceContentView.h
//  demoAA
//
//  Created by junde on 2017/2/22.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 该类是自定义一个视图,将外界传入的数组进来的时候,自动创建数组数量的标签,
 这些标签显示数组数据,并且规律排列
 */
@interface PlaceContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray;

@end
