//
//  TopViewModel.h
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopViewModel : NSObject

/**
 船票类型
 seasonTicket 一价全含
 oneTicket    单船票
 */
@property (nonatomic, copy) NSString *ticketsType;


/**
 游轮id
 */
@property (nonatomic, copy) NSString *id;
/**
 游轮图片 url
 */
@property (nonatomic, copy) NSString *infoPhoto;
/**
 最低票价
 */
@property (nonatomic, copy) NSString *lowerTicketPrice;
/**
 历时
 */
@property (nonatomic, copy) NSString *routeDuration;
/**
 游行名称
 */
@property (nonatomic, copy) NSString *routeName;


/**
 游行地点（用，分开）-->  这个属性与列表中的一致 用逗号切割成数组
 */
@property (nonatomic, copy) NSString *routeDestination;
/**
 旅游地点 数组, 又 上一个属性切割而来
 */
@property (nonatomic, strong) NSArray *routeDestArray;


/**
 途径港口
 */
@property (nonatomic, copy) NSString *gatewayPort;

/**
 游轮名称
 */
@property (nonatomic, copy) NSString *shipName;
/**
 游轮星级
 */
@property (nonatomic, copy) NSString *starLevel;
/**
 载客量
 */
@property (nonatomic, copy) NSString *passgerCapacity;
/**
 建造年份
 */
@property (nonatomic, copy) NSString *buildYear;

/**
 吨位
 */
@property (nonatomic, copy) NSString *tonnage;


/**
    类方法回调,字典转换好的模型
 */
+ (instancetype)topViewModelWithDict:(NSDictionary *)dict;

@end
