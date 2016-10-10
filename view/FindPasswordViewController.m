//
//  FindPasswordViewController.m
//  wanhucang
//
//  Created by 郝志宇 on 16/1/27.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "FindPasswordTwoVCtrl.h"

@interface FindPasswordViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString *number;

    UserModel *userModel;
}

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    
    self.table.backgroundColor = RGB(234, 234, 234);
    userModel = [UserModel modelWithObserver:self];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 130)];
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.backgroundColor = KAPPCOLOR;
    submit.layer.cornerRadius = 3.f;
    submit.layer.masksToBounds = YES;
    submit.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    submit.titleLabel.font = [UIFont systemFontOfSize:16];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"下一步" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    submit.center = CGPointMake(view.width/2, submit.height/2+20);
    [view addSubview:submit];
    self.table.tableFooterView = view;
    
    self.table.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

ON_SIGNAL3(UserModel, VERIFYCODE, signal) {
    FindPasswordTwoVCtrl *vc = [[FindPasswordTwoVCtrl alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.number = number;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 50)];
    textView.borderStyle = UITextBorderStyleNone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addTarget:self action:@selector(textBeainEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textView addTarget:self action:@selector(textEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    textView.tag = indexPath.row;
    if (indexPath.row==0) {
        cell.backgroundColor = tableView.backgroundColor;
        cell.textLabel.text = @"请输入您的注册手机号";
    }
    if (indexPath.row==1) {
        textView.placeholder = @"请输入手机号";
        textView.text = number;
        textView.keyboardType = UIKeyboardTypePhonePad;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 40;
    }
    return 50;
}

- (void)submitAction:(UIButton *)btn {
    [self.view endEditing:YES];
    if (number.length==0) {
        [self presentMessageTips:@"请输入手机号"];
        return;
    }
    if (![number isTelephone]) {
        [self presentMessageTips:@"请输入正确的手机号"];
        return;
    }
    
    [userModel getVerifyWithPhone:number type:@"2"];
}

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 1) {
        //手机号
        if (textView.text.length>11) {
            textView.text = [textView.text substringToIndex:11];
        }
        number = textView.text;
    }
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
