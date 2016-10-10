//
//  QueRenViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "QueRenViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AddressViewController.h"
#import "ListTableViewCell.h"
#import "BuySuccViewController.h"
#import <CoreText/CoreText.h>
#import "OrderInfoModel.h"
#import "MCHttp.h"
#import "AliPayManager.h"
#import "WeiXinPayManager.h"

@interface QueRenViewController () <UITableViewDelegate, UITableViewDataSource> {
    AddressInfo *infos;
    
    NSString *massage;
    NSInteger index;
    
    UserModel *userModel;
    BalanceInfo *bInfo;
    
    NSInteger _payType;// 1  支付宝 2  微信  3 余额支付
    // 余额
    NSString *myRestMoney;
    // 订单id
    NSString *orderId;
}


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation QueRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"确认订单";
    index = 1;
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 44)];
    [self.view addSubview:bar];
    bar.backgroundColor = [UIColor whiteColor];
    bar.bottom = KSCREENHEIGHT;
    
    UILabel *all = [[UILabel alloc] initWithFrame:CGRectZero];
    [bar addSubview:all];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"合计："];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[@"￥" stringByAppendingString:self.info.material_sum ? self.info.material_sum : (self.info.material_price.length>0?self.info.material_price:@"0")]];
    
    [str1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str1.length)];
    [str2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:KAPPCOLOR} range:NSMakeRange(0, str2.length)];
    [str1 appendAttributedString:str2];
    
    all.attributedText = str1;
    [all sizeToFit];
    all.right = KSCREENWIDTH/3*2-20;
    all.centerY = bar.height/2;
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(KSCREENWIDTH/3*2, 0, KSCREENWIDTH/3, 44);
    buy.backgroundColor = KAPPCOLOR;
    [buy setTitle:@"提交订单" forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    buy.titleLabel.font = [UIFont systemFontOfSize:16];
    [bar addSubview:buy];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
    
    userModel = [UserModel modelWithObserver:self];
    
    [self addHeader];
    
    [self loadDefaultAddress];
    
    _payType = 1;
    //注册监听-支付宝
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealAlipayResult:) name:@"alipayResult" object:nil];
    //注册监听-微信
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealWXpayResult:) name:@"WXpayresult" object:nil];
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
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [Tool performBlock:^{
        [self.navigationController presentViewController:nav animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } afterDelay:1];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==3) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectZero];
        address.numberOfLines = 0;
        address.font = [UIFont systemFontOfSize:15];
        address.lineBreakMode = NSLineBreakByWordWrapping;
        if (infos) {
//            address.numberOfLines = 2;
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:infos.name];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@\n%@", infos.tel, infos.address]];
            
            [str1 addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], } range:NSMakeRange(0, str1.length)];
            [str2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, str2.length)];
            
            
            [str1 appendAttributedString:str2];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 10;
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, str1.length)];
            
            address.attributedText = str1;
            address.x = 40;
            address.y = 5;
            address.width = tableView.width - address.x * 2;
            
            [address sizeToFit];
//            address.centerY = h/2;
            
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
            img.image = [UIImage imageNamed:@"APP buy 切图 20160727-3"];
            img.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:img];
            img.centerY = address.centerY;
            img.right = address.left-5;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else {
            address.text = @"＋ 添加收货地址";
            [address sizeToFit];
            address.center = CGPointMake(tableView.width/2, h/2);
        }
        
        [cell.contentView addSubview:address];
        
        UIImage *image = [UIImage imageNamed:@"APP buy 切图 20160727-12"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH*image.size.height/image.size.width)];
        imageView.image = image;
        imageView.bottom = h;
        [cell.contentView addSubview:imageView];
        
    } else if (indexPath.section==1) {
        ListTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell.h"];
        
        if (cell1==nil) {
            cell1 = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ListTableViewCell.h"];
            
        }
        cell1.data = self.info;
        [cell1 setNeedsLayout];
        return cell1;
    } else if (indexPath.section==2) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, KSCREENWIDTH-30, h)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.borderStyle = UITextBorderStyleNone;
        
        textField.placeholder = @"添加订单备注";
        textField.text = massage;
        [textField addTarget:self action:@selector(textChang:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:textField];
    } else if (indexPath.section==3) {
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AddressViewController *vc = [[AddressViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [vc didSelRow:^(AddressInfo *inf) {
            infos = inf;
            [tableView reloadData];
        }];
        [Tool setBackButtonNoTitle:self];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section==3) {
        if (indexPath.row!=0) {
            index = indexPath.row;
            _payType = indexPath.row;
            [tableView reloadData];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        CGFloat h = [self tableView:tableView heightForHeaderInSection:section];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, h)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
        img.image = [UIImage imageNamed:@"切图 20160719-3"];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.centerY = h/2;
        [view addSubview:img];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.text = self.info.u_name.length>0?self.info.u_name:@" ";
        name.font = [UIFont systemFontOfSize:15];
        [name sizeToFit];
        [view addSubview:name];
        name.x = img.right+8;
        name.centerY = h/2;
        
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
        CGFloat addressBottom = 0;
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectZero];
        address.numberOfLines = 0;
        address.font = [UIFont systemFontOfSize:15];
        address.lineBreakMode = NSLineBreakByWordWrapping;
        if (infos)
        {
            //            address.numberOfLines = 2;
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:infos.name];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@\n%@", infos.tel, infos.address]];
            
            [str1 addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], } range:NSMakeRange(0, str1.length)];
            [str2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, str2.length)];
            
            
            [str1 appendAttributedString:str2];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 10;
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, str1.length)];
            
            address.attributedText = str1;
            address.x = 40;
            address.y = 5;
            address.width = KSCREENWIDTH - address.x * 2;
            
            
            [address sizeToFit];
            addressBottom = address.bottom;
        }
        else
        {
            addressBottom = 70;
        }
        return addressBottom + 10;
    } else if (indexPath.section==1) {
        return 80;
    } else if (indexPath.section==2) {
        return 55;
    } else if (indexPath.section==3) {
        if (indexPath.row==0) {
            return 35;
        }
        return 55;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    } else if (section==1) {
        return 40;
    }
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)textChang:(UITextField *)text {
    massage = text.text;
}

- (void)subAction:(UIButton *)btn {
    if (infos==nil) {
        [self presentMessageTips:@"请添加收货地址"];
        return;
    }
    
    if (_payType == 3 && bInfo.balance.floatValue <= 0)
    {
        [self presentMessageTips:@"余额为0不能钱包支付"];
        return;
    }
    
    /*
     uid#购买者id
     u_id#作者id
     p_id#作品id
     a_id#收货地址id（真品购买时用到）
     price#支付价格
     balance#使用余额支付（不使用 0，使用传使用的数值，余额使用规则：当余额大于或等于支付金额时，balance值传支付金额，当余额小于支付金额时balance传当前余额）
     type#购买类型（1购买收藏，2真品购买，3打赏）
     content#备注
     */
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
    
    if (_isBuyPictureFrame) {
        NSString *path = @"/app.php/Index/balance_frame";
        NSDictionary *params = @{
                                 @"uid" : kUserId,
                                 @"p_id" : self.info.p_id,
                                 @"a_id" : @"",// 收货地址id
                                 @"price" : goodsPrice,
                                 @"nums" : self.info.material_num,
                                 //                             @"price" : @"0.01",
                                 @"balance" : balance,//
                                 @"attri" : [NSString stringWithFormat:@"%@-%@", self.info.pictureFrameTypeOne, self.info.pictureFrameTypeTwo],
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
    } else {
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
//    p.price =0.01;// money;
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

- (void)loadDefaultAddress
{
    [MCNetTool postWithUrl:@"/app.php/User/address_list" params:@{@"uid" : kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg)
    {
        if (![msg isEqualToString:@"暂无数据"]) {
            for (NSDictionary *dict in requestDic)
            {
                
                AddressInfo *address = [AddressInfo yy_modelWithJSON:dict];
                if (address.home.integerValue == 1)
                {
                    infos = address;
                    break;
                    [self.table reloadData];
                }
            }
        }
    }
                      fail:^(NSString *error)
    {
        
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

@end
