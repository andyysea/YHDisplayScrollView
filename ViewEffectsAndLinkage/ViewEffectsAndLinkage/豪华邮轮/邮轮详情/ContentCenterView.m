//
//  ContentCenterView.m
//  DemoButton
//
//  Created by junde on 2017/2/27.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "ContentCenterView.h"

//宽和高
#define Width_Window  [UIScreen mainScreen].bounds.size.width
#define Height_Window [UIScreen mainScreen].bounds.size.height

@interface ContentCenterView ()
/**
 该自定义视图,是否达到了最大宽度
 */
@property (nonatomic, assign) BOOL isMaxWidth;

/**
    存储每一行最大宽度的数组
 */
@property (nonatomic, strong) NSMutableArray *maxWidthArrayM;

@end


@implementation ContentCenterView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray maxWidth:(CGFloat)maxWidth {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        if (dataArray.count) {
            
            self.maxWidthArrayM = [NSMutableArray array]; // 初始化
            self.isMaxWidth = NO; // 初始化
            static UIButton *recordButton = nil;
            static CGFloat margin = 5;
            
            for (NSInteger i = 0; i < dataArray.count; i++) {
                
                NSString *titleText = dataArray[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                [button setTitle:titleText forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:90/255.0 green:130/255.0 blue:160/255.0 alpha:1.0] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"button_bg_light"] forState:UIControlStateNormal];
                button.enabled = NO;

        
                
                CGRect rect = [titleText boundingRectWithSize:CGSizeMake(self.bounds.size.width , 24) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil];
                
                CGFloat buttonW = rect.size.width + margin; //按钮比文字宽一点
                CGFloat buttonH = rect.size.height + margin;// 按钮比文字高一点
                
                if (i == 0) {
                    button.frame = CGRectMake(margin, margin, buttonW, buttonH);
                } else {
                    // 剩下的宽度 -> 本视图可能得最大宽度 - 按钮的右侧最大 X
                    // ******* 注意这里的最大可能宽度
                    CGFloat restWith = maxWidth - CGRectGetMaxX(recordButton.frame);
                    
                    if (restWith >= (buttonW + 2 * margin)) {
                        button.frame = CGRectMake(CGRectGetMaxX(recordButton.frame) + margin, CGRectGetMinY(recordButton.frame), buttonW, buttonH);
                        
                        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(button.frame) + margin);
                    } else {
                        self.isMaxWidth = YES; // 此时表示,本自定义视图已经达到了可能达到的最大的宽度 - 外界只需要设置中心点位置,就可以居中显示了
                        
                        button.frame = CGRectMake(margin, CGRectGetMaxY(recordButton.frame) + margin, buttonW, buttonH);
                        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(button.frame) + margin);
                    }
                }
                
                 // 1>最后一个添加上时,也存在没有换行,但是此时的 maxW 最大的情况
                 // 2>也存在最后一个添加上时,换行了,此时宽度最大
                 // 3>每次换行,宽度只是可能最大,所以避免
                 // 4> 为了避免多次判断,重复的遍历,只需要将每添加一个空间,存储一下此时的最大宽度,最后统一排序,再设置self的frame,以此提高性能
                CGFloat maxW = CGRectGetMaxX(button.frame) + margin;
                [self.maxWidthArrayM addObject:@(maxW)];
                
                [self addSubview:button]; // 添加
                recordButton = button; // 记录
            }
            
            // 数组排序
           NSArray *result = [self.maxWidthArrayM sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
               
               NSLog(@"%ld", (long)[obj1 compare:obj2]);
               
                return [obj1 compare:obj2];
            }];

            // 设置self.frame, 主要是找一个合适的最大宽度
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, [result.lastObject floatValue], CGRectGetMaxY(recordButton.frame) + margin);
        }
        
    }
    return self;
}


@end
