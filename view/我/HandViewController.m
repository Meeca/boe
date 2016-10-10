//
//  HandViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/9.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "HandViewController.h"
#import "AddDvViewController.h"

@interface HandViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSString *mac_id;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation HandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"手动添加";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 150)];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.backgroundColor = KAPPCOLOR;
    add.layer.cornerRadius = 3.f;
    add.layer.masksToBounds = YES;
    add.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    add.titleLabel.font = [UIFont systemFontOfSize:16];
    [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [add setTitle:@"添 加" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    add.center = CGPointMake(view.width/2, add.height/2+20);

    [view addSubview:add];
    
    self.table.tableFooterView = view;
    self.table.backgroundColor = RGB(234, 234, 234);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
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
        cell.backgroundColor = tableView.backgroundColor;
        cell.textLabel.text = @"请输入设备ID";
    } else if (indexPath.row==1) {
        textView.placeholder = @"设备ID号";
        textView.text = mac_id;
        textView.keyboardType = UIKeyboardTypeAlphabet;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)addAction:(UIButton *)btn {
    if (mac_id.length == 0) {
        [self presentMessageTips:@"请输入设备ID"];
        return;
    }
    AddDvViewController *vc = [[AddDvViewController alloc] init];
    vc.mac_id = mac_id;
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 1) {
        mac_id = textView.text;
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
