//
//  AddressViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "NewOrEitdViewController.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate> {
    UserModel *userModel;
    
    NSArray *dataArr;
    
    void(^blocks)(AddressInfo *info);
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"收货地址管理";
    self.table.estimatedRowHeight = 130;
    userModel = [UserModel modelWithObserver:self];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
    
    UIButton *addNew = [UIButton buttonWithType:UIButtonTypeCustom];
    addNew.frame = CGRectMake(0, 0, KSCREENWIDTH, 44);
    addNew.backgroundColor = KAPPCOLOR;
    [addNew setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addNew setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addNew addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    addNew.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:addNew];
    addNew.bottom = KSCREENHEIGHT;
    
    [self addHeader];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [userModel app_php_User_address_list];
    }];
}

ON_SIGNAL3(UserModel, ADDRESSLIST, signal) {
    [self.table.mj_header endRefreshing];
    dataArr = signal.object;
    if (dataArr.count == 0) {
        [self presentMessageTips:@"暂无任何收货地址请添加"];
    }
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, ADDRESSDEL, signal) {
    [userModel app_php_User_address_list];
}

ON_SIGNAL3(UserModel, ADDRESSADD, signal) {
    [userModel app_php_User_address_list];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addreCell"];
    if (cell==nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"addreCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell deftAction:^(AddressInfo *info) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:info.sheng_id];
        [arr addObject:info.shi_id];
        [arr addObject:info.qu_id];
        
        REQ_APP_PHP_USER_ADDRESS_ADD *req = [REQ_APP_PHP_USER_ADDRESS_ADD new];
        req.a_id = info.a_id;
        [userModel loadCache];
        req.uid = kUserId;
        req.tel = info.tel;
        req.name = info.name;
        req.city = [arr componentsJoinedByString:@"-"];
        req.address = info.address;
        req.home = @"1";
        
        [userModel app_php_User_address_add:req];
    }];
    
    [cell editAction:^(AddressInfo *info) {
        NewOrEitdViewController *vc = [[NewOrEitdViewController alloc] init];
        vc.info = info;
        vc.isEdit = YES;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:NULL];
    }];
    
    [cell delAction:^(AddressInfo *info) {
        [userModel app_php_User_address_del:info.a_id];
    }];
    
    cell.data = dataArr[indexPath.section];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressInfo *info = dataArr[indexPath.section];
    
    if (blocks) {
        blocks(info);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didSelRow:(void(^)(AddressInfo *info))block {
    blocks = [block copy];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AUTOLAYOUTSIZE(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10.f;
//}

- (void)addNewAddress:(UIButton *)btn {
    NewOrEitdViewController *vc = [[NewOrEitdViewController alloc] init];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [userModel app_php_User_address_list];
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
