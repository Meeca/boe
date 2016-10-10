//
//  ChangePasswordViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MCHttp.h"
#import "SuccessChangePasswordViewController.h"
#import "UIViewController+MBShow.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>{
    UserModel *userModel;
}
@property (weak, nonatomic) IBOutlet UITextField *originalPasswordTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------------//修改密码点击下一步
- (IBAction)nextStep:(id)sender
{
    if (self.originalPasswordTextFeild.text.length == 0) {
        [self showToastWithMessage:@"请输入原始密码"];
        return;
    }
    if (self.passwordNew.text.length < 6) {
        [self showToastWithMessage:@"输入新密码，6-16位数字或字母"];
        return;
    }
    
    if (self.passwordNew.text.length > 16)
    {
        [self showToastWithMessage:@"密码格式不正确"];
        return;
    }
    
    if (![self.confirmPasswordTextField.text isEqualToString:self.passwordNew.text])
    {
        [self showToastWithMessage:@"两次密码不一致"];
        [self.confirmPasswordTextField becomeFirstResponder];
        return;
    }


    
    
    NSString *path =@"/app.php/User/user_pass";
    NSDictionary *params = @{
                             @"uid":kUserId,
                             @"nike":kNike,
                             @"re_pass":self.originalPasswordTextFeild.text,
                             @"ne_pass":self.passwordNew.text,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         SuccessChangePasswordViewController *successVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"SuccessChangePasswordViewController"];
         [self.navigationController pushViewController:successVC animated:YES];
         
         NSLog(@"_________修改成功");
         [self showToastWithMessage:msg];
         
     } fail:^(NSString *error) {
         
         [self showToastWithMessage:@"原密码不正确"];
         
         
         
     }];
}

- (BOOL)isTelephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}



@end
