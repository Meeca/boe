//
//  CreatCircleTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CreatCircleTableViewController.h"
#import "MCHttp.h"
#import "JDFCircleModel.h"
#import "MBProgressHUD+Add.h"
#import "UIViewController+MBShow.h"

@interface CreatCircleTableViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL _isPrivate;
}
@property (weak, nonatomic) IBOutlet UITextField *circleTexiField;
@property (weak, nonatomic) IBOutlet UIButton *publicButton;
@property (weak, nonatomic) IBOutlet UIButton *encryptionButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *passwordMaybeHidde;
@property (weak, nonatomic) IBOutlet UITableViewCell *passwordMaybeHidde2;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordtextField;

@property (weak, nonatomic) IBOutlet UITextField *introductionTextField;
@end

@implementation CreatCircleTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    [Tool setBackButtonNoTitle:self];
    
    
    
    
    
    
    if(_type == 1){
        self.navigationItem.title = @"新建一个圈儿";
        _isPrivate = YES;
        
    }else{
        self.navigationItem.title = @"修改圈儿属性";
        
        
        NSInteger  attribute = [_attribute integerValue];
        
        if(attribute == 1){//gongkai
            
            _isPrivate = NO;
            
        }else{
            
            // siyou
            
            _isPrivate = YES;
            
        }
        
        
        
        
        if (!_isPrivate ) {
            
            
            [self.encryptionButton setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
            [self.publicButton setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
            //            self.passwordtextField.text = _againPassword;
            self.circleTexiField.text = _name;
            self.introductionTextField.text = _product;
            //            self.confirmPasswordtextField.text = _againPassword;
            
        }
        else{
            self.passwordtextField.text = _againPassword;
            self.circleTexiField.text = _name;
            self.introductionTextField.text = _product;
            self.confirmPasswordtextField.text = _againPassword;
            
        }
        
        
    }
    
    
    self.tableView.separatorStyle = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
}


- (void)endEditing
{
    [self.view endEditing:YES];
}


- (IBAction)publicClickButton:(id)sender
{
    _isPrivate = NO;
    
    [self.encryptionButton setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
    [self.publicButton setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
    
    
    
    [self.tableView reloadData];
}
- (IBAction)encryptionButtonClick:(id)sender
{
    _isPrivate = YES;
    [self.tableView reloadData];
    [self.encryptionButton setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
    [self.publicButton setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
    
}
- (IBAction)submitClickButton:(id)sender
{
    NSLog(@"你点击了提交按钮");
    
    [self loadCreatCircleData];
}


//加载网络数据
- (void)loadCreatCircleData
{
    if (_isPrivate) {
        if(self.circleTexiField.text.length == 0)
        {
            [self showToastWithMessage:@"请输入名称"];
            [self.circleTexiField becomeFirstResponder];
            return;
            
        }
        if(self.passwordtextField.text.length < 6)
        {
            [self showToastWithMessage:@"密码位数不能少于6位"];
            [self.passwordtextField becomeFirstResponder];
            return;
        }
        
        if (self.passwordtextField.text.length < 6)
        {
            [self showToastWithMessage:@"密码格式不正确"];
            return;
        }
        
        if (self.passwordtextField.text.length > 50)
        {
            [self showToastWithMessage:@"密码格式不正确"];
            [self.circleTexiField becomeFirstResponder];
            return;
        }
        
        if (![self.confirmPasswordtextField.text isEqualToString:self.passwordtextField.text])
        {
            [self showToastWithMessage:@"两次密码不一致"];
            [self.confirmPasswordtextField becomeFirstResponder];
            return;
        }
        if (self.introductionTextField.text.length == 0) {
            [self showToastWithMessage:@"请输入简介"];
            [self.introductionTextField becomeFirstResponder];
            return;
        }
        
    }
    else
    {
        if(self.circleTexiField.text.length == 0)
        {
            //            [self showToastWithMessage:@"请输入名称"];
            [MBProgressHUD showMessage:@"请输入名称" toView:self.view];
            [self.circleTexiField becomeFirstResponder];
            
        }
        if (self.introductionTextField.text.length < 1) {
            [MBProgressHUD showMessag:@"请输入简介" toView:self.view];
        }
        
        
    }
    
    
    
    
    if (_type == 1) {
        //创建一个圈儿
        [self createQuan];
    }else{
        //修改一个圈儿
        [self changeQuan];
    }
}
#pragma mark - 新建一个圈儿
- (void)createQuan{


    NSString *path = @"/app.php/Circles/add";
    NSDictionary *params = @{
                             @"c_id" : @"",
                             @"u_id" : kUserId,
                             @"title" : self.circleTexiField.text,
                             @"attributes" : _isPrivate ? @"2" : @"1",
                             @"pass" : self.passwordtextField.text,
                             @"image" : kImage,
                             @"content":self.introductionTextField.text,
                             };
    [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         [self showToastWithMessage:@"圈子创建成功"];
         
        
         [self.navigationController popViewControllerAnimated:YES];
     }
                      failure:^(NSString *error) {
                          
                      }];
}



#pragma mark - 修改一个圈儿
- (void)changeQuan{
    
    
    NSString *path = @"/app.php/Circles/add";
    NSDictionary *params = @{
                             @"c_id" : _c_id,
                             @"u_id" : kUserId,
                             @"title" : self.circleTexiField.text,
                             @"attributes" : _isPrivate ? @"2" : @"1",
                             @"pass" : self.passwordtextField.text,
                             @"image" : kImage,
                             @"content":self.introductionTextField.text,
                             };
    [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         //         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
         //                        {
         //                            [self.navigationController popViewControllerAnimated:YES];
         //                        });
         [self.navigationController popViewControllerAnimated:YES];
     }
                      failure:^(NSString *error) {
                          
                      }];
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isPrivate)
    {
        return 6;
    }
    else
    {
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isPrivate)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        if (indexPath.row > 1)
        {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 2 inSection:indexPath.section];
            
            return [super tableView:tableView cellForRowAtIndexPath:newIndexPath];
        }
        else
            
        {
            return [super tableView:tableView cellForRowAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    //其他代码
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 5) {
    //        return 100;
    //
    //    }
    //    else
    //    {
    //        return 60;
    //
    //    }
    if (_isPrivate)
    {
        if (indexPath.row == 5) {
            return 100;
            
        }
        else
        {
            return 60;
            
        }
        
    }
    else{
        
        if (indexPath.row == 3) {
            return 100;
        }
        else
        {
            
            return 60;
        }
    }
    
    
}



@end
