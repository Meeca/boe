//
//  PayViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PayViewController.h"
#import "BuySuccViewController.h"

#import "OrderInfoModel.h"
#import "AliPayManager.h"
#import "MCHttp.h"
#import "WeiXinPayManager.h"

@interface PayViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger index;
    UserModel *userModel;
    BalanceInfo *bInfo;
    // 余额
    NSString *myRestMoney;
    NSInteger _payType;// 1  支付宝 2  微信  3 余额支付
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"支付方式";
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(0, 0, KSCREENWIDTH, 44);
    buy.backgroundColor = KAPPCOLOR;
    [buy setTitle:@"确  定" forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    buy.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:buy];
    buy.bottom = KSCREENHEIGHT;
    
    index = 1;
    self.table.backgroundColor = RGB(234, 234, 234);
    
    userModel = [UserModel modelWithObserver:self];
    
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
    [self addHeader];
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
    myRestMoney = bInfo.balance;
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, INDEXBALANCE, signal) {
    
    BuySuccViewController *vc = [[BuySuccViewController alloc] init];
    vc.info = signal.object;
    vc.isPushFromDaShang = YES;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [Tool performBlock:^{
        [self.navigationController presentViewController:nav animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } afterDelay:1];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 35, 35)];
    imgView.centerY = h/2;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *acc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    acc.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont systemFontOfSize:15];
    if (indexPath.row==0) {
        cell.textLabel.text = @"选择支付方式";
    } else if (indexPath.row==1) {
        imgView.image = [UIImage imageNamed:@"APP buy 切图 20160727-4"];
        [cell.contentView addSubview:imgView];
        
        title.text = @"支付宝";
        [title sizeToFit];
        [cell.contentView addSubview:title];
        title.centerY = h/2;
        title.left = imgView.right + 18;
        
        if (index == 1) {
            acc.image = [UIImage imageNamed:@"未标题-1-2"];
        } else {
            acc.image = [UIImage imageNamed:@"未标题-1-1"];
        }
        cell.accessoryView = acc;
    } else if (indexPath.row==2) {
        imgView.image = [UIImage imageNamed:@"APP buy 切图 20160727-5"];
        [cell.contentView addSubview:imgView];
        
        title.text = @"微信";
        [title sizeToFit];
        [cell.contentView addSubview:title];
        title.centerY = h/2;
        title.left = imgView.right + 18;
        
        if (index == 2) {
            acc.image = [UIImage imageNamed:@"未标题-1-2"];
        } else {
            acc.image = [UIImage imageNamed:@"未标题-1-1"];
        }
        cell.accessoryView = acc;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(title.x, 0, KSCREENWIDTH-title.x, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    } else if (indexPath.row==3) {
        imgView.image = [UIImage imageNamed:@"APP buy 切图 20160727-6"];
        [cell.contentView addSubview:imgView];
        
        NSString *text = [NSString stringWithFormat:@"钱包（剩余%@）", bInfo.balance.length>0?bInfo.balance:@"0"];
        title.text = text;
        [title sizeToFit];
        [cell.contentView addSubview:title];
        title.centerY = h/2;
        title.left = imgView.right + 18;
        
        if (index == 3) {
            acc.image = [UIImage imageNamed:@"未标题-1-2"];
        } else {
            acc.image = [UIImage imageNamed:@"未标题-1-1"];
        }
        cell.accessoryView = acc;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(title.x, 0, KSCREENWIDTH-title.x, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row!=0) {
        index = indexPath.row;
        _payType = indexPath.row;
        [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 35;
    }
    return 55;
}

- (void)sureAction:(UIButton *)btn {
    if ([myRestMoney integerValue] == 0) {
        [self presentMessageTips:@"余额不足!"];
        return;
    }
    
    /*
     get:/app.php/Index/balance
     uid#购买者id
     u_id#作者id
     p_id#作品id
     a_id#收货地址id（真品购买时用到）
     price#支付价格
     balance#使用余额支付（不使用 0，使用传使用的数值，余额使用规则：当余额大于或等于支付金额时，balance值传支付金额，当余额小于支付金额时balance传当前余额）
     type#购买类型（1购买收藏，2真品购买，3打赏）
     content#备注
     */
    // 商品价格
    NSString *daShangPrice = self.price;
    // balance#使用余额支付（不使用 0，使用传使用的数值，余额使用规则：当余额大于或等于支付金额时，balance值传支付金额，当余额小于支付金额时balance传当前余额）
    NSString *balance = @"0";
    if(_payType == 3){
        
        if ([myRestMoney integerValue] >= [daShangPrice integerValue]) {
            balance = daShangPrice;
        } else if ([myRestMoney integerValue] < [daShangPrice integerValue]) {
            balance = myRestMoney;
        }
    }
    
    NSString *path = @"/app.php/Index/balance";
    NSDictionary *params = @{
                             @"uid" : kUserId,
                             @"u_id" : self.info.u_id,
                             @"p_id" : self.info.p_id,
                             @"a_id" : @"",// 收货地址id
                             //@"price" : goodsPrice,
                             @"price" : balance,
                             @"balance" : balance,//
                             @"type" : @"3"/*@(_type)*/,
                             @"content" : @"",// 备注内容
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg){
        
        
        OrderInfoModel * orderInfoModel = [OrderInfoModel yy_modelWithJSON:requestDic];
        
        
        
//        orderId = orderInfoModel.o_id;
        if(_payType == 1){  //1.  支付宝
            
            [self aliPayWith:orderInfoModel];
            
        }
        
        
        if(_payType == 2){  // 2 微信
            
            [self wechatPayWith:orderInfoModel];
        }
        
        if(_payType == 3){  // 余额支付 支付成功跳转
            
            BuySuccViewController *vc = [[BuySuccViewController alloc] init];
            vc.isPushFromDaShang = YES;
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [Tool performBlock:^{
                [self.navigationController presentViewController:nav animated:YES completion:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } afterDelay:1];
        }
        
    }fail:^(NSString *error) {
        
        
    }];
//    REQ_APP_PHP_INDEX_BALANCE *req = [REQ_APP_PHP_INDEX_BALANCE new];
//    req.u_id = self.info.u_id;
//    req.p_id = self.info.p_id;
//    req.a_id = @"";
//    req.price = self.price.length>0?self.price:@"0";
//    req.balance = @"0";
//    req.type = @"3";
//    req.content = self.massage.length>0?self.massage:@"";
//    
//    [userModel app_php_Index_balance:req];
}

#pragma mark - 支付宝支付
/**
 *  支付宝支付
 *
 *  @param orderPayModel 订单信息
 */
- (void)aliPayWith:(OrderInfoModel * )orderPayModel{
    
    Product *p = [[Product alloc] init];
    p.price =[orderPayModel.price floatValue];// money;
    p.subject =orderPayModel.title;;
    p.orderId = orderPayModel.orders;
    // 支付宝支付
    [[AliPayManager sharedAliPayManager] pay:p];
}

#pragma mark - 微信支付
/**
 *  微信支付
 *
 *  @param orderPayModel 订单信息
 */
- (void)wechatPayWith:(OrderInfoModel * )orderPayModel{
    
    
    //get:/app.php/Wx/index
    //    orderids#订单id
    //    order_price#订单金额
    //    product_name#订单名称
    //
    
    
    NSDictionary * dictionary = @{@"orderids":orderPayModel.orders,
                                  @"order_price":orderPayModel.price,
                                  @"product_name":orderPayModel.title};
    
    
    [MCHttp postPayRequestURLStr:@"http://boe.ccifc.cn/app.php/Wx/index" withDic:dictionary success:^(NSDictionary *requestDic, NSString *msg) {
        
        
        NSLog(@"---  %@",requestDic);
        
        
        WXProduct * wxProduct = [WXProduct yy_modelWithJSON:requestDic];
        [[WeiXinPayManager sharedManager]weiXinPay:wxProduct];
        
        
    } failure:^(NSString *error) {
        
    }];
    
}

//-----------------------------------------------
#pragma mark - 支付宝支付状态回调
-(void)dealAlipayResult:(NSNotification*)notification{
    NSString*result=notification.object;
    if([result isEqualToString:@"9000"]){
        //在这里写支付成功之后的回调操作
        NSLog(@"支付宝支付成功");
        
        BuySuccViewController *vc = [[BuySuccViewController alloc] init];
        // 是否隐藏我的订单
        vc.isPushFromDaShang = YES;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [Tool performBlock:^{
            [self.navigationController presentViewController:nav animated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        } afterDelay:1];
        
    }else{
        //在这里写支付失败之后的回调操作
        //DeLog(@"支付宝支付失败");
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark - 微信支付状态的回调

-(void)dealWXpayResult:(NSNotification*)notification{
    NSString*result=notification.object;
    if([result isEqualToString:@"1"]){
        //在这里写支付成功之后的回调操作
        NSLog(@"微信支付成功");
        
        BuySuccViewController *vc = [[BuySuccViewController alloc] init];
        // 是否隐藏我的订单
        vc.isPushFromDaShang = YES;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [Tool performBlock:^{
            [self.navigationController presentViewController:nav animated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        } afterDelay:1];
    }else{
        //在这里写支付失败之后的回调操作
        // DeLog(@"微信支付失败");
        [self.navigationController popViewControllerAnimated:YES];
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
