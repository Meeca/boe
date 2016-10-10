//
//  ChangeDeviceNameViewController.m
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ChangeDeviceNameViewController.h"



@interface ChangeDeviceNameViewController (){

    NSString * _deviceName;


}
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;

@end

@implementation ChangeDeviceNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"修改设备名称";
    
    _deviceName = @"";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确认" target:self action:@selector(leftItemAction:)];
    
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    _nameTextFiled.leftView = leftView;
    _nameTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    _nameTextFiled.text = _name;
    
    [_nameTextFiled addTarget:self action:@selector(nameTextFiledChangeValueAction:) forControlEvents:UIControlEventEditingChanged];
    
    
    // Do any additional setup after loading the view from its nib.
}

/*
 
 
 get:/app.php/User/equipment_edit
 uid#用户id
 e_id#设备id
 title#设备名称
 l_time#轮播时间
 s_time#开机时间
 e_time#关机时间
 push_type#是否接收官方推送（1接收，2不接收）
 返回值：
 
 
 
 
 
 */


- (void)leftItemAction:(UIBarButtonItem *)item{
    
    
    if (_deviceName.length == 0) {
        
        [self showToastWithMessage:@"请输入设备名称"];
        
        return;
    }
    
    
    
    [MCNetTool  postWithUrl:@"/app.php/User/equipment_edit" params:@{@"uid":kUserId,@"e_id":_e_id,@"title":_deviceName} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        if (_changeDeviceNameBlock) {
            _changeDeviceNameBlock(_deviceName);
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } fail:^(NSString *error) {
        
        
        [self showToastWithMessage:@"修改设备名称失败"];
        
    }];



}




- (void)nameTextFiledChangeValueAction:(UITextField *)textField{

    NSString * text = textField.text;

    _deviceName = text;
    
    
    
    



}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
