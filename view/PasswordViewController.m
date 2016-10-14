//
//  PasswordViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/8.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString *passwordone;
    NSString *passwordtwo;
    
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"密码设置";
    self.table.backgroundColor = RGB(234, 234, 234);
    
    userModel = [UserModel modelWithObserver:self];
    [self observeNotification:userModel.REGISTER];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 230)];
    view.backgroundColor = self.table.backgroundColor;
    UIButton *reg = [UIButton buttonWithType:UIButtonTypeCustom];
    reg.layer.cornerRadius = 3.f;
    reg.layer.masksToBounds = YES;
    reg.backgroundColor = KAPPCOLOR;
    reg.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    reg.titleLabel.font = [UIFont systemFontOfSize:16];
    [reg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reg setTitle:@"注 册" forState:UIControlStateNormal];
    [reg addTarget:self action:@selector(regAction:) forControlEvents:UIControlEventTouchUpInside];
    reg.center = CGPointMake(view.width/2, reg.height/2+15);
    [view addSubview:reg];
    
    self.table.tableFooterView = view;
    
    self.table.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

ON_NOTIFICATION3(UserModel, REGISTER, notification) {
    [Tool performBlock:^{
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    } afterDelay:1];
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
        textView.placeholder = @"输入6-16位数字或字母";
        textView.text = passwordone;
        textView.keyboardType = UIKeyboardTypeAlphabet;
        textView.secureTextEntry = YES;
        [cell.contentView addSubview:textView];
    }
    if (indexPath.row==1) {
        textView.placeholder = @"确认密码";
        textView.text = passwordtwo;
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

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 0) {
        if (textView.text.length>16) {
            textView.text = [textView.text substringToIndex:16];
        }
        passwordone = textView.text;
    } else if (textView.tag == 1) {
        if (textView.text.length>16) {
            textView.text = [textView.text substringToIndex:16];
        }
        passwordtwo = textView.text;
    }
}

- (void)regAction:(UIButton *)btn {
    [self.view endEditing:YES];

    if (passwordone.length==0) {
        [self presentMessageTips:@"密码不能为空"];
        return;
    }
    if (passwordtwo.length==0) {
        [self presentMessageTips:@"确认密码"];
        return;
    }
    if (passwordone.length<6) {
        [self presentMessageTips:@"输入6-16位数字或字母"];
        return;
    }
    if (![passwordone isEqualToString:passwordtwo]) {
        [self presentMessageTips:@"两次密码不一致"];
        return;
    }
    if (![passwordone isPassword]) {
        [self presentMessageTips:@"密码格式不正确"];
        return;
    }
    [userModel registerWithPhone:self.number code:self.verification pass:passwordone];
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
