//
//  CruiseDetailViewController.m
//  demoAA
//
//  Created by junde on 2017/2/22.
//  Copyright © 2017年 junde. All rights reserved.
//

#import "CruiseDetailViewController.h"
#import "TopViewController.h"
#import "DownViewController.h"
#import "CruiseCommitViewController.h"
#import "UIView+Common.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height

/** 初始化底部控制器的时候,当船舱类型太多超出屏幕的通知名 */
extern NSString *const CabinTypeExceedScreenHeightByInitializeNotification;
/** 当点击不同月份对应的航期,当船舱类型不同时来修改底部控制器的滚动范围的通知名 */
extern NSString *const CabinTypeExceedScreenHeightByClickNotification;
/** 需要设置的滚动高度对应的key */
extern NSString *const DownVCScrollHeightKey;

@interface CruiseDetailViewController ()<UIScrollViewDelegate>

// 上一个控制器
@property (nonatomic, weak) TopViewController *topVC;
// 下面控制器
@property (nonatomic, weak) DownViewController *downVC;
// 滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isUP; //判断是否在上
@property (nonatomic, assign) CGFloat contentInSet; //初始ContentInset
@property (nonatomic, assign) CGFloat HeightForSecton1; // 第一个区高度
@property (nonatomic, assign) CGFloat HeightForAlertView; // 中间过渡
@property (nonatomic, assign) CGFloat HeightForSecton2; // 第二个区的高
@property (nonatomic, assign) CGFloat whenDown; //设置拖动到什么时候->下拉翻页
@property (nonatomic, assign) CGFloat whenUp; //设置拖动到什么时候 ->上拉翻页

@end

@implementation CruiseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver];
    [self setupUI];
//    [self setupOther];
    
}

#pragma mark - 添加观察者
- (void)addObserver {
    // **********
    /** 添加观察者,注意这个是初始化底部控制器之前就要添加的观察者, 同时不要与初始化默认的滚动范围有冲突
     因为在创建添加底部控制器的时候,如果满足了条件,就会触发发送通知,修改初始化默认的底部控制器的滚动垂直方向的滚动范围,所以初始化数据的方法调用要在添加底部控制器之前
     此外还有添加一个当点击底部控制器上方的不同月份的航期的时候,改变滚动范围,因为在点击了之后才会发送通知,所以这个观察者可以添加时机,相对考虑的少一些
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InitlizeDownVCNotification:) name:CabinTypeExceedScreenHeightByInitializeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickDifferentMonthNotification:) name:CabinTypeExceedScreenHeightByClickNotification object:nil];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 观察者调用的方法
/** 初始化底部控制器,
 该通知是提前修改 self.HeightForSecton2 的默认值,当上拉的时候就可以变化了
 */
- (void)InitlizeDownVCNotification:(NSNotification *)n {
    NSLog(@"-----调用通知了------");
    NSInteger scrollHeight = [n.userInfo[DownVCScrollHeightKey] integerValue];
    if (scrollHeight > self.HeightForSecton2) {
        self.HeightForSecton2 = scrollHeight;
    }
    
    NSLog(@"scrollHeight -> %zd", scrollHeight);
}

/** 点击不同月份对应的航期的时候对应的航期 */
- (void)ClickDifferentMonthNotification:(NSNotification *)n {
    NSInteger scrollHeight = [n.userInfo[DownVCScrollHeightKey] integerValue];
    if ((scrollHeight < self.HeightForSecton2) && self.HeightForSecton2 > Height_Window) {
        
    }
    self.HeightForSecton2 = scrollHeight;
    self.scrollView.contentSize = CGSizeMake(Width_Window, self.HeightForSecton1 + self.HeightForSecton2);
    
    NSLog(@"scrollHeight --> %zd",scrollHeight);
}



#pragma mark - 立即预约按钮点击方法
- (void)bookButtonClick {
//    NSLog(@"---> 点击了立即预约");
    CruiseCommitViewController *commitVC = [CruiseCommitViewController new];
    commitVC.shipId = self.shipId;
    [self.navigationController pushViewController:commitVC animated:YES];
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
//        NSLog(@" 00 --> %f", offsetY);
    if (self.isUP == YES) {
        //当前是第一页时
        if (offsetY >= self.whenDown) {
            self.topVC.tipText = @"松开查看更多详情";
        }else{
            self.topVC.tipText = @"继续拖动,查看更多信息";
        }
    }else{
        //当前是第二页时
        if (offsetY <= self.whenUp) {
            self.topVC.tipText = @"松开查看简介";
        }else{
            self.topVC.tipText = @"下拉可以查看简介";
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@" 00 --> %f", offsetY);

    if (self.isUP) {
        // 当前是第一页 -> 第二页
        if (offsetY >= self.whenDown) {
            //上滑
            //此处动画有2个   第一个为过渡动画  不设置第一个动画的话 将会有一个闪屏的问题。
            //第一个动画将contentInset 设置到当前contentOffset.y
            [UIView animateWithDuration:0.01 animations:^{
                // 第一个动画
                scrollView.contentInset = UIEdgeInsetsMake(- offsetY, 0, 0, 0);
            } completion:^(BOOL finished) {
                // 第一个完成后执行第二个动画
                [UIView animateWithDuration:0.25 animations:^{
                    // 第二个动画 -> 将contentInset 设置为显示第二页
                    scrollView.contentInset = UIEdgeInsetsMake(- (self.HeightForSecton1 + self.contentInSet) , 0, 0, 0);
                    
                } completion:^(BOOL finished) {
                    // 完成设置显示范围,要设置滚动范围为第二页内容的滚动范围
                    //        -> 此时为第一页内容高度 + 第二页内容高度
                    scrollView.contentSize = CGSizeMake(Width_Window, self.HeightForSecton1 + self.HeightForSecton2);
                    self.isUP = NO;
                    
                    //                    self.navigationController.navigationBar.hidden = YES;
                    
                }];
                
            }];
            
        }
    } else {
        // 当前是第二页 -> 第一页
        if (offsetY <= self.whenUp) {
            // 下滑
            [UIView animateWithDuration:0.01 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(- offsetY, 0, 0, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    scrollView.contentInset = UIEdgeInsetsMake(- self.contentInSet, 0, 0, 0);
                    scrollView.contentSize = CGSizeMake(Width_Window, self.HeightForSecton1);
                } completion:^(BOOL finished) {
                    self.isUP = YES;
                    // 这里再加上一句代码,避免不显示下拉查看更多
                    self.topVC.tipText = @"继续拖动,查看更多信息";
                    
                    //                    self.navigationController.navigationBar.hidden = NO;
                    
                }];
            }];
        }
    }
}



#pragma mark - 设置其他元素
- (void)setupOther {
    self.scrollView.alwaysBounceVertical = YES; // 垂直方向总是有弹性
    
    // 初始化
    self.isUP = YES;
    self.contentInSet = self.scrollView.contentInset.top;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(- 64, 0, 0, 0);
    self.HeightForSecton1 = Height_Window;
    self.HeightForAlertView = 50;
    self.HeightForSecton2 = Height_Window;
    
    self.whenDown = self.HeightForSecton1 - self.scrollView.bounds.size.height + self.HeightForAlertView; //当前是第一页,要上拉。设置上拉 提示框高度 就可以滑动到下一页。可具体修改
    self.whenUp = self.HeightForSecton1 - self.HeightForAlertView; // 当前第二页,要下拉,这里设置的是当过渡框完全进入第二页 滑动到上一页。可具体修改
    
    
    [self.scrollView setContentSize:CGSizeMake(Width_Window, self.HeightForSecton1)];//一开始是第一页,所以只用显示第一页的滑动大小
    
    
}

#pragma mark - 设置界面元素
- (void)setupUI {
    self.title = self.routeName;
    self.view.backgroundColor = [UIColor  whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    //    scrollView.contentSize = CGSizeMake(Width_Window, Height_Window * 2);
    [self.view addSubview:scrollView];
    
    _scrollView = scrollView;

    [self setupOther];
  
    
    // 这里的背景视图要有 2 倍的屏幕高度,否则,底部控制器视图没有添加父视图有效范围上,无法做出响应
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width_Window, Height_Window * 2)];
    [scrollView addSubview:bgView];
    
    
    TopViewController *topVC = [TopViewController new];
    topVC.shipId = self.shipId; // 注意传递参数的顺序,创建出来就传递,不要添加完成才传递
    [self addChildViewController:topVC];
    [bgView addSubview:topVC.view];
    [topVC didMoveToParentViewController:self];
    topVC.view.frame = CGRectMake(0, 0, Width_Window, Height_Window);
    
    DownViewController *downVC = [DownViewController new];
    downVC.shipId = self.shipId;
    [self addChildViewController:downVC];
    [bgView addSubview:downVC.view];
    downVC.view.frame = CGRectMake(0, Height_Window, Width_Window, Height_Window);
    
    // 添加预约按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"立即预约" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(10, self.view.bottom - 54, Width_Window - 20, 44);
    [button addTarget:self action:@selector(bookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // 属性记录
    _topVC = topVC;
    _downVC = downVC;
    
}


@end
