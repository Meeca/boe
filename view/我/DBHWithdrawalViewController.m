//
//  DBHWithdrawalViewController.m
//  jingdongfang
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHWithdrawalViewController.h"

#import "Masonry.h"
#import "LXKRegularExpressionTool.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define  SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define FONTSIZE 14
#define CELLHEIGHT 40

@interface DBHWithdrawalViewController ()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UIView *grayLineViewOne;
@property (nonatomic, strong) UIView *grayLineViewTwo;
@property (nonatomic, strong) UIView *grayLineViewThree;

@end

@implementation DBHWithdrawalViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"提现申请";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - ui
- (void)setUI {
    [self.view addSubview:self.typeLabel];
    [self.view addSubview:self.accountLabel];
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.moneyTextField];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.commitButton];
    [self.view addSubview:self.grayLineViewOne];
    [self.view addSubview:self.grayLineViewTwo];
    [self.view addSubview:self.grayLineViewThree];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.left.offset(AUTOLAYOUTSIZE(10));
        make.top.equalTo(self.view).offset(64);
    }];
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(_accountTextField.mas_left).offset(- AUTOLAYOUTSIZE(23));
        make.top.equalTo(_typeLabel.mas_bottom);
    }];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.72);
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(self.view);
        make.centerY.equalTo(_accountLabel);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(_nameTextField.mas_left).offset(- AUTOLAYOUTSIZE(23));
        make.top.equalTo(_accountLabel.mas_bottom);
    }];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.72);
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(self.view);
        make.centerY.equalTo(_nameLabel);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(_phoneTextField.mas_left).offset(- AUTOLAYOUTSIZE(23));
        make.top.equalTo(_nameLabel.mas_bottom);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.72);
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(self.view);
        make.centerY.equalTo(_phoneLabel);
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(_moneyTextField.mas_left).offset(- AUTOLAYOUTSIZE(23));
        make.top.equalTo(_phoneLabel.mas_bottom);
    }];
    [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.72);
        make.height.offset(AUTOLAYOUTSIZE(CELLHEIGHT));
        make.right.equalTo(self.view);
        make.centerY.equalTo(_moneyLabel);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AUTOLAYOUTSIZE(10));
        make.right.offset(- AUTOLAYOUTSIZE(10));
        make.top.equalTo(_moneyLabel.mas_bottom).offset(AUTOLAYOUTSIZE(5));
    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.92);
        make.height.offset(AUTOLAYOUTSIZE(40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_contentLabel.mas_bottom).offset(AUTOLAYOUTSIZE(30));
    }];
}

#pragma mark - data
- (void)commitApplication {
    NSString *path = @"/app.php/User/withdrawals";
    NSDictionary *params = @{@"uid":kUserId, @"type":@"1", @"ali_code":_accountTextField.text, @"name":_nameTextField.text, @"tel":_phoneTextField.text, @"price":_moneyTextField.text};
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        [self showToastWithMessage:msg];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSString *error) {
        [self showToastWithMessage:@"提交失败"];
    }];
}

#pragma mark - event responds
- (void)respondsToCommitButton {
    // 提交申请
    if (_accountTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入支付宝账号"];
        return;
    } else if ([LXKRegularExpressionTool isValidateMobile:_accountTextField.text] == NO && [LXKRegularExpressionTool checkEmail:_accountTextField.text] == NO) {
        [self showToastWithMessage:@"请输入正确的支付宝账号"];
        return;
    } else if (_nameTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入姓名"];
        return;
    } else if (_phoneTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入手机号"];
        return;
    } else if ([LXKRegularExpressionTool isValidateMobile:_phoneTextField.text] == NO) {
        [self showToastWithMessage:@"请输入正确的手机号"];
    } else if (_moneyTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入金额"];
        return;
    } else if (_moneyTextField.text.floatValue < 100 || _moneyTextField.text.floatValue > _money.floatValue) {
        [self showToastWithMessage:[NSString stringWithFormat:@"提现金额应大于100小于%@", _money]];
        return;
    }
    
    [self commitApplication];
}

#pragma mark - getters and setters
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _typeLabel.text = @"提现方式：支付宝";
    }
    return _typeLabel;
}
- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _accountLabel.text = @"支付宝账号";
    }
    return _accountLabel;
}
- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.placeholder = @"请输入支付宝账号";
        _accountTextField.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
    }
    return _accountTextField;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _nameLabel.text = @"真实姓名";
    }
    return _nameLabel;
}
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = @"属于支付宝开户姓名一致";
        _nameTextField.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
    }
    return _nameTextField;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _phoneLabel.text = @"手机号码";
    }
    return _phoneLabel;
}
- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号码";
        _phoneTextField.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
    }
    return _phoneTextField;
}
- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _moneyLabel.text = @"金额（元）";
    }
    return _moneyLabel;
}
- (UITextField *)moneyTextField {
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] init];
        _moneyTextField.placeholder = @"￥0.00";
        _moneyTextField.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
    }
    return _moneyTextField;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(FONTSIZE)];
        _contentLabel.text = @"提现金额不能低于￥100.00。17:00之前提现申请均为当天审核完成，到账时间以支付宝到账时间为准";
    }
    return _contentLabel;
}
- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.layer.cornerRadius = AUTOLAYOUTSIZE(5);
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(18)];
        _commitButton.backgroundColor = COLOR(57, 200, 245, 1);
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(respondsToCommitButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}
- (UIView *)grayLineViewOne {
    if (!_grayLineViewOne) {
        _grayLineViewOne = [[UIView alloc] init];
        _grayLineViewOne.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayLineViewOne;
}
- (UIView *)grayLineViewTwo {
    if (!_grayLineViewTwo) {
        _grayLineViewTwo = [[UIView alloc] init];
        _grayLineViewTwo.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayLineViewTwo;
}
- (UIView *)grayLineViewThree {
    if (!_grayLineViewThree) {
        _grayLineViewThree = [[UIView alloc] init];
        _grayLineViewThree.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayLineViewThree;
}

@end
