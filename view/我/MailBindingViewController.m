//
//  MailBindingViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MailBindingViewController.h"
#import "UIViewController+MBShow.h"
#import "SettingsViewController.h"

@interface MailBindingViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mainInput;

@end

@implementation MailBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邮箱绑定";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES ];

}
- (IBAction)nextStep:(id)sender
{
    [self loadNetData];
}
- (void)loadNetData
{
    if (self.mainInput.text.length == 0) {
        [self showToastWithMessage:@"请输入邮箱"];
        return;
    }
    if (![self.mainInput.text isEmail]) {
        [self showToastWithMessage:@"请输入正确的邮箱"];
        return;
    }
    NSString *path = @"/app.php/User/email";
    NSDictionary *params = @{
                             @"uid" : kUserId,
                             @"email" : self.mainInput.text,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self showToastWithMessage:msg];
         UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"邮箱验证" message:@"验证邮件已发送，请查收邮件完成绑定" delegate:self cancelButtonTitle:@"重新发送" otherButtonTitles:@"确认", nil];
         [alterView show];
     }
                      fail:^(NSString *error) {
                          [self showToastWithMessage:@"绑定失败"];
                          
                      }];
    


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(buttonIndex == alertView.cancelButtonIndex)
    {
        NSLog(@"__________重新发送");
        [self loadNetData];
        [self showToastWithMessage:@"已重新发送，请等待"];
        
    }
    else
        
        
        NSLog(@"________确认");
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

    
}



@end
