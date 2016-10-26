//
//  BuyCllowerViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BuyCllowerViewController.h"
#import "BuySuccViewController.h"
#import "WeiXinPayManager.h"
#import "AliPayManager.h"
#import "MCHttp.h"
#import "OrderInfoModel.h"

@interface BuyCllowerViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIView *header;
    
    NSInteger _payType;// 1  支付宝 2  微信  3 余额支付
    UserModel *userModel;
    BalanceInfo *bInfo;
    // 余额
    NSString *myRestMoney;
    // 订单id
    NSString *orderId;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation BuyCllowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"限量收藏";
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(0, 0, KSCREENWIDTH, 44);
    buy.backgroundColor = KAPPCOLOR;
    [buy setTitle:@"提交订单" forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(subOrder:) forControlEvents:UIControlEventTouchUpInside];
    buy.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:buy];
    buy.bottom = KSCREENHEIGHT;
    
    _payType = 1;
    self.table.backgroundColor = RGB(234, 234, 234);
    self.table.tableHeaderView = header;
    
    userModel = [UserModel modelWithObserver:self];
    
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
    [self addHeader];
    //注册监听-支付宝
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealAlipayResult:) name:@"alipayResult" object:nil];
    //注册监听-微信
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealWXpayResult:) name:@"WXpayresult" object:nil];
    
    // 获取余额
    [userModel app_php_User_balance];
    
}


- (void)subOrder:(UIButton *)btn {
    if ([myRestMoney integerValue] == 0 && _payType ==3) {
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
    
//    "p_id": "1",                    //作品id
//    "title": "zuopin",         //作品名称
//    "image": "dfsf1ds5f1s51.jpg",   //作品图地址
//    "u_id": "1",              //作者id
//    "u_image": "dfsf1ds5f1s51.jpg",   //作者头像
//    "u_name": "梵高",               //作者昵称
//    "years": "2015年",              //作品年份
//    "classs": "画布油画",      //作品类别
//    "theme": "红色 公开 美女",      //作品标签
//    "created_at": "2016-05-30",     //作品上传时间
//    "coll_nums": "1250",            //关注数量
//    "collection": "0",              //0=未关注，1=已关注
//    "plates": "1",              //板式（1横屏，2竖屏）
//    "zambia_nums": "1250",            //赞数量
//    "zambia": "0",              //0=未赞，1=已赞
//    "electronic_price": "1",            //电子版价格
//    "electronic_nums": "1",          //电子版库存数量
//    "material_price": "1",              //实物价格
//    "material_nums": "1",              //实物库存数量
//    "reward_nums": "1",              //打赏数量
//    "electronics_nume": "1",              //电子版购买数量（购买数量大于限制数量时不可购买）
//    "content": "简介",      //作品简介
//    "pay_type": "1",              //限量收藏（1已购买，2未购买）
    
    DetailsInfo *goodsInfo = self.info;
    // 商品价格
    NSString *goodsPrice = goodsInfo.electronic_price;
    // balance#使用余额支付（不使用 0，使用传使用的数值，余额使用规则：当余额大于或等于支付金额时，balance值传支付金额，当余额小于支付金额时balance传当前余额）
    NSString *balance = @"0";
    if(_payType == 3){
    
        if ([myRestMoney integerValue] >= [goodsPrice integerValue]) {
            balance = goodsPrice;
        } else if ([myRestMoney integerValue] < [goodsPrice integerValue]) {
            balance = myRestMoney;
        }
    }
    
    NSString *path = @"/app.php/Index/balance";
    NSDictionary *params = @{
                             @"uid" : kUserId,
                             @"u_id" : self.info.u_id,
                             @"p_id" : self.info.p_id,
                             @"a_id" : @"",// 收货地址id
                             @"price" : goodsPrice,
//                             @"price" : @"0.01",
                             @"balance" : balance,//
                             @"type" : @"1"/*@(_type)*/,
                             @"content" : @"",// 备注内容
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg){
        
        OrderInfoModel * orderInfoModel = [OrderInfoModel yy_modelWithJSON:requestDic];
        
        orderId = orderInfoModel.o_id;
        if(_payType == 1){  //1.  支付宝
        
            [self aliPayWith:orderInfoModel];
            
        }
        
        
        if(_payType == 2){  // 2 微信
   
            [self wechatPayWith:orderInfoModel];
        }
        
        if(_payType == 3){  // 余额支付 支付成功跳转
            
            BuySuccViewController *vc = [[BuySuccViewController alloc] init];
            vc.orderId = orderInfoModel.o_id;
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [Tool performBlock:^{
                [self.navigationController presentViewController:nav animated:YES completion:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } afterDelay:1];
        }

    }fail:^(NSString *error) {
        

    }];
    
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
        vc.orderId = orderId;
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
        vc.orderId = orderId;
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

//---------------------------------------------


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
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [Tool performBlock:^{
        [self.navigationController presentViewController:nav animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } afterDelay:1];
}

- (void)setInfo:(DetailsInfo *)info {
    if (_info != info) {
        _info = info;
    }
    
    CGFloat wid = 80;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, wid+40)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, wid, wid)];
    imgView.centerY = header.height/2;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [imgView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    [header addSubview:imgView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.text = info.title?:@" ";
    name.font = [UIFont boldSystemFontOfSize:19];
    name.textColor = [UIColor blackColor];
    [header addSubview:name];
    [name sizeToFit];
    name.x = imgView.right + 10;
    name.top = imgView.top+2;
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectZero];
//    author.text = [@"作者 " stringByAppendingString:info.u_name?:@" "];
    author.text = info.u_name;
    author.font = [UIFont systemFontOfSize:15];
    author.textColor = [UIColor blackColor];
    [header addSubview:author];
    [author sizeToFit];
    author.x = imgView.right + 10;
    author.top = name.bottom + 8;
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectZero];
    num.text = [NSString stringWithFormat:@"%@人收藏/%@", info.electronics_nume.length>0?info.electronics_nume:@"0", info.electronic_nums.length>0?info.electronic_nums:@"0"];
    num.font = [UIFont systemFontOfSize:15];
    num.textColor = [UIColor blackColor];
    [header addSubview:num];
    [num sizeToFit];
    num.x = imgView.right + 10;
    num.top = author.bottom + 8;
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.text = [@"￥" stringByAppendingString:info.electronic_price.length>0?info.electronic_price:@"0"];
    price.font = [UIFont boldSystemFontOfSize:15];
    price.textColor = KAPPCOLOR;
    [header addSubview:price];
    [price sizeToFit];
    price.right = KSCREENWIDTH - 20;
    price.centerY = header.height/2;
    
    
    author.width =  KSCREENWIDTH - author.left - 10-price.width-8;

    
    self.table.tableHeaderView = header;
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
        
        if (_payType == 1) {
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
        
        if (_payType == 2) {
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
        
        if (_payType == 3) {
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
