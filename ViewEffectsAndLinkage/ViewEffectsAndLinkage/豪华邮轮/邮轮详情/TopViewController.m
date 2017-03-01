//
//  TopViewController.m
//  添加上下控制器
//
//  Created by junde on 2017/2/21.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "TopViewController.h"
#import "TopViewModel.h"
#import <UIImageView+WebCache.h>
#import "ContentCenterView.h" // 地点群视图
#import "UIView+Common.h"
#import <Masonry.h>

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height


@interface TopViewController ()<UIScrollViewDelegate>

/** 底部提示显示更多内容标签 */
@property (nonatomic, weak) UILabel *tipLabel;
/** 顶部大图片 */
@property (nonatomic, weak) UIImageView *topImageView;
/** 顶部显示的邮轮名称 */
@property (nonatomic, weak) UILabel *cruiseTopNameLabel;
/** 价钱 */
@property (nonatomic, weak) UILabel *priceLabel;
/** 旅行时间和地点 */
@property (nonatomic, weak) UILabel *timePlaceLabel;
/** 途经具体港口 */
@property (nonatomic, weak) UILabel *portValueLabel;
/** 邮轮名字 */
@property (nonatomic, weak) UILabel *cruiseNameLabel;
/** 邮轮星级 */
@property (nonatomic, weak) UILabel *curiseStarLabel;
/** 载客量 */
@property (nonatomic, weak) UILabel *personCountLabel;
/** 建造年份 */
@property (nonatomic, weak) UILabel *consTimeLabel;
/** 邮轮吨位 */
@property (nonatomic, weak) UILabel *tonnageLabel;


/** 第二个底部视图 用于添加地点群 */
@property (nonatomic, weak) UIView *twoBgView;



/**
    控制器模型
 */
@property (nonatomic, strong) TopViewModel *topModel;

@end


@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [self setupUI];
    [self loadTopVCData];
}


#pragma mark - 给界面元素设值
// 请求回调数据之后设置
- (void)setElementValueOfInterface {
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.topModel.infoPhoto] placeholderImage:[UIImage imageNamed:@"cruiseImagePlaceholder"]];
    self.cruiseTopNameLabel.text = self.topModel.shipName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@/人起", self.topModel.lowerTicketPrice];
    // 历时 和 游行名称 --> 拼在一个标签内
    self.timePlaceLabel.text = [NSString stringWithFormat:@"%@  %@",self.topModel.routeDuration, self.topModel.routeName];
//****** 这里还需要创建地点标签群,要居中显示并且会换行,拿到数据需要自定义视图做*****
    //----------------------------------------------------------------------------
    ContentCenterView *centerView = [[ContentCenterView alloc] initWithFrame:CGRectMake(0, 0, Width_Window - 20, 20) dataArr:self.topModel.routeDestArray maxWidth:Width_Window - 20];
    [self.twoBgView addSubview:centerView];
    centerView.center = CGPointMake(self.twoBgView.center.x, (self.twoBgView.height + self.timePlaceLabel.bottom) / 2);
    // 以上是设置中心点,所以随标签内容变多,从中心点向周围扩展,事实上这个标签 的量应该在两行内
    //----------------------------------------------------------------------------
    self.portValueLabel.text = self.topModel.gatewayPort;
    self.cruiseNameLabel.text = self.topModel.shipName;
    self.curiseStarLabel.text = self.topModel.starLevel;
    self.personCountLabel.text = [NSString stringWithFormat:@"%@人",self.topModel.passgerCapacity];
    self.consTimeLabel.text = [NSString stringWithFormat:@"%@年",self.topModel.buildYear];
    self.tonnageLabel.text = [NSString stringWithFormat:@"%@吨",self.topModel.tonnage];
}
#pragma mark - 加载顶部视图的数据,也就是本控制器的数据
- (void)loadTopVCData {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topVCJsonData.json" withExtension:nil];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
   
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    
    TopViewModel *model = [TopViewModel topViewModelWithDict:dataDict];
    self.topModel = model;
    
    // 数据请求回调之后给元素设值
    [self setElementValueOfInterface];
    
}


#pragma mark - 冲洗上拉内容
- (void)setTipText:(NSString *)tipText {
    _tipText = tipText;
    self.tipLabel.text = tipText;
}

#pragma mark - 设置界面元素
- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];;
    
    CGFloat imageHeight = 120;
    CGFloat margin = 0;
    if (Width_Window == 375) {
        imageHeight = 150;
        margin = 5;
    } else if (Width_Window == 414) {
        imageHeight = 180;
        margin = 10;
    }
    
    //* 添加图片
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Width_Window, imageHeight)];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    [self.view addSubview:topImageView];
    
//  1>   添加图片上面的底部视图
    UIView *oneBgView = [[UIView alloc] initWithFrame:CGRectMake(0, imageHeight - 40, Width_Window, 40)];
    oneBgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    [topImageView addSubview:oneBgView];
    
    //* 左边船票类型
    UIButton *ticketTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 50, 20)];
    ticketTypeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [ticketTypeButton setTitle:@"单船票" forState:UIControlStateNormal];
    [ticketTypeButton setBackgroundImage:[UIImage imageNamed:@"button_bg_ wathetBlue"] forState:UIControlStateNormal];
    [ticketTypeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oneBgView addSubview:ticketTypeButton];
    
    // 邮轮名称 --> 下面也有个邮轮名称,但是设置的值是一样的
    UILabel *cruiseTopNameLabel = [[UILabel alloc] init];
    cruiseTopNameLabel.font = [UIFont systemFontOfSize:12];
    cruiseTopNameLabel.textAlignment = NSTextAlignmentLeft;
    cruiseTopNameLabel.text = @"皇家加勒比国际游轮·海洋航行者号";
    cruiseTopNameLabel.textColor = [UIColor whiteColor];
    [oneBgView addSubview:cruiseTopNameLabel];
    
    [cruiseTopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ticketTypeButton.mas_right).offset(5);
        make.centerY.equalTo(ticketTypeButton);
    }];
    
    
    //* 价钱
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont boldSystemFontOfSize:18];
    priceLabel.text = @"¥1533元/人起";
    priceLabel.textColor = [UIColor whiteColor];
    [oneBgView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oneBgView).offset(-15);
        make.centerY.equalTo(oneBgView);
    }];
    
// 2>   底部视图
    UIView *twoBgView = [[UIView alloc] initWithFrame:CGRectMake(0, topImageView.bottom, Width_Window, imageHeight / 2 + 10)];
    twoBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:twoBgView];
    
    //*  旅行时间和地点的底部视图
    UILabel *timePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + margin, Width_Window - 20, 20)];
    timePlaceLabel.font = [UIFont systemFontOfSize:15];
    timePlaceLabel.textAlignment = NSTextAlignmentCenter;
    timePlaceLabel.text = @"2晚3日  澳洲之旅";
    [twoBgView addSubview:timePlaceLabel];
    
//   **  途经国家 地点群标签,自定义视图做- 得等到数据请求回来之后才添加
    
// 3>     底部视图
    UIView *threeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, twoBgView.bottom + 10, Width_Window, imageHeight / 2 + 10)];
    threeBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:threeBgView];
    
    // 途经港口
    UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + margin, Width_Window - 20, 22)];
    portLabel.textAlignment = NSTextAlignmentCenter;
    portLabel.font = [UIFont systemFontOfSize:15];
    portLabel.text = @"途经港口";
    portLabel.textColor = [UIColor darkGrayColor];
    [threeBgView addSubview:portLabel];
    
    //* 途经具体港口
    UILabel *portValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, portLabel.bottom + 5 + margin, Width_Window - 20, 22)];
    portValueLabel.textAlignment = NSTextAlignmentCenter;
    portValueLabel.font = [UIFont systemFontOfSize:14];
    portValueLabel.text = @"布里斯班—悉尼";
    [threeBgView addSubview:portValueLabel];

// 4>    添加底部视图
    UIView *fourBgView = [[UIView alloc] initWithFrame:CGRectMake(0, threeBgView.bottom + 10, Width_Window, imageHeight * 3 / 4 + 20)];
    fourBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fourBgView];
    
    // *邮轮名字
    UILabel *cruiseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8 + margin, Width_Window - 20, 22)];
    cruiseNameLabel.font = [UIFont systemFontOfSize:15];
    cruiseNameLabel.textAlignment = NSTextAlignmentCenter;
    cruiseNameLabel.text = @"皇家加勒比国际游轮·海洋航行者号";
    [fourBgView addSubview:cruiseNameLabel];
    
    //* 邮轮星级
    UILabel *curiseStarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cruiseNameLabel.bottom + 13 + margin, Width_Window / 4, 22)];
    curiseStarLabel.text = @"4.0";
    curiseStarLabel.font = [UIFont systemFontOfSize:14];
    curiseStarLabel.textAlignment = NSTextAlignmentCenter;
    [fourBgView addSubview:curiseStarLabel];
    //* 载客量
    UILabel *personCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(curiseStarLabel.right, cruiseNameLabel.bottom + 13 + margin, Width_Window / 4, 22)];
    personCountLabel.text = @"1990人";
    personCountLabel.font = [UIFont systemFontOfSize:14];
    personCountLabel.textAlignment = NSTextAlignmentCenter;
    [fourBgView addSubview:personCountLabel];
    // *建造年份
    UILabel *consTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(personCountLabel.right, cruiseNameLabel.bottom + 13 + margin, Width_Window / 4, 22)];
    consTimeLabel.text = @"1995年";
    consTimeLabel.font = [UIFont systemFontOfSize:14];
    consTimeLabel.textAlignment = NSTextAlignmentCenter;
    [fourBgView addSubview:consTimeLabel];
    // *吨位
    UILabel *tonnageLabel = [[UILabel alloc] initWithFrame:CGRectMake(consTimeLabel.right, cruiseNameLabel.bottom + 13 + margin, Width_Window / 4, 22)];
    tonnageLabel.text = @"7700吨";
    tonnageLabel.font = [UIFont systemFontOfSize:14];
    tonnageLabel.textAlignment = NSTextAlignmentCenter;
    [fourBgView addSubview:tonnageLabel];

    // 添加四个固定标签
    NSArray *labelArray = @[@"邮轮星级",@"载客量",@"建造年份",@"吨位"];
    for (NSInteger i = 0; i < labelArray.count; i++) {
        NSString *titleText = labelArray[i];
        UILabel *fixLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width_Window / 4 * i, tonnageLabel.bottom + 8 + margin, Width_Window / 4, 22)];
        fixLabel.text = titleText;
        fixLabel.font = [UIFont systemFontOfSize:14];
        fixLabel.textColor = [UIColor darkGrayColor];
        fixLabel.textAlignment = NSTextAlignmentCenter;
        [fourBgView addSubview:fixLabel];
    }
    
    
    
    // 底部提示标签
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, Height_Window - 70, Width_Window - 30, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((Width_Window - 120) / 2, Height_Window - 80, 120, 20)];
    tipLabel.backgroundColor =  [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:tipLabel];
    
    // 属性记录
    _tipLabel = tipLabel;
    _topImageView = topImageView;
    _cruiseTopNameLabel = cruiseTopNameLabel;
    _priceLabel = priceLabel;
    _timePlaceLabel = timePlaceLabel;
    _portValueLabel = portValueLabel;
    _cruiseNameLabel = cruiseNameLabel;
    _curiseStarLabel = curiseStarLabel;
    _personCountLabel = personCountLabel;
    _consTimeLabel = consTimeLabel;
    _tonnageLabel = tonnageLabel;
    
    _twoBgView = twoBgView;
}

@end
