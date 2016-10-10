//
//  AddDvViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/9.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "AddDvViewController.h"
#import "BaseModel.h"

@interface AddDvViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSString *title;
    
    BaseModel *baseModel;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation AddDvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"添加一个设备";
    
    baseModel = [BaseModel modelWithObserver:self];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSCREENWIDTH/5, KSCREENWIDTH, KSCREENWIDTH/2)];
    img.image = [UIImage imageNamed:@"切图 QH 20160704-14"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [header addSubview:img];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom, KSCREENWIDTH, header.height-img.bottom)];
    msg.font = [UIFont systemFontOfSize:16];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.numberOfLines = 0;
    msg.text = [NSString stringWithFormat:@"iGallery\nID:%@", self.mac_id];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:msg.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    msg.attributedText = str;
    [header addSubview:msg];
    
    self.table.tableHeaderView = header;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 150)];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.backgroundColor = KAPPCOLOR;
    add.layer.cornerRadius = 3.f;
    add.layer.masksToBounds = YES;
    add.frame = CGRectMake(0, 0, KSCALE(800), 44);
    add.titleLabel.font = [UIFont systemFontOfSize:16];
    [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [add setTitle:@"确定添加" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    add.center = CGPointMake(view.width/2, add.height/2+20);
    
    [view addSubview:add];
    
    self.table.tableFooterView = view;
    self.table.backgroundColor = RGB(234, 234, 234);
}

ON_SIGNAL3(BaseModel, EQUIPMENTADD, signal) {
    NSArray *views = self.navigationController.viewControllers;
    [self.navigationController popToViewController:views[1] animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
        textView.placeholder = @"备注设备名称";
        textView.text = title;
        textView.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)addAction:(UIButton *)btn {
    if (title.length == 0) {
        [self presentMessageTips:@"请备注设备名称"];
        return;
    }
    [baseModel app_php_User_equipment_addWithTitle:title mac_id:self.mac_id];
}

- (void)textBeainEditing:(UITextField *)textView {
    self.table.bounces = YES;
}

- (void)textEndEditing:(UITextField *)textView {
    self.table.bounces = NO;
}

- (void)textChange:(UITextField *)textView {
    if (textView.tag == 0) {
        title = textView.text;
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
