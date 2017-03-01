//
//  CruiseCommitViewController.m
//  jundehui
//
//  Created by junde on 2017/2/27.
//  Copyright © 2017年 QiuFairy. All rights reserved.
//

#import "CruiseCommitViewController.h"
#import "UIView+Common.h"

#define Width_Window    [UIScreen mainScreen].bounds.size.width
#define Height_Window   [UIScreen mainScreen].bounds.size.height

@interface CruiseCommitViewController ()

/** 输入姓名 */
@property (nonatomic, weak) UITextField *personField;
/** 电话号码 */
@property (nonatomic, weak) UITextField *phoneField;

@end

@implementation CruiseCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadUserInData];
}

#pragma mark - 立即预约电话
- (void)commitButtonClick {
//    if (self.personField.text.length == 0) {
//        [ProgressHUD showError:@"请输入预约人"];
//        return;
//    } else if (self.phoneField.text.length == 0) {
//        [ProgressHUD showError:@"请输入联系电话"];
//        return;
//    }
//    [ProgressHUD show:@"提交中,请稍后" Interaction:NO];
//    [[RequestManger Instance] loadCruiseCommitBookingDataWithShipId:self.shipId name:self.personField.text phone:self.phoneField.text success:^(id requestEncode) {
//        NSDictionary *dict = requestEncode;
//        
//        if ([dict[@"code"] isEqualToString:@"0000"]) {
//
//            if ([dict[@"data"][@"flag"] isEqualToString:@"true"]) {
//                
//                [ProgressHUD showSuccess:@"提交成功~"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                });
//            } else {
//                [ProgressHUD showError:dict[@"msg"]];
//            }
//            
//        }else if([dict[@"code"] isEqualToString:@"9999"]){
//            [ProgressHUD dismiss];
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [delegate logOutUserInfo];
//        }else{
//            [ProgressHUD showError:@"加载失败,请确认网络通畅"];
//        }
//        
//    } error:^(NSError *error) {
//        [ProgressHUD showError:@"加载失败,请确认网络通畅"];
//    }];
    
}


#pragma mark - 获取默认数据
/** 这个是获取的是用户数据,所以与高尔夫预约控制器的获取数据请求是同一个 */
- (void)loadUserInData {
//    [[RequestManger Instance] loadGolfBookViewDataSuccess:^(id requestEncode) {
//        NSDictionary *dict = requestEncode;
//        
//        if ([dict[@"code"] isEqualToString:@"0000"]) {
//            NSDictionary *dataDict = dict[@"data"];
//            
//            // 设置默认信息
//            self.personField.text = [NSString stringWithFormat:@"%@", dataDict[@"userName"]];
//            self.phoneField.text = [NSString stringWithFormat:@"%@", dataDict[@"userMobile"]];
//            
//        }else if([dict[@"code"] isEqualToString:@"9999"]){
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [delegate logOutUserInfo];
//        }else{
//            [ProgressHUD showError:[NSString stringWithFormat:@"%@",dict[@"msg"]]];
//        }
//
//    } error:^(NSError *error) {
//        [ProgressHUD showError:@"加载失败,请确认网络通畅"];
//    }];
}



#pragma mark - 点击视图的时候结束编辑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 设置界面元素
- (void)setupUI {
    self.title = @"邮轮预约";
    self.view.backgroundColor =   [UIColor colorWithRed:0.950 green:0.950 blue:0.970 alpha:1.000];
    
    // 预约人
    UITextField *personField = [self createLineNoArrowWithRect:CGRectMake(0, 74, Width_Window, 50) title:@"预约人"];
    personField.placeholder = @"请输入预约人";
    [self.view addSubview:personField];
    
    // 预约电话
    UITextField *phoneField = [self createLineNoArrowWithRect:CGRectMake(0, personField.bottom + 1, Width_Window, 50) title:@"联系电话"];
    phoneField.placeholder = @"请输入联系电话";
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneField];
    
    // 添加预约按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"提交预约" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(10, self.view.bottom - 54, Width_Window - 20, 44);
    [button addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // 记录
    _personField = personField;
    _phoneField = phoneField;
}

#pragma mark - 返回传入参数创建好的TextField
/** 没有箭头 */
- (UITextField *)createLineNoArrowWithRect:(CGRect)rect title:(NSString *)title {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.backgroundColor = [UIColor whiteColor];
    //    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor lightGrayColor];
    textField.textAlignment = NSTextAlignmentRight;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 50)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 75, 50)];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor darkGrayColor];
    nameLabel.text = [NSString stringWithFormat:@"%@",title];
    [leftView addSubview:nameLabel];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    
    return textField;
}



@end
