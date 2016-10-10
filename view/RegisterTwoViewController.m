//
//  RegisterTwoViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/6.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "PasswordViewController.h"

@interface RegisterTwoViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString *verification;
    UserModel *userModel;
    
    NSInteger timer;
    
    UILabel *again;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation RegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手机注册";
    self.table.backgroundColor = RGB(234, 234, 234);
    
    userModel = [UserModel modelWithObserver:self];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 230)];
    view.backgroundColor = self.table.backgroundColor;
    
    again = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 45)];
    again.userInteractionEnabled = YES;
    again.centerX = view.width/2;
    again.textAlignment = NSTextAlignmentCenter;
    again.font = [UIFont systemFontOfSize:16];
    again.text = @"重新发送";
    again.textColor = KAPPCOLOR;
    [view addSubview:again];
    
    UITapGestureRecognizer *againTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(againAction:)];
    [again addGestureRecognizer:againTap];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.layer.cornerRadius = 3.f;
    next.layer.masksToBounds = YES;
    next.backgroundColor = KAPPCOLOR;
    next.frame = CGRectMake(0, again.bottom+5, KSCALE(1100), 44);
    next.titleLabel.font = [UIFont systemFontOfSize:16];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    next.centerX = view.width/2;
    [view addSubview:next];

    
    self.table.tableFooterView = view;
}

ON_SIGNAL3(UserModel, VERIFYCODE, signal) {
    again.userInteractionEnabled = NO;
    timer = 60;
    NSString *title = [NSString stringWithFormat:@"%@s重新发送", @(timer)];
    again.text = title;
    again.textColor = [UIColor grayColor];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDown:) userInfo:again repeats:YES];
}

ON_SIGNAL3(UserModel, CODECATION, signal) {
    VerifyIs *verify = signal.object;
    if ([verify.cation integerValue]==1) {
        PasswordViewController *vc = [[PasswordViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.number = self.number;
        vc.verification = verification;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self presentMessageTips:@"验证码错误"];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
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
        UILabel *msg = [[UILabel alloc] initWithFrame:textView.frame];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"您的手机号码："];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:self.number];
        
        [str2 addAttribute:NSForegroundColorAttributeName value:KAPPCOLOR range:NSMakeRange(0, str2.length)];
        [str1 appendAttributedString:str2];
        
        [str1 addAttribute:NSFontAttributeName value:cell.textLabel.font range:NSMakeRange(0, str1.length)];
        msg.attributedText = str1;
        [msg sizeToFit];
        msg.bottom = 45;
        [cell.contentView addSubview:msg];
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==1) {
        cell.textLabel.text = @"请输入接收到的短信验证码";
        cell.backgroundColor = tableView.backgroundColor;
    } else if (indexPath.row==2) {
        textView.placeholder = @"输入验证码";
        textView.text = verification;
        textView.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (void)againAction:(UIGestureRecognizer *)tap {
    [self.view endEditing:YES];

    [userModel getVerifyWithPhone:self.number type:@"1"];
}

- (void)nextAction:(UIButton *)btn {
    [self.view endEditing:YES];

    [userModel app_php_User_codecationWithPhone:self.number code:verification];
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
    if (textView.tag == 2) {  //  验证码
       
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
