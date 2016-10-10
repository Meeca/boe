//
//  WalletViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "WalletViewController.h"
#import "BillViewController.h"
#import "UserBalanceModel.h"

#import "DBHWithdrawalViewController.h"

UserBalanceModel *userBlance;

@interface WalletViewController () <UITableViewDelegate, UITableViewDataSource> {
    UserModel *userModel;
    
    BalanceInfo *bInfo;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的余额";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"帐单" style:UIBarButtonItemStylePlain target:self action:@selector(billAction:)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 230)];
    view.backgroundColor = self.table.backgroundColor;
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.layer.cornerRadius = 3.f;
    sure.layer.masksToBounds = YES;
    sure.backgroundColor = KAPPCOLOR;
    sure.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    sure.titleLabel.font = [UIFont systemFontOfSize:16];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitle:@"提  现" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureActionClick:) forControlEvents:UIControlEventTouchUpInside];
    sure.center = CGPointMake(view.width/2, sure.height/2);
    [view addSubview:sure];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.text = @"提现金额不能低于￥100,仅支持支付宝帐户提现";
    msg.font = [UIFont systemFontOfSize:14];
    msg.textColor = [UIColor grayColor];
    [view addSubview:msg];
    [msg sizeToFit];
    msg.top = sure.bottom + 10;
    msg.centerX = view.width/2;
    
    self.table.tableFooterView = view;
    
    userModel = [UserModel modelWithObserver:self];
    [self addHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadUserBalanceNetData];
}

- (void)loadUserBalanceNetData
{
    NSString *path = @"/app.php/User/balance";
    NSDictionary *params = @{
                             @"uid":kUserId,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         userBlance = [UserBalanceModel yy_modelWithJSON:requestDic];
     }
                      fail:^(NSString *error) {
                          
                      }];
}

- (void)addHeader {
    [userModel app_php_User_balance];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [userModel app_php_User_balance];
    }];
}

ON_SIGNAL3(UserModel, BALANCE, signal) {
    [self.table.mj_header endRefreshing];
    bInfo = signal.object;
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"切图 20160719-6"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.text = @"我的余额";
    msg.textColor = [UIColor grayColor];
    msg.font = [UIFont systemFontOfSize:17];
    [msg sizeToFit];
    [cell.contentView addSubview:msg];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.tag = 222;
    price.text = [NSString stringWithFormat:@"￥%.2f", [bInfo.balance.length>0?bInfo.balance:@"0" floatValue]];
    price.font = [UIFont systemFontOfSize:45];
    [price sizeToFit];
    [cell.contentView addSubview:price];
    
    imageView.centerX = tableView.width/2;
    imageView.y = (h-imageView.height-msg.height-price.height-20)/2;
    
    msg.top = imageView.bottom+10;
    msg.centerX = tableView.width/2;
    
    price.top = msg.bottom + 10;
    price.centerX = tableView.width/2;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (void)billAction:(UIBarButtonItem *)btn {
    BillViewController *vc = [[BillViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureActionClick:(UIButton *)button {
    
    if ([userBlance.authen integerValue] == 1) {
        //待审核
        [self showToastWithMessage:@"待审核"];
    }
    else if([userBlance.authen integerValue] == 2)
    {
        //通过
        DBHWithdrawalViewController *withdrawalVC = [[DBHWithdrawalViewController alloc] init];
        UILabel *label = [self.view viewWithTag:222];
        withdrawalVC.money = [label.text substringFromIndex:1];
        
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backBarButtonItem;
        
        [self.navigationController pushViewController:withdrawalVC animated:YES];
    }
    else{
        //是否认证（0未认证，1待审核，2通过，3不通过）
        if ([userBlance.authen integerValue] == 0) {
            //未认证
            [self showToastWithMessage:@"未认证"];
        }
        else if([userBlance.authen integerValue]== 3)
        {
            //未通过
            [self showToastWithMessage:@"未通过"];
        }
    }
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
