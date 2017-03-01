//
//  CruiseListViewCell.m
//  demoAA
//
//  Created by junde on 2017/2/21.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "CruiseListViewCell.h"
#import "PlaceContentView.h"
#import "CruiseListModel.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>


#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height



@interface CruiseListViewCell ()
/** 邮轮背景图片 */
@property (nonatomic, weak) UIImageView *bgImageView;
/** 旅行时间 */
@property (nonatomic, weak) UILabel *travelTimeLabel;
/** 旅行地点 */
//@property (nonatomic, weak) UILabel *travelPlaceLabel;
/** 旅行价格 */
@property (nonatomic, weak) UILabel *priceLabel;
/** 船票类型 */
//@property (nonatomic, weak) UILabel *ticketTypeLabel;
/** 邮轮名字 */
@property (nonatomic, weak) UILabel*cruiseNameLabel;

// 途经地点--> 可能多个
@property (nonatomic, strong) PlaceContentView *placeView;
@end


@implementation CruiseListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 重写模型的set方法, 测试添加标签
- (void)setModel:(CruiseListModel *)model {
    _model = model;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.listPhoto] placeholderImage:[UIImage imageNamed:@"cruiseImagePlaceholder"]];
  // 旅行时间和地点拼接在一起
    self.travelTimeLabel.text = [NSString stringWithFormat:@"%@ · %@", model.routeDuration, model.routeName];
    // 设置多个途经地
    [self.placeView removeFromSuperview];
    self.placeView = nil;
    if (self.placeView == nil && model.routeDestArray.count) {
        self.placeView = [[PlaceContentView alloc] initWithFrame:CGRectMake(20, 40, Width_Window - 40, 40) dataArr:model.routeDestArray];
        [self.contentView addSubview:self.placeView];
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@/人起", model.lowerTicketPrice];
    
    self.cruiseNameLabel.text = model.shipName;
}



#pragma mark - 设置界面元素
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    // 背景邮轮图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_Window, 180)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self.contentView addSubview:bgImageView];
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Window, 40)];
    topBgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    [bgImageView addSubview:topBgView];
    
    
    // 添加小黄线
    UIView *ylineView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 3, 20)];
    ylineView.backgroundColor = [UIColor orangeColor];
    [topBgView addSubview:ylineView];
    
    
    // 旅行时间 * 地点
    UILabel *travelTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 8, Width_Window - 44, 24)];
    travelTimeLabel.font = [UIFont systemFontOfSize:18];
    travelTimeLabel.textColor = [UIColor whiteColor];
    travelTimeLabel.text = @"2晚3日";
    [topBgView addSubview:travelTimeLabel];
    
    
    // 如果是多地旅游的旅行地点标签 --> 这个需要根据数量 - 动态创建
    
    // 价钱
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont boldSystemFontOfSize:18];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.text = @"¥1533元/人起";
    [self.contentView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    // 船票类型
    UIButton *ticketTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 125, 50, 20)];
    ticketTypeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [ticketTypeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [ticketTypeButton setTitle:@"单船票" forState:UIControlStateNormal];
    [ticketTypeButton setBackgroundImage:[UIImage imageNamed:@"button_bg_ wathetBlue"] forState:UIControlStateNormal];
    [self.contentView addSubview:ticketTypeButton];
    
    // 邮轮名字
    UILabel *cruiseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, Width_Window - 40, 25)];
    cruiseNameLabel.font = [UIFont systemFontOfSize:14];
    cruiseNameLabel.text = @"皇家加勒比国际游轮·海洋航行者号";
    cruiseNameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:cruiseNameLabel];
  
    
    
//  记录
    _bgImageView = bgImageView;
    _travelTimeLabel = travelTimeLabel;
//    _travelPlaceLabel = travelPlaceLabel;
    _priceLabel = priceLabel;
//    _ticketTypeLabel = ticketTypeLabel;
    _cruiseNameLabel = cruiseNameLabel;
}


@end
