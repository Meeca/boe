//
//  RegisterViewController.m
//  wanhucang
//
//  Created by 郝志宇 on 16/1/27.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTwoViewController.h"
#import "NIWebController.h"

@interface RegisterViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString *number;
    
    BOOL isSel;
    
    UserModel *userModel;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手机注册";
    
    userModel = [UserModel modelWithObserver:self];
    
    isSel = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 150)];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.font = [UIFont systemFontOfSize:15];
    msg.text = @"为了安全，我们会向您的手机发送验证码";
    msg.textColor = [UIColor grayColor];
    [msg sizeToFit];
    msg.y = 15;
    [view addSubview:msg];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.backgroundColor = KAPPCOLOR;
    submit.layer.cornerRadius = 3.f;
    submit.layer.masksToBounds = YES;
    submit.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    submit.titleLabel.font = [UIFont systemFontOfSize:16];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"下一步" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    submit.center = CGPointMake(view.width/2, submit.height/2);
    submit.y = msg.bottom + 20;
    msg.x = submit.x;
    [view addSubview:submit];
    
    UIButton *sel = [UIButton buttonWithType:UIButtonTypeCustom];
    sel.frame = CGRectMake(submit.x, submit.bottom, 25, 50);
    [sel setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateSelected];
    [sel setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
    [sel addTarget:self action:@selector(selProtocol:) forControlEvents:UIControlEventTouchUpInside];
    sel.selected = isSel;
    
    [view addSubview:sel];
    
    UILabel *read = [[UILabel alloc] initWithFrame:CGRectZero];
    read.font = [UIFont systemFontOfSize:14];
    read.text = @"本人已阅读并同意";
    read.textColor = [UIColor grayColor];
    [read sizeToFit];
    [view addSubview:read];
    
    UILabel *protocol = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 45)];
    protocol.font = [UIFont systemFontOfSize:15];
    protocol.userInteractionEnabled = YES;
    protocol.text = @" 注册协议 ";
    [protocol sizeToFit];
    read.centerY = sel.centerY;
    protocol.bottom = read.bottom;
    read.left = sel.right+5;
    protocol.left = read.right;
    
    NSMutableAttributedString *lineText = [[NSMutableAttributedString alloc] initWithString:protocol.text];
    [lineText addAttribute:NSForegroundColorAttributeName value:KAPPCOLOR range:NSMakeRange(0, lineText.length)];
    protocol.attributedText = lineText;
    [view addSubview:protocol];
    
    UITapGestureRecognizer *protocolTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolAction:)];
    [protocol addGestureRecognizer:protocolTap];
    
    self.table.tableFooterView = view;
    
    self.table.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.table.backgroundColor = RGB(234, 234, 234);
}

ON_SIGNAL3(UserModel, VERIFYCODE, signal) {
    RegisterTwoViewController *vc = [[RegisterTwoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.number = number;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 50)];
    textView.borderStyle = UITextBorderStyleNone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addTarget:self action:@selector(textBeainEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textView addTarget:self action:@selector(textEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    textView.tag = indexPath.row;
    if (indexPath.row==0) {
        textView.placeholder = @"输入您的手机号";
        textView.text = number;
        textView.keyboardType = UIKeyboardTypePhonePad;
        textView.leftViewMode = UITextFieldViewModeAlways;
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectZero];
        left.text = @"+86";
        left.font = [UIFont boldSystemFontOfSize:15];
        [left sizeToFit];
        left.width += 5;
        textView.leftView = left;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)protocolAction:(UIGestureRecognizer *)tap {
    NIWebController *vc = [[NIWebController alloc] initWithURL:[NSURL URLWithString:[[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/user/agreement"]]];
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selProtocol:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    isSel = btn.isSelected;
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
    if (!isSel) {
        [self presentMessageTips:@"请阅读注册协议"];
        return;
    }
    
    [userModel getVerifyWithPhone:number type:@"1"];
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
