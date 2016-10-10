//
//  PasswordSettingViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PasswordSettingViewController.h"
#import "UIViewController+MBShow.h"
#import "SettingsViewController.h"

@interface PasswordSettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *againPassWord;

@end

@implementation PasswordSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"手机绑定";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPasswordNetData
{
//post:/app.php/User/binding
//    uid#用户id
//    tel#手机号
//    code#验证码
//    pass#密码
NSString *path = @"/app.php/User/binding";
    NSDictionary *params = @{
                             
                             @"uid":kUserId,
                             @"tel":self.tel,
                             @"code":self.code,
                             @"pass":self.passwordTextFeild.text,
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        [self showToastWithMessage:msg];
        
        SettingsViewController *settingVC = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
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
        


        
    } fail:^(NSString *error) {
        
    }];


}
- (IBAction)nextStep:(id)sender
{
    NSLog(@"你点击了下一步");
    if (_passwordTextFeild.text.length == 0) {
        [self showToastWithMessage:@"请输入密码"];
        return;
    } else if (_passwordTextFeild.text.length < 6 || _passwordTextFeild.text.length > 16) {
        [self showToastWithMessage:@"请输入6〜16的密码"];
        return;
    } else if (_againPassWord.text.length == 0) {
        [self showToastWithMessage:@"请再次输入密码"];
        return;
    } else if (![_passwordTextFeild.text isEqualToString:_againPassWord.text]) {
        [self showToastWithMessage:@"前后输入密码不一致"];
        return;
    }
    [self loadPasswordNetData];
}

@end
