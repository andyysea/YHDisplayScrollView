//
//  CruiseDetailViewController.h
//  demoAA
//
//  Created by junde on 2017/2/22.
//  Copyright © 2017年 junde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CruiseDetailViewController : UIViewController


/**
 游行名称 --> 由上一级控制器直接传递,设置为本控制器的导航栏 title
 */
@property (nonatomic, copy) NSString *routeName;

/**
    邮轮对应的 Id 
 */
@property (nonatomic, copy) NSString *shipId;

@end
