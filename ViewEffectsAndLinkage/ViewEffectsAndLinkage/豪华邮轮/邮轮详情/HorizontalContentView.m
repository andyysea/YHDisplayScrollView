//
//  HorizontalContentView.m
//  DemoScrollerView
//
//  Created by junde on 2017/2/23.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "HorizontalContentView.h"
#import "DownViewModel.h"

@interface HorizontalContentView ()

// 年份
@property (nonatomic, weak) UILabel *yearLabel;
// 月份
@property (nonatomic, weak) UILabel *monthLabel;
// 钱数
@property (nonatomic, weak) UILabel *priceLabel;

@end


@implementation HorizontalContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setupUI];
    }
    return self;
}


- (void)setIsBlackColor:(BOOL)isBlackColor {
    _isBlackColor = isBlackColor;
   
    if (isBlackColor) {
        self.yearLabel.textColor = [UIColor blackColor];
        self.monthLabel.textColor = [UIColor blackColor];
        self.priceLabel.textColor = [UIColor blackColor];
    } else {
        self.yearLabel.textColor = [UIColor lightGrayColor];
        self.monthLabel.textColor = [UIColor lightGrayColor];
        self.priceLabel.textColor = [UIColor lightGrayColor];
    }
}



#pragma mark - 重写模型set方法 
// 设置数据
- (void)setModel:(DownViewModel *)model {
    _model = model;
    
    NSString *yearStr = [model.shipTime substringToIndex:4];
    NSString *monthStr = nil;
    if ([model.shipTime rangeOfString:@"-0"].length) {
        monthStr = [model.shipTime substringFromIndex:6];
    } else {
        monthStr = [model.shipTime substringFromIndex:5];
    }
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@年", yearStr];
    self.monthLabel.text = [NSString stringWithFormat:@"%@月[%@航期]", monthStr, model.shipCount];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@/人起",model.lowerTicketPrice];
}

#pragma mark - 设置界面元素
- (void)setupUI {

    CGFloat Width = self.bounds.size.width;
    CGFloat Height = self.bounds.size.height / 3;
    
    // 年份
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Width, Height)];
    yearLabel.font = [UIFont systemFontOfSize:14];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.text = @"2017年";
    yearLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:yearLabel];
    
    // 月份以及期数
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height, Width, Height)];
    monthLabel.font = [UIFont systemFontOfSize:14];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.text = @"4月[2航期]";
    monthLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:monthLabel];

    // 钱数
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Height * 2 - 10, Width, Height)];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.text = @"￥1603/人起";
    priceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:priceLabel];
    
    
    // 记录属性
    _yearLabel = yearLabel;
    _monthLabel = monthLabel;
    _priceLabel = priceLabel;
}


@end
