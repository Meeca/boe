//
//  NewOrEitdViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/9.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "NewOrEitdViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AreaViewController.h"

@interface NewOrEitdViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSString *name;
    NSString *number;
    NSString *area;
    NSString *address;
    
    NSString *city;
    
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation NewOrEitdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新建地址";
    if (self.isEdit) {
        self.title = @"编辑地址";
    }
    
    userModel = [UserModel modelWithObserver:self];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelAction:)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPPCOLOR} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setInfo:(AddressInfo *)info {
    if (_info != info) {
        _info = info;
    }
    name = info.name;
    number = info.tel;
    area = [NSString stringWithFormat:@"%@ %@ %@", info.sheng, info.shi, info.qu];
    address = info.address;
    city = [NSString stringWithFormat:@"%@-%@-%@", info.sheng_id, info.shi_id, info.qu_id];
}

ON_SIGNAL3(UserModel, ADDRESSADD, signal) {
    [Tool performBlock:^{
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    } afterDelay:.3];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIColor *color = [UIColor lightGrayColor];
    
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(25, 0, KSCREENWIDTH-50, h)];
    textView.borderStyle = UITextBorderStyleNone;
    textView.font = [UIFont systemFontOfSize:15];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    textView.leftViewMode = UITextFieldViewModeAlways;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textView.tag = indexPath.row;
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.font = textView.font;
    msg.text = @"占位字符";
    [msg sizeToFit];
    msg.width += 20;

    if (indexPath.row==0) {
        msg.text = @"收货人";
        
        textView.leftView = msg;
        textView.placeholder = @"请输入收货人";
        textView.text = name;
        textView.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:textView];
    } else if (indexPath.row==1) {
        msg.text = @"手机号码";

        textView.leftView = msg;
        textView.placeholder = @"请输入手机号";
        textView.text = number;
        textView.keyboardType = UIKeyboardTypePhonePad;
        [cell.contentView addSubview:textView];
    } else if (indexPath.row==2) {
        msg.text = @"所在地区";

        textView.leftView = msg;
        textView.placeholder = @"请选择所在地区";
        textView.text = area;
        textView.keyboardType = UIKeyboardTypeDefault;
        textView.enabled = NO;
        [cell.contentView addSubview:textView];
    } else if (indexPath.row==3) {
        msg.text = @"详细地址";

        textView.leftView = msg;
        textView.placeholder = @"请填写详细地址";
        textView.text = address;
        textView.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:textView];
        
        color = KAPPCOLOR;
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, h-0.5, KSCREENWIDTH-30, .5)];
    line.backgroundColor = color;
    [cell.contentView addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==2) {
        AreaViewController *vc = [[AreaViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [vc selAreaSucc:^(Provi *selProvi, City *selCity, Area *selArea) {
            NSMutableArray *arr1 = [NSMutableArray array];
            [arr1 addObject:selProvi.title];
            [arr1 addObject:selCity.title];
            [arr1 addObject:selArea.title];
            
            NSMutableArray *arr2 = [NSMutableArray array];
            [arr2 addObject:selProvi.sheng_id];
            [arr2 addObject:selCity.shi_id];
            [arr2 addObject:selArea.qu_id];
            
            area = [arr1 componentsJoinedByString:@" "];
            city = [arr2 componentsJoinedByString:@"-"];
            [self.table reloadData];
        }];
        [self.navigationController presentViewController:nav animated:YES completion:NULL];
    }
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 0) {
        UITextRange *markedRange = [textView markedTextRange];
        if (markedRange) {
            return;
        }
        if (textView.text.length > 6) {
            NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:6];
            textView.text = [textView.text substringToIndex:range.location];
        }
        name = textView.text;
    } else if (textView.tag == 1) {
        //手机号
        if (textView.text.length>11) {
            textView.text = [textView.text substringToIndex:11];
        }
        number = textView.text;
    } else if (textView.tag == 3) {
        
        address = textView.text;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)cancelAction:(UIBarButtonItem *)btn {
    [self.view endEditing:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)sureAction:(UIBarButtonItem *)btn {
    [self.view endEditing:YES];
    
    if (name.length==0) {
        [self presentMessageTips:@"请输入收货人"];
        return;
    }
    if (number.length==0) {
        [self presentMessageTips:@"请输入手机号"];
        return;
    }
    if (![number isTelephone]) {
        [self presentMessageTips:@"请输入正确的手机号"];
        return;
    }
    if (area.length==0) {
        [self presentMessageTips:@"请选择所在地区"];
        return;
    }
    if (address.length==0) {
        [self presentMessageTips:@"请填写详细地址"];
        return;
    }
    
    REQ_APP_PHP_USER_ADDRESS_ADD *req = [REQ_APP_PHP_USER_ADDRESS_ADD new];
    req.a_id = self.info.a_id.length>0?self.info.a_id:@"";
    [userModel loadCache];
    req.uid = kUserId;
    req.tel = number;
    req.name = name;
    req.city = city;
    req.address = address;
    req.home = @"1";
    
    [userModel app_php_User_address_add:req];
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
