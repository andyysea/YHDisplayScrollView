//
//  DownViewModel.h
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownViewModel : NSObject

/** 游轮Id */
@property (nonatomic, copy) NSString *shipId;


/** 游行年月 --> 需要截取成 年 月  */
@property (nonatomic, copy) NSString *shipTime;
/** 航期数 */
@property (nonatomic, copy) NSString *shipCount;
/** 最低票价 */
@property (nonatomic, copy) NSString *lowerTicketPrice;


/** 历时时长 */
@property (nonatomic, copy) NSString *routeDuration;
/** 离岗地点 */
@property (nonatomic, copy) NSString *startPoint;
/** 抵港地点 */
@property (nonatomic, copy) NSString *endPiont;
/** 离港时间 */
@property (nonatomic, copy) NSString *startTime;
/** 抵港时间 */
@property (nonatomic, copy) NSString *endTime;

/** 内仓房 */
@property (nonatomic, copy) NSString *innerRoom;
/** 海景房 */
@property (nonatomic, copy) NSString *seaviewRoom;
/** 阳台房 */
@property (nonatomic, copy) NSString *balconyRoom;
/** 套房 */
@property (nonatomic, copy) NSString *suiteRoom;



/**
 类方法返回字典转好的模型
*/
+ (instancetype)downViewModelWithDict:(NSDictionary *)dict;


@end
