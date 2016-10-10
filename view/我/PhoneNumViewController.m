//
//  PhoneNumViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PhoneNumViewController.h"
#import "UIViewController+MBShow.h"
#import "GetCodeViewController.h"

@interface PhoneNumViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation PhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.title = @"手机绑定";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextStep:) name:@"nextStep" object:nil];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextStep:(id)sender

{
    if (self.phoneNumberTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入您要绑定的手机号"];
        return;
        
    }
    if (![self.phoneNumberTextField.text isTelephone]) {
        [self showToastWithMessage:@"请输入正确格式的手机号"];
        return;
    }
    
    NSLog(@"你点击了下一步");
    NSString *path = @"/app.php/Verify/index";
    NSDictionary *params = @{
                             @"tel":self.phoneNumberTextField.text,
                             @"type":@"3",
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        [self showToastWithMessage:msg];
        GetCodeViewController *getCodeVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"GetCodeViewController"];
        getCodeVC.numPhone = self.phoneNumberTextField.text;
        [self.navigationController pushViewController:getCodeVC animated:YES];
        
        
        
        
    } fail:^(NSString *error) {
        [self showToastWithMessage:@"发送失败"];
    }];
}


@end
