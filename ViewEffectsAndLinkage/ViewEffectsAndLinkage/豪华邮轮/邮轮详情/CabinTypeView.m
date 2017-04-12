//
//  CabinTypeView.m
//  ViewEffectsAndLinkage
//
//  Created by junde on 2017/4/12.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "CabinTypeView.h"

@implementation CabinTypeView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)cabinTypeData {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithData:cabinTypeData];
    }
    return self;
}


#pragma mark - 设置界面元素
/** 先创建 20 个房间以及型号 */
- (void)setupUIWithData:(NSArray *)cabinTypeData {
    
    if (cabinTypeData.count) {
        
        NSInteger index = 0;
        for (NSDictionary *contentDict in cabinTypeData) {
            
            // 左侧房间类型标签
            UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, index * 25, (self.bounds.size.width - 110) / 2, 25)];
            leftLabel.font = [UIFont systemFontOfSize:13];
            leftLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:leftLabel];
          
            // 右侧对应价格标签
            UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width + 110) / 2, index * 25, (self.bounds.size.width - 110) / 2, 25)];
            rightLabel.font = [UIFont systemFontOfSize:13];
            rightLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:rightLabel];
            
            // 赋值
            leftLabel.text = contentDict[@"cabinType"];
            rightLabel.text = contentDict[@"cabinPrice"];
            
            index ++;
        }
    }
}


@end
