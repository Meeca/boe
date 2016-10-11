//
//  NickViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/10.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "NickViewController.h"
#import "TPKeyboardAvoidingTableView.h"

@interface NickViewController () <UITableViewDataSource, UITableViewDelegate> {
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation NickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"更改昵称";
    
    userModel = [UserModel modelWithObserver:self];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sure:)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPPCOLOR} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
    
    self.table.backgroundColor = [UIColor whiteColor];
}

ON_SIGNAL3(UserModel, USERNIKE, signal) {
    [Tool performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:.3];
}

#pragma mark — UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(x, 15, KSCREENWIDTH-2*x, 40)];
    textView.borderStyle = UITextBorderStyleRoundedRect;
    textView.font = [UIFont systemFontOfSize:14];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth = 1;
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addTarget:self action:@selector(textBeainEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textView addTarget:self action:@selector(textEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    textView.tag = indexPath.row;
    textView.placeholder = @"请输入昵称";
    textView.text = self.nick;
    textView.keyboardType = UIKeyboardTypeDefault;
    [cell.contentView addSubview:textView];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    UILabel *foot = [[UILabel alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, 0, tableView.width, 30)];
    foot.font = [UIFont systemFontOfSize:14];
    foot.textColor = [UIColor grayColor];
    foot.text = @"好名字让你更容易被认知";
    [view addSubview:foot];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 0) {
        UITextRange *markedRange = [textView markedTextRange];
        if (markedRange) {
            
            return;
        }
        
        if (textView.text.length > 12) {
            [self presentMessageTips:@"最多可输入12个字"];
            NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:12];
            textView.text = [textView.text substringToIndex:range.location];
        }

        self.nick = textView.text;
    }
}

- (void)sure:(UIBarButtonItem *)btn {
    [self.view endEditing:YES];
    if (self.nick.length == 0) {
        [self presentMessageTips:@"请输入昵称"];
        return;
    }
    
    [userModel app_php_User_user_nikeWithNike:self.nick];
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
