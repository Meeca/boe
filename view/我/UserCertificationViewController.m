//
//  UserCertificationViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "UserCertificationViewController.h"
#import "LTPickerView.h"
#import "UserCertificationUploadPhotoViewController.h"
#import "UIViewController+MBShow.h"
#import "UserCertificition.h"

@interface UserCertificationViewController (){
    
    UserCertificition *userCertificition;
    
}
@property (weak, nonatomic) IBOutlet UILabel *personMessageLabel;
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personNum;

@property (weak, nonatomic) IBOutlet UITextField *personPhoneNum;
@end

@implementation UserCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize titleSize =self.navigationController.navigationBar.bounds.size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleSize.width/2,titleSize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18 weight:21];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=@"用户认证";
    self.navigationItem.titleView = label;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self loadUserMessage];
    if ([_authonNew integerValue] == 3) {
        [self loadUserMessage];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)choose:(id)sender {
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"身份证"];//设置要显示的数据
    pickerView.defaultStr = @"身份证";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        NSLog(@"选择了第%d行的%@",num,str);
        
        self.personMessageLabel.text = str;
    };
    
}

#pragma mark --------  请求认证详情接口



- (void)loadUserMessage
{
    
    NSString *parth = @"/app.php/User/authen_read";
    NSDictionary *params = @{
                             @"a_id":_authonID
                             };
    [MCNetTool postWithUrl:parth params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         userCertificition = [UserCertificition yy_modelWithJSON:requestDic];
         //         [self showToastWithMessage:msg];
         [self viewFuzhi];
         
     }
                      fail:^(NSString *error) {
                          
                      }];
    
}


- (void)viewFuzhi
{
    //    "a_id": "1",                    //作品id
    //    "uid": "1",         //用户id
    //    "type": "1",            //证件类型
    //    "order_code": "300",              //证件号码
    //    "name": "2",      //证件姓名
    //    "tel": "2016-05-30",     //手机号码
    //    "order_image": "1",            //证件照，（正反面，用 - 拼接，正面照在前面）
    //    "content": "不合格",     //不通过原因
    //    "state": "1",     //审核状态（1待审核，2通过，3不通过）
    
    _personMessageLabel.text = @"身份证";
    _personName.text =userCertificition.name;
    _personPhoneNum.text = userCertificition.tel;
    _personNum.text = userCertificition.order_code;
    
    
}

- (IBAction)nextStep:(id)sender {
    if ([_authonNew integerValue]== 3) {
        
        UserCertificationUploadPhotoViewController *userVC = [[UIStoryboard storyboardWithName:@"UserCertification" bundle:nil] instantiateViewControllerWithIdentifier:@"UserCertificationUploadPhotoViewController"];
        [self.navigationController pushViewController:userVC animated:YES];
    }
    
    
    else
    {
    
    
        if (_personMessageLabel.text.length == 0) {
            [self showToastWithMessage:@"请选择证件类型"];
            return;
            
        }
        if (_personName.text.length == 0) {
            [self showToastWithMessage:@"请输入证件姓名"];
            return;
        }
        if (_personNum.text.length == 0) {
            [self showToastWithMessage:@"请输入证件号码"];
            return;
        }
        if (_personPhoneNum.text.length == 0) {
            [self showToastWithMessage:@"请输入手机号码"];
            return;
        }
        
        
        UserCertificationUploadPhotoViewController *userVC = [[UIStoryboard storyboardWithName:@"UserCertification" bundle:nil] instantiateViewControllerWithIdentifier:@"UserCertificationUploadPhotoViewController"];
        
        userVC.paperType =_personMessageLabel.text;
        userVC.paperName = _personName.text;
        userVC.paperNum = _personPhoneNum.text;
        userVC.paperPhoneNum = _personPhoneNum.text;
        
        [self.navigationController pushViewController:userVC animated:YES];
    
    
    }
    NSLog(@"你点击了下一步");
    
}



//@"uid":kUserId,
//@"type":_personMessageLabel.text,
//@"order_code":_personNum.text,
//@"name":_personName.text,
//@"tel":_personPhoneNum.text,
//@"order_image":@"",


@end
