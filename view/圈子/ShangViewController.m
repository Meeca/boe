//
//  ShangViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ShangViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "DecimalField.h"
#import "PayViewController.h"

@interface ShangViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSString *massage;
    NSString *price;
    UILabel *priceLab;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation ShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打赏";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 230)];
    view.backgroundColor = RGB(234, 234, 234);
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.layer.cornerRadius = 3.f;
    sure.layer.masksToBounds = YES;
    sure.backgroundColor = KAPPCOLOR;
    sure.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    sure.titleLabel.font = [UIFont systemFontOfSize:16];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitle:@"确  定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    sure.center = CGPointMake(view.width/2, sure.height/2+15);
    [view addSubview:sure];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.text = @"打赏金额将直将进入对方帐户";
    msg.font = [UIFont systemFontOfSize:14];
    msg.textColor = [UIColor grayColor];
    [view addSubview:msg];
    [msg sizeToFit];
    msg.top = sure.bottom + 10;
    msg.centerX = view.width/2;
    
    self.table.tableFooterView = view;
    self.table.backgroundColor = RGB(234, 234, 234);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        cell.backgroundColor = tableView.backgroundColor;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        imageView.layer.cornerRadius = imageView.width/2;
        imageView.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.info.u_image] placeholderImage:KZHANWEI];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:name];
        name.text = self.info.u_name?:@" ";
        [name sizeToFit];
        
        imageView.center = CGPointMake(tableView.width/2, h/2);
        imageView.centerY -= name.height;
        
        name.centerX = imageView.centerX;
        name.top = imageView.bottom + 10;
    } else if (indexPath.section==1) {
        cell.textLabel.text = @"金额";
        
        UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
        msg.text = @"元";
        msg.textAlignment = NSTextAlignmentRight;
        msg.font = cell.textLabel.font;
        [msg sizeToFit];
        msg.width += 15;
        
        DecimalField *textField = [[DecimalField alloc] initWithFrame:CGRectMake(80, 0, KSCREENWIDTH-95, h)];
        textField.placeholder = @"输入金额 ";
        textField.text = price;
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.rightView = msg;
        textField.font = cell.textLabel.font;
        textField.textAlignment = NSTextAlignmentRight;
        textField.tag = indexPath.section;
        [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:textField];
    } else if (indexPath.section==2) {
        cell.textLabel.text = @"留言";
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, KSCREENWIDTH-95, h)];
        textField.placeholder = @"期待您有更好的作品";
        textField.text = massage;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.font = cell.textLabel.font;
        textField.textAlignment = NSTextAlignmentRight;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.tag = indexPath.section;
        [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:textField];
    } else if (indexPath.section==3) {
        cell.backgroundColor = tableView.backgroundColor;
        
        if (!priceLab) {
            priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, h)];
            priceLab.textAlignment = NSTextAlignmentCenter;
            priceLab.font = [UIFont boldSystemFontOfSize:40];
            priceLab.textColor = KAPPCOLOR;
        }
        priceLab.height = h;
        priceLab.text = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%.2f", [price floatValue]]];
        [cell.contentView addSubview:priceLab];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (void)textChange:(UITextField *)textField {
    if (textField.tag == 1) { // $
        if ([textField.text integerValue]>200) {
            textField.text = @"200";
        }
        price = textField.text;
        priceLab.text = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%.2f", [price floatValue]]];
    } else if (textField.tag == 2) {  // msg
        massage = textField.text;
    }
}

- (void)sureAction:(UIButton *)btn {
    if (price.length==0||[price floatValue]==0) {
        [self presentMessageTips:@"请输入打赏金额"];
        return;
    }
    
    PayViewController *vc = [[PayViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.info = self.info;
    vc.price = price;
    vc.massage = massage;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
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
