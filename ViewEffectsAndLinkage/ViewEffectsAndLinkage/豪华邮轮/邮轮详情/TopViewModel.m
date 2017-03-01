//
//  TopViewModel.m
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import "TopViewModel.h"

@implementation TopViewModel


+ (instancetype)topViewModelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initTopViewModelWithDict:dict];
}


- (instancetype)initTopViewModelWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

//  讲目的地改成字符串改成数组
- (void)setRouteDestination:(NSString *)routeDestination {
    _routeDestination = routeDestination;
    
    if (routeDestination.length) {
        
        self.routeDestArray = [routeDestination componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    }
}
@end
