//
//  DownViewModel.m
//  jundehui
//
//  Created by junde on 2017/2/24.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import "DownViewModel.h"

@implementation DownViewModel


+ (instancetype)downViewModelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initDownViewModelWithDict:dict];
}


- (instancetype)initDownViewModelWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}


@end
