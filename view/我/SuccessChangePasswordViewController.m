//
//  SuccessChangePasswordViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "SuccessChangePasswordViewController.h"
#import "SettingsViewController.h"
#import "SettingsViewController.h"

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"

@interface SuccessChangePasswordViewController (){
    UserModel *userModel;
}

@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, assign) NSInteger count;

@end

@implementation SuccessChangePasswordViewController

DEF_NOTIFICATION(LOGOUT)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    _count = 3;
    
     [self loadNet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNet
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTask:) userInfo:nil repeats:YES];
    
    
    
}
- (void)timerTask:(NSTimer *)timer
{
    _count --;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld 秒后自动跳转至登录界面",_count];
    if (_count == 0)
    {
        [timer invalidate];
        
//        SettingsViewController *settingVC = [[SettingsViewController alloc] init];
//        [self.navigationController pushViewController:settingVC animated:YES];
//        BOOL flag = NO;
//        
//        NSMutableArray *array = [NSMutableArray array];
//        for (int i = 0; i < self.navigationController.viewControllers.count - 1; i ++)
//        {
//            UIViewController *vc = self.navigationController.viewControllers[i];
//            if (flag == NO && [vc isKindOfClass:[SettingsViewController class]])
//            {
//                flag = YES;
//            }
//            
//            if (flag)
//            {
//                [array addObject:vc];
//            }
//            
//        }
//        
//        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//        [viewControllers removeObjectsInArray:array];
//        
//        self.navigationController.viewControllers = viewControllers;
        [self logOut];
        
        
    }
}


- (void)logOut {
    [userModel loadCache];
    [userModel clearCache];
    
    UserInfoModel * userInfoModel = [[UserInfoModel alloc] init];
    [UserManager archiverModel:userInfoModel];
    
    [self postNotification:self.LOGOUT];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [Tool performBlock:^{
        [self presentViewController:nav animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [Tool performBlock:^{
                appDelegate.ctrl.selectedIndex = 0;
            } afterDelay:.3];
        }];
    } afterDelay:1];
}


@end
