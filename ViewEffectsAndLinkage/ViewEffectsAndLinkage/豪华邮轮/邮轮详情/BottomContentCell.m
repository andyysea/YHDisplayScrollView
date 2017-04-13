//
//  BottomContentCell.m
//  DemoScrollerView
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "BottomContentCell.h"
#import "DownViewModel.h"
#import "UIView+Common.h"
#import "CabinTypeView.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height


@interface BottomContentCell ()

/** 历时时长 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 出发地 */
@property (nonatomic, weak) UILabel *startPlaceLabel;
/** 目的地 */
@property (nonatomic, weak) UILabel *endPlaceLabel;
/** 出发时间 */
@property (nonatomic, weak) UILabel *startTimeLabel;
/** 结束时间 */
@property (nonatomic, weak) UILabel *endTimeLabel;
/** 不同船票类型 */
@property (nonatomic, weak) UIButton *shipTypeButton;

/** 内舱房 */
//@property (nonatomic, weak) UILabel *barnLabel;
///** 海景房 */
//@property (nonatomic, weak) UILabel *seaViewLabel;
///** 阳台房 */
//@property (nonatomic, weak) UILabel *balconyLabel;
///** 套房 */
//@property (nonatomic, weak) UILabel *roomLabel;
//
@end


@implementation BottomContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}



#pragma mark - 重写模型属性setter方法
- (void)setDownModel:(DownViewModel *)downModel {
    _downModel = downModel;
    self.timeLabel.text = downModel.routeDuration;
    self.startPlaceLabel.text = downModel.startPoint;
    self.endPlaceLabel.text = downModel.endPiont;
    self.startTimeLabel.text = downModel.startTime;
    self.endTimeLabel.text = downModel.endTime;
    
    // self.barnLabel.text = downModel.innerRoom;
   // self.seaViewLabel.text = downModel.seaviewRoom;
   // self.balconyLabel.text = downModel.balconyRoom;
   // self.roomLabel.text = downModel.suiteRoom;

    if ([downModel.ticketsType isEqualToString:@"seasonTicket"]) {
        [self.shipTypeButton setTitle:@"一价全含" forState:UIControlStateNormal];
    } else {
        [self.shipTypeButton setTitle:@"单船票" forState:UIControlStateNormal];
    }
    
    // ****** 自定义一个视图,专门创建显示多少船舱房型
    
    NSArray *contentArray = downModel.cabinTypePrice;
    CabinTypeView *typeView = [[CabinTypeView alloc] initWithFrame:CGRectMake(0, 110, self.bounds.size.width, self.bounds.size.height - 110) dataArray:contentArray];
    [self.contentView addSubview:typeView];
}


#pragma mark - 设置界面元素
- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
//    CGFloat topMargin = 0;
//    CGFloat downMargin = 0;
//    if (Width_Window == 375) {
//        topMargin = 5;
//        downMargin = 7;
//    } else if (Width_Window == 414) {
//        topMargin = 8;
//        downMargin = 12;
//    }
    
    
    //上部分左边
    UIImageView *startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 16, 16)];
    startImageView.image = [UIImage imageNamed:@"出发icon"];
    [self.contentView addSubview:startImageView];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 10, 50, 20)];
    startLabel.textAlignment = NSTextAlignmentLeft;
    startLabel.text = @"出发";
    startLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:startLabel];
    
    // * 历时
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 100) / 2 , 10, 100, 20)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = @"23日22晚";
    timeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:timeLabel];
    
    
    // 上部分右边
    UIImageView *endImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 35, 12, 16, 16)];
    endImageView.image = [UIImage imageNamed:@"返航icon"];
    [self.contentView addSubview:endImageView];
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 87, 10, 50, 20)];
    endLabel.textAlignment = NSTextAlignmentRight;
    endLabel.text = @"返回";
    endLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:endLabel];
    
    //* 出发地
    UILabel *startPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 120, 20)];
    startPlaceLabel.text = @"部里克斯";
    startPlaceLabel.textAlignment = NSTextAlignmentCenter;
    startPlaceLabel.textColor = [UIColor darkGrayColor];
    startPlaceLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:startPlaceLabel];
    
    // 船票类型
    UIButton *shipTypeButton = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width - 60) / 2 , timeLabel.bottom + 10, 60, 20)];
    shipTypeButton.enabled = NO;
    [shipTypeButton setTitle:@"单船票" forState:UIControlStateNormal];
    [shipTypeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    shipTypeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [shipTypeButton setBackgroundImage:[UIImage imageNamed:@"button_bg_ wathetBlue"] forState:UIControlStateNormal];
    [self.contentView addSubview:shipTypeButton];
    
    
    //* 目的地
    UILabel *endPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 120, 40, 120, 20)];
    endPlaceLabel.text = @"细腻";
    endPlaceLabel.textAlignment = NSTextAlignmentCenter;
    endPlaceLabel.textColor = [UIColor darkGrayColor];
    endPlaceLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:endPlaceLabel];
    
    // *出发时间
    UILabel *startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 120, 20)];
    startTimeLabel.text = @"2017-02-10";
    startTimeLabel.textAlignment = NSTextAlignmentLeft;
    startTimeLabel.textColor = [UIColor darkGrayColor];
    startTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:startTimeLabel];
    
    // *结束时间
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 15 - 120, 70, 120, 20)];
    endTimeLabel.text = @"2017-02-22";
    endTimeLabel.textAlignment = NSTextAlignmentRight;
    endTimeLabel.textColor = [UIColor darkGrayColor];
    endTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:endTimeLabel];
    
    
    // 底部左侧
//    NSArray *titleArray = @[@"内舱房",@"海景房",@"阳台房",@"套房"];
//    NSInteger index = 0;
//    for (NSString *titleStr in titleArray) {
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, startTimeLabel.bottom + 20 + index * (20 + 5 + downMargin) + topMargin + downMargin, (self.bounds.size.width - 110) / 2, 20)];
//        titleLabel.font = [UIFont systemFontOfSize:13];
//        titleLabel.text = titleStr;
//        titleLabel.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:titleLabel];
//        
//        index++;
//    }
//    
//    // 底部右侧 (内舱房,海景房,阳台房,套房)
//    // 内舱房
//    UILabel *barnLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width + 110) / 2 , endTimeLabel.bottom + 20 + topMargin + downMargin, (self.bounds.size.width - 110) / 2, 20)];
//    barnLabel.font = [UIFont systemFontOfSize:13];
//    barnLabel.text = @"￥1603/人起";
//    barnLabel.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:barnLabel];
//    // 海景房
//    UILabel *seaViewLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width + 110) / 2 , barnLabel.bottom + 5 + downMargin, (self.bounds.size.width - 110) / 2, 20)];
//    seaViewLabel.font = [UIFont systemFontOfSize:13];
//    seaViewLabel.text = @"￥1603/人起";
//    seaViewLabel.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:seaViewLabel];
//    // 阳台房
//    UILabel *balconyLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width + 110) / 2 , seaViewLabel.bottom + 5 + downMargin, (self.bounds.size.width - 110) / 2, 20)];
//    balconyLabel.font = [UIFont systemFontOfSize:13];
//    balconyLabel.text = @"￥1603/人起";
//    balconyLabel.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:balconyLabel];
//    // 套房
//    UILabel *roomLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width + 110) / 2 , balconyLabel.bottom + 5 + downMargin, (self.bounds.size.width - 110) / 2, 20)];
//    roomLabel.font = [UIFont systemFontOfSize:13];
//    roomLabel.text = @"￥1603/人起";
//    roomLabel.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:roomLabel];
//    
    
    
    // 属性记录
    _timeLabel = timeLabel;
    _startPlaceLabel = startPlaceLabel;
    _endPlaceLabel = endPlaceLabel;
    _startTimeLabel = startTimeLabel;
    _endTimeLabel = endTimeLabel;
//    _barnLabel = barnLabel;
//    _seaViewLabel = seaViewLabel;
//    _balconyLabel = balconyLabel;
//    _roomLabel = roomLabel;
//
    _shipTypeButton = shipTypeButton;
}




@end
