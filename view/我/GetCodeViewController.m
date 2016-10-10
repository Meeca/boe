//
//  GetCodeViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "GetCodeViewController.h"
#import "SettingsViewController.h"
#import "PasswordSettingViewController.h"

@interface GetCodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *numberInput;
@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation GetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机绑定";
    [self loadNet];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.phoneNum.text = self.numPhone;
}
#pragma mark ------再次获取
- (IBAction)againGet:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"nextStep" object:nil];
   
    
    BOOL flag = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.navigationController.viewControllers.count - 1; i ++)
    {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if (flag == NO && [vc isKindOfClass:[SettingsViewController class]])
        {
            flag = YES;
        }
        
        if (flag)
        {
            [array addObject:vc];
        }
        
    }
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers removeObjectsInArray:array];
    
    self.navigationController.viewControllers = viewControllers;
}
- (void)loadNet
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTask:) userInfo:nil repeats:YES];
    
    [self.codeButton setTitle:@"60s后重发"forState:UIControlStateNormal];
    
}
- (void)timerTask:(NSTimer *)timer
{
    static int count = 60;
    count --;
    
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ds后重发",count] forState:UIControlStateNormal];
    self.codeButton.enabled = NO;
    
    if (count == 0)
    {
        [timer invalidate];
        
        self.codeButton.userInteractionEnabled = YES;
        
        [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        
        count = 60;
        self.codeButton.enabled = YES;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
}

#pragma mark ---------确认请求接口
- (IBAction)confirmClickBtn:(id)sender
{
    //成功的时候放到请求成功数据中
    
    NSString *path = @"/app.php/User/codecation";
    NSDictionary *params = @{
                             @"tel" : self.numPhone,
                             @"code" : self.numberInput.text
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
    {
        PasswordSettingViewController *passwordSetVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"PasswordSettingViewController"];
        passwordSetVC.code = self.numberInput.text;
        passwordSetVC.tel = self.numPhone;
        [self.navigationController pushViewController:passwordSetVC animated:YES];
        
        
    } fail:^(NSString *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
