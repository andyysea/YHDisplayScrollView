//
//  PlaceContentView.m
//  demoAA
//
//  Created by junde on 2017/2/22.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "PlaceContentView.h"

@implementation PlaceContentView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        if (dataArray.count) {
        
            for (NSInteger i = 0; i < dataArray.count ; i++) {
               
                static UIButton *recordButton = nil;
                static CGFloat margin = 5;
                
                UIButton *button = [[UIButton alloc] init];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                
                NSString *title = dataArray[i];
                CGRect rect = [title
                               boundingRectWithSize:CGSizeMake(self.bounds.size.width, 24)
                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:button.titleLabel.font}
                               context:nil];

                CGFloat buttonW = rect.size.width + margin;
                CGFloat buttonH = rect.size.height + margin;
                
                if (i == 0) {
                    button.frame = CGRectMake(margin, margin, buttonW, buttonH);
                } else {
                    // 剩下的宽度
                    CGFloat restWith = self.bounds.size.width - CGRectGetMaxX(recordButton.frame);
                    if (restWith >= (rect.size.width + margin + 2 * margin)) {
                        button.frame = CGRectMake(CGRectGetMaxX(recordButton.frame) + margin, CGRectGetMinY(recordButton.frame), buttonW, buttonH);
                    } else {
                        button.frame = CGRectMake(margin, CGRectGetMaxY(recordButton.frame) + margin, buttonW, buttonH);
                    }
                }
                
                [button setTitle:title forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:90/255.0 green:130/255.0 blue:160/255.0 alpha:1.0] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"button_bg_light"] forState:UIControlStateNormal];
                button.enabled = NO;
                
                [self addSubview:button];
                
                self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(button.frame) + margin);
                
                recordButton = button;
            }
            
        }
        
    }
    return self;
}


@end
