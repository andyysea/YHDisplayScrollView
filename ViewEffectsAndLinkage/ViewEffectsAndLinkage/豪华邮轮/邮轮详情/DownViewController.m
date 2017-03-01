//
//  DownViewController.m
//  添加上下控制器
//
//  Created by junde on 2017/2/21.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "DownViewController.h"
#import "HorizontalScrollerView.h"
#import "BottomContentView.h"
#import "DownViewModel.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height


@interface DownViewController ()<HorizontalScrollerViewDelegate>


/**
 模型数据数组 (内部元素是数组,内部元素的元素才是模型)
 */
@property (nonatomic, strong) NSArray *modelArray;

/**
 底部添加的封装视图
 */
@property (nonatomic, weak) BottomContentView *bottomView;

@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDownVCData];
}


#pragma mark - 加载底部控制器的数据,也是本控制器的数据
- (void)loadDownVCData {
//    [[RequestManger Instance] loadCuriseDetailDownVCDataWithShipId:self.shipId success:^(id requestEncode) {
//        
//        NSDictionary *dict = requestEncode;
//        
//        if ([dict[@"code"] isEqualToString:@"0000"]) {
//            
//            NSArray *contentArray = dict[@"data"][@"voyageInfo"];
//            
//            if (contentArray.count) {
//               
//                NSMutableArray *outArrayM = [NSMutableArray array];
//                for (NSArray *outArray in contentArray) {
//                    if (outArray.count) {
//                        NSMutableArray *arrayM = [NSMutableArray array];
//                        for (NSDictionary *dict in outArray) {
//                            DownViewModel *model = [DownViewModel downViewModelWithDict:dict];
//                            [arrayM addObject:model];
//                        }
//                        [outArrayM addObject:arrayM];
//                    }
//                }
//                self.modelArray = outArrayM.copy;
//            }
//        
//            // 拿到数据之后再创建界面元素
//            [self setupUI];
//            
//        }else if([dict[@"code"] isEqualToString:@"9999"]){
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [delegate logOutUserInfo];
//        }else{
//            [ProgressHUD showError:[NSString stringWithFormat:@"%@",dict[@"msg"]]];
//        }
//    } error:^(NSError *error) {
//        [ProgressHUD showError:@"加载失败,请确认网络通畅"];
//    }];
}


#pragma mark - HorizontalScrollerViewDelegate
// 顶部滚动视图代理方法,回调哪个滚到中间了
- (void)horizontalScrollerViewDelegate:(HorizontalScrollerView *)scrollerView indexOfCenterView:(NSInteger)index {
    NSLog(@"index --> %zd", index);

    if (index < self.modelArray.count) {
        self.bottomView.bottomModelArray = self.modelArray[index];
    }
}



#pragma mark - 设置界面元素
- (void)setupUI {
    self.view.backgroundColor = [UIColor customBackgroundColor1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat bgHeight = 90;
    if (Width_Window == 375) {
        bgHeight = 120;
    } else if (Width_Window == 414) {
        bgHeight = 130;
    }
    
    // 1> 添加顶部滚动视图
//**** 这里的初始化方法,要同时把数据传递进去,所以创建要在请求数据之后再创建,同时初始化方法要改进
    HorizontalScrollerView *horView = [[HorizontalScrollerView alloc] initWithFrame:CGRectMake(0, 64, Width_Window, bgHeight) withData:self.modelArray];
    horView.backgroundColor = [UIColor whiteColor];
    horView.delegate = self;
    
    [self.view addSubview:horView];
    
    // 2> 添加一个固定的定不是图的中心线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(Width_Window / 2 - (Width_Window - 30) / 3 / 2, horView.bottom - 2, (Width_Window - 30) / 3, 2)];
    lineView.backgroundColor =  [UIColor redColor];
    [self.view addSubview:lineView];
    
    // 自定义底部视图
    BottomContentView *bottomView = [[BottomContentView alloc] initWithFrame:CGRectMake(0, horView.bottom + 25, Width_Window, bgHeight + bgHeight / 3 * 4  + 30)];
    bottomView.backgroundColor = [UIColor customBackgroundColor1];
    [self.view addSubview:bottomView];

    // 传递初始数据
    if (self.modelArray.count) {
        bottomView.bottomModelArray = self.modelArray.firstObject;
    }
    
    // 属性记录
    _bottomView = bottomView;
}



@end
