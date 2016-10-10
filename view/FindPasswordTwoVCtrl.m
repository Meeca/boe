//
//  FindPasswordTwoVCtrl.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/13.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FindPasswordTwoVCtrl.h"
#import "TPKeyboardAvoidingTableView.h"

@interface FindPasswordTwoVCtrl () <UITableViewDelegate, UITableViewDataSource> {
    NSString *passwordone;
    NSString *passwordtwo;
    NSString *verification;

    UserModel *userModel;
    
    NSInteger timer;
    
    UILabel *again;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation FindPasswordTwoVCtrl

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
    [submit setTitle:@"完成" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    submit.center = CGPointMake(view.width/2, submit.height/2+20);
    [view addSubview:submit];
    self.table.tableFooterView = view;
    
    self.table.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

}

ON_SIGNAL3(UserModel, PASSWORD, signal) {
    [Tool performBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    } afterDelay:1];
}

ON_SIGNAL3(UserModel, VERIFYCODE, signal) {
    again.userInteractionEnabled = NO;
    timer = 60;
    NSString *title = [NSString stringWithFormat:@"%@s重新发送", @(timer)];
    again.text = title;
    again.textColor = [UIColor grayColor];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDown:) userInfo:again repeats:YES];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, KSCREENWIDTH-2*x, 50)];
    textView.borderStyle = UITextBorderStyleNone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textView.tag = indexPath.row;
    
    if (indexPath.row==0) {
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"已发送短信到："];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:self.number];
        
        [str2 addAttribute:NSForegroundColorAttributeName value:KAPPCOLOR range:NSMakeRange(0, str2.length)];
        [str1 appendAttributedString:str2];
        
        [str1 addAttribute:NSFontAttributeName value:cell.textLabel.font range:NSMakeRange(0, str1.length)];
        cell.textLabel.attributedText = str1;
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==1) {
        cell.textLabel.text = @"请输入接收到的短信验证码";
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==2) {
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 50, 50)];
        view.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        
        again = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 45)];
        again.userInteractionEnabled = YES;
        again.textAlignment = NSTextAlignmentCenter;
        again.font = [UIFont systemFontOfSize:14];
        again.text = @"重新发送";
        again.textColor = KAPPCOLOR;
        again.backgroundColor = tableView.backgroundColor;
        [again sizeToFit];
        again.width += 30;
        again.height = 50;
        
        UITapGestureRecognizer *againTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(againAction:)];
        [again addGestureRecognizer:againTap];
        
        textView.placeholder = @"输入验证码";
        textView.text = verification;
        textView.keyboardType = UIKeyboardTypeNumberPad;
        textView.rightViewMode = UITextFieldViewModeAlways;
        textView.rightView = again;
        textView.backgroundColor = [UIColor whiteColor];
        textView.width -= 40;
        textView.x += 20;
        [cell.contentView addSubview:textView];
        
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==3) {
        cell.textLabel.text = @"新密码";
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==4) {
        textView.placeholder = @"输入6-16位数字或字母";
        textView.text = passwordone;
        textView.keyboardType = UIKeyboardTypeAlphabet;
        textView.secureTextEntry = YES;
        [cell.contentView addSubview:textView];
    } else if (indexPath.row==5) {
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
    if (indexPath.row==0) {
        return 40;
    }
    return 50;
}

- (void)againAction:(UIGestureRecognizer *)tap {
    [self.view endEditing:YES];
    
    [userModel getVerifyWithPhone:self.number type:@"2"];
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 4) {
        if (textView.text.length>16) {
            textView.text = [textView.text substringToIndex:16];
        }
        passwordone = textView.text;
    } else if (textView.tag == 5) {
        if (textView.text.length>16) {
            textView.text = [textView.text substringToIndex:16];
        }
        passwordtwo = textView.text;
    } else if (textView.tag == 2) {
        verification = textView.text;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    again.userInteractionEnabled = NO;
    timer = 60;
    NSString *title = [NSString stringWithFormat:@"%@s重新发送", @(timer)];
    again.text = title;
    again.textColor = [UIColor grayColor];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDown:) userInfo:again repeats:YES];
}

- (void)timerDown:(NSTimer *)time {
    timer--;
    NSString *title = [NSString stringWithFormat:@"%@s重新发送", @(timer)];
    again.text = title;
    again.textColor = [UIColor grayColor];
    again.userInteractionEnabled = NO;
    if (timer == 0) {
        again.userInteractionEnabled = YES;
        again.text = @"重新发送";
        again.textColor = KAPPCOLOR;
        [time invalidate];
    }
}

- (void)submitAction:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if (passwordone.length==0) {
        [self presentMessageTips:@"密码不能为空"];
        return;
    }
    if (verification.length==0) {
        [self presentMessageTips:@"请输入验证码"];
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
    [userModel findPassWithPhone:self.number code:verification pass:passwordone];
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
