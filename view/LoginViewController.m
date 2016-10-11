//
//  LoginViewController.m
//  wanhucang
//
//  Created by 郝志宇 on 16/1/27.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPasswordViewController.h"
#import "UserInfoModel.h"
#import "ShareModel.h"
#define wechatTag 0
#define QQTag 1
#define sinaTag 2

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString *number;
    NSString *password;
    
}
@property (nonatomic, assign)NSInteger dengLuType;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back)];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    self.table.backgroundColor = RGB(234, 234, 234);
    
    
    number = kTel;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 230)];
    view.backgroundColor = self.table.backgroundColor;
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.layer.cornerRadius = 3.f;
    login.layer.masksToBounds = YES;
    login.backgroundColor = KAPPCOLOR;
    login.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    login.titleLabel.font = [UIFont systemFontOfSize:16];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setTitle:@"登 录" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    login.center = CGPointMake(view.width/2, login.height/2+15);
    [view addSubview:login];
    
    UILabel *registe = [[UILabel alloc] initWithFrame:CGRectMake(login.x, login.bottom + 10, 100, 45)];
    registe.userInteractionEnabled = YES;
    registe.textAlignment = NSTextAlignmentLeft;
    registe.font = [UIFont systemFontOfSize:16];
    registe.text = @"立即注册";
    registe.textColor = [UIColor grayColor];
    [view addSubview:registe];
    
    UITapGestureRecognizer *registeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerAction:)];
    [registe addGestureRecognizer:registeTap];
    
    UILabel *findPassword = [[UILabel alloc] initWithFrame:CGRectMake(login.x, login.bottom + 10, 100, 45)];
    findPassword.userInteractionEnabled = YES;
    findPassword.textAlignment = NSTextAlignmentRight;
    findPassword.font = [UIFont systemFontOfSize:16];
    findPassword.text = @"忘记密码";
    findPassword.textColor = [UIColor grayColor];
    [view addSubview:findPassword];
    findPassword.right = login.right;
    
    UITapGestureRecognizer *findPasswordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPasswordAction:)];
    [findPassword addGestureRecognizer:findPasswordTap];
    
    self.table.tableFooterView = view;
    
    self.table.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    
    CGFloat itmeWidth = 55;
    CGRect rect = CGRectMake(0, KSCREENHEIGHT-itmeWidth-120, itmeWidth, itmeWidth);
    CGFloat x = (KSCREENWIDTH - itmeWidth * 3) / 4;
    
    UIButton *wechat = [UIButton buttonWithType:UIButtonTypeCustom];
    wechat.frame = rect;
    wechat.tag = 0;
    [wechat setImage:[UIImage imageNamed:@"shareSina"] forState:UIControlStateNormal];
    //    [wechat setTitle:@"微信" forState:UIControlStateNormal];
    //    [wechat setBackgroundColor:[UIColor orangeColor]];
    [wechat addTarget:self action:@selector(otherLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.table addSubview:wechat];
    
    UIButton *qq = [UIButton buttonWithType:UIButtonTypeCustom];
    qq.frame = rect;
    qq.tag = 1;
    [qq setImage:[UIImage imageNamed:@"shareQQ"] forState:UIControlStateNormal];
    //    [qq setTitle:@"ＱＱ" forState:UIControlStateNormal];
    //    [qq setBackgroundColor:[UIColor orangeColor]];
    [qq addTarget:self action:@selector(otherLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.table addSubview:qq];
    
    UIButton *sina = [UIButton buttonWithType:UIButtonTypeCustom];
    sina.frame = rect;
    sina.tag = 2;
    [sina setImage:[UIImage imageNamed:@"shareWeiChat"] forState:UIControlStateNormal];

    [sina addTarget:self action:@selector(otherLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.table addSubview:sina];
    
    sina.x = x;
    qq.x = sina.right + x;
    wechat.x = qq.right + x;;
    
    UILabel *sanfang = [[UILabel alloc] initWithFrame:CGRectMake(0, login.bottom + 100, KSCREENWIDTH, 40)];
    sanfang.textColor = [UIColor darkGrayColor];
    sanfang.font = [UIFont systemFontOfSize:16];
    sanfang.text = @"其它方式登录";
    sanfang.textAlignment = NSTextAlignmentCenter;
    [self.table addSubview:sanfang];
    
    sanfang.bottom = qq.top - 20;
    
}



#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat x = cell.separatorInset.left;
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 50)];
    textView.borderStyle = UITextBorderStyleNone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addTarget:self action:@selector(textBeainEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textView addTarget:self action:@selector(textEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    textView.tag = indexPath.row;
    if (indexPath.row==0) {
        textView.placeholder = @"请输入您的手机号";
        textView.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"C-9-3"]];
        textView.leftViewMode = UITextFieldViewModeAlways;
        textView.text = kTel;
        textView.keyboardType = UIKeyboardTypePhonePad;
        [cell.contentView addSubview:textView];
    }
    if (indexPath.row==1) {
        textView.placeholder = @"请输入您的密码";
        textView.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"C-10-3"]];
        textView.leftViewMode = UITextFieldViewModeAlways;
        textView.text = password;
        textView.keyboardType = UIKeyboardTypeAlphabet;
        textView.secureTextEntry = YES;
        [cell.contentView addSubview:textView];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)otherLoginAction:(UIButton *)btn {
    
    
    NSInteger  loginType =  btn.tag;
  
    
    
    [ShareModel loginWitnUMengWithVC:self withIndex:loginType success:^(UMSocialAccountEntity *snsAccount) {
        
        NSString * token =@"";
        NSString * userName= checkNULL(snsAccount.userName);
        NSString * iconURL= checkNULL(snsAccount.iconURL);
        
        NSInteger type = 1;
        
        
        
        if (loginType == 0) {
            token =checkNULL(snsAccount.usid);
            type = 3;
        }
        if (loginType == 1) {
            token = checkNULL(snsAccount.usid);
            type = 2;
        }
        if (loginType == 2) {
            token = checkNULL(snsAccount.unionId);
            type = 1;
        }
        //    post:/app.php/User/do_login
        //        token#三方登录唯一标识 token
        //        nike#昵称
        //        image#头像
        
        NSDictionary *params =@{@"token":token,@"nike":userName,@"image":iconURL,@"type":[NSString stringWithFormat:@"%ld",(long)type]};
        [MCNetTool postWithUrl:@"/app.php/User/do_login" params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
            
            
            
            UserInfoModel * userInfoModel = [UserInfoModel yy_modelWithJSON:requestDic];
            
            [UserManager archiverModel:userInfoModel];
            
            [UserModel postNotification:UserModel.LOGIN];

            [Tool performBlock:^{
                [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
            } afterDelay:1];
            
            
            
        } fail:^(NSString *error) {
            
        }];
        
        
        //        [userModel app_php_user_do_loginWithToken:snsAccount.usid];
        
        
        
        
        
        
    } failure:^(NSString *error) {
        
    } ];
    

}

- (void)loginAction:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (number.length==0) {
        [self presentMessageTips:@"请输入手机号"];
        return;
    }
    if (![number isTelephone]) {
        [self presentMessageTips:@"请输入正确的手机号"];
        return;
    }
    if (password.length==0) {
        [self presentMessageTips:@"请输入密码"];
        return;
    }
    if (password.length<6) {
        [self presentMessageTips:@"密码长度须6-16位"];
        return;
    }
    
    
    [MCNetTool postWithUrl:@"/app.php/User/login" params:@{@"tel":number,@"pass":password} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        [self showToastWithMessage:msg];
        
        UserInfoModel * userInfoModel = [UserInfoModel yy_modelWithJSON:requestDic];
        
        [UserManager archiverModel:userInfoModel];
        
        [UserModel postNotification:UserModel.LOGIN];

        [Tool performBlock:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        } afterDelay:1];
        
    } fail:^(NSString *error) {
        [self showToastWithMessage:@"登录失败"];
    }];
    
    
    
}

- (void)registerAction:(UIGestureRecognizer *)tap {
    [self.view endEditing:YES];
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)findPasswordAction:(UIGestureRecognizer *)tap {
    [self.view endEditing:YES];
    
    FindPasswordViewController *vc = [[FindPasswordViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 0) {
        //手机号
        if (textView.text.length>11) {
            textView.text = [textView.text substringToIndex:11];
        }
        number = textView.text;
    } else if (textView.tag == 1) {
        //密码
        if (textView.text.length>16) {
            textView.text = [textView.text substringToIndex:16];
        }
        password = textView.text;
    }
}

- (void)back {
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
