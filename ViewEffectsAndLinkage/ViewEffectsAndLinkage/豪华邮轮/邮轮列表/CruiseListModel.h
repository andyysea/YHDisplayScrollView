//
//  CruiseListModel.h
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CruiseListModel : NSObject


/**
 邮轮 id
 */
@property (nonatomic, copy) NSString *id;

/**
 图片 urlStr
 */
@property (nonatomic, copy) NSString *listPhoto;

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
 邮轮名称
 */
@property (nonatomic, copy) NSString *shipName;

/**
 船票类型
 seasonTicket 一价全含
 oneTicket    单船票
 */
@property (nonatomic, copy) NSString *ticketsType;


/**
 旅游地点
 ****-->需要 用逗号切割成 数组再使用******
 */
@property (nonatomic, copy) NSString *routeDestination;
/**
 旅游地点 数组, 又 上一个属性切割而来
 */
@property (nonatomic, strong) NSArray *routeDestArray;


/**
    字典转模型的方法
 */
+ (instancetype)cruiseViewModelWithDict:(NSDictionary *)dict;
@end
