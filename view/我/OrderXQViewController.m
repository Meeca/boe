//
//  OrderXQViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "OrderXQViewController.h"
#import "ListTableViewCell.h"
//#import "PayAgainViewController.h"

#import "QueRenViewController.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface OrderXQViewController () <UITableViewDelegate, UITableViewDataSource> {
    UserModel *userModel;
    
    OrderInfo *info;
    
    UIButton *bottomBtn;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation OrderXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.table.backgroundColor = RGB(234, 234, 234);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.width, 10)];
    view.backgroundColor = self.table.backgroundColor;
    self.table.tableHeaderView = view;
    
    userModel = [UserModel modelWithObserver:self];
    
    [self addHeader];
}

- (void)addHeader {
    if (self.isMyBuy) {
        [userModel app_php_User_pre_read:self.o_id];
    } else {
        [userModel app_php_User_pay_read:self.o_id];
    }
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.isMyBuy) {
            [userModel app_php_User_pre_read:self.o_id];
        } else {
            [userModel app_php_User_pay_read:self.o_id];
        }
    }];
}

ON_SIGNAL3(UserModel, POSTCOMD, signal) {
    if (self.isMyBuy) {
        [userModel app_php_User_pre_read:self.o_id];
    } else {
        [userModel app_php_User_pay_read:self.o_id];
    }
}

ON_SIGNAL3(UserModel, PREREAD, signal) {
    [self.table.mj_header endRefreshing];
    info = signal.object;
    [self.table reloadData];
    
    [self cheak];
}

ON_SIGNAL3(UserModel, PAYREAD, signal) {
    [self.table.mj_header endRefreshing];
    info = signal.object;
    [self.table reloadData];
    
    [self cheak];
}

- (void)cheak {
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (!bottomBtn) {
        bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.backgroundColor = KAPPCOLOR;
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:bottomBtn];
        
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.height.offset(AUTOLAYOUTSIZE(50));
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    bottomBtn.hidden = YES;
    NSLog(@"%@",info.state);
    
    if ([info.state integerValue]==0) {  //未支付
        self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
        
        NSDate *currenDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timeInterval = [currenDate timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%.0f", timeInterval];
        
        __block NSInteger time = 1800 - (timeString.integerValue - info.created_at.integerValue);
        NSString *date = [NSString stringWithFormat:@"去支付（剩余%ld分", time / 60];
        [date stringByAppendingString:time % 60 == 0 ? @"）" : [NSString stringWithFormat:@"%ld秒）", time % 60]];
        [bottomBtn setTitle:date forState:UIControlStateNormal];
        
        // 创建一个派发队列 优先级是默认
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (time <= 0) { // 倒计时结束 关闭
                
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    bottomBtn.hidden = YES;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 设置按钮显示读秒效果
                    NSString *date = [NSString stringWithFormat:@"去支付（剩余%ld分", time / 60];
                    date = [date stringByAppendingString:time % 60 == 0 ? @"）" : [NSString stringWithFormat:@"%ld秒）", time % 60]];
                    [bottomBtn setTitle:date forState:UIControlStateNormal];
                    
                });
                time--;
            }
        });
        dispatch_resume(_timer);
        
        bottomBtn.hidden = NO;
    } else if ([info.state integerValue]==1) {  //已支付
        
        
    } else if ([info.state integerValue]==2) {  //未发货
        
        
    } else if ([info.state integerValue]==3) {  //已发货
        
        
    } else if ([info.state integerValue]==4) {  //确认收货
        self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
        [bottomBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        bottomBtn.hidden = NO;
    }
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cel = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cel.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        UILabel *mun = [[UILabel alloc] initWithFrame:CGRectZero];
        mun.font = [UIFont systemFontOfSize:15];
        mun.text = [NSString stringWithFormat:@"订单号：%@", info.orders.length>0?info.orders:@" "];
        [mun sizeToFit];
        [cel.contentView addSubview:mun];
        
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectZero];
        state.font = [UIFont systemFontOfSize:15];
        state.textColor = KAPPCOLOR;
        if ([info.state integerValue]==0) {  //未支付
            state.text = @"等待付款";
        } else if ([info.state integerValue]==1) {  //已支付
            state.text = @"等待发货";
        } else if ([info.state integerValue]==2) {  //未发货
            state.text = @"等待发货";
        } else if ([info.state integerValue]==3) {  //已发货
            state.text = @"待确认收货";
        } else if ([info.state integerValue]==4) {  //确认收货
            state.text = @"已完成";
            state.textColor = [UIColor blackColor];
        }
        [state sizeToFit];
        [cel.contentView addSubview:state];

        UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
        time.font = [UIFont systemFontOfSize:13];
        time.textColor = [UIColor grayColor];
        time.text = [@"下单时间：" stringByAppendingString:[Tool timestampToString:info.created_at Format:@"yyyy-MM-dd HH:mm:ss"]];
        [time sizeToFit];
        [cel.contentView addSubview:time];
        
        mun.x = 15;
        mun.y = (h-mun.height-time.height-10)/2;
        
        time.x = mun.x;
        time.y = mun.bottom + 10;
        
        state.right = KSCREENWIDTH - 15;
        state.top = mun.top;
    } else if (indexPath.section==1) {
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectZero];
        state.font = [UIFont systemFontOfSize:15];
        state.text = [NSString stringWithFormat:@"配送方式：%@", info.order_type.length>0?info.order_type:@" "];
        [state sizeToFit];
        [cel.contentView addSubview:state];
        
        UILabel *mun = [[UILabel alloc] initWithFrame:CGRectZero];
        mun.font = [UIFont systemFontOfSize:15];
        mun.text = [NSString stringWithFormat:@"运单编号：%@", info.state_order.length>0?info.state_order:@" "];
        [mun sizeToFit];
        [cel.contentView addSubview:mun];
        
        state.x = 15;
        state.y = (h-state.height-mun.height-10)/2;
        
        mun.x = state.x;
        mun.y = state.bottom + 10;
    } else if (indexPath.section==2) {
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = [UIFont systemFontOfSize:15];
        name.text = [NSString stringWithFormat:@"收货人：%@", info.s_name.length>0?info.s_name:@" "];
        [name sizeToFit];
        [cel.contentView addSubview:name];
        
        UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
        tel.font = [UIFont systemFontOfSize:15];
        tel.text = [NSString stringWithFormat:@"%@", info.s_tel.length>0?info.s_tel:@" "];
        [tel sizeToFit];
        [cel.contentView addSubview:tel];
        
        UILabel *adderss = [[UILabel alloc] initWithFrame:CGRectZero];
        adderss.font = [UIFont systemFontOfSize:15];
        adderss.text = [NSString stringWithFormat:@"收货地址：%@", info.s_address.length>0?info.s_address:@" "];
        [adderss sizeToFit];
        [cel.contentView addSubview:adderss];
        if (adderss.width>KSCREENWIDTH-30) {
            adderss.width = KSCREENWIDTH-30;
        }
        
        name.x = 15;
        name.y = (h-name.height-adderss.height-10)/2;
        
        adderss.x = name.x;
        adderss.y = name.bottom + 10;
        
        tel.right = KSCREENWIDTH - 15;
        tel.top = name.top;
    } else if (indexPath.section==3) {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oredrCell"];
        if (cell==nil) {
            cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"oredrCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.data = info;
        [cell setNeedsLayout];
        return cell;
    }
    return cel;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==3) {
        CGFloat h = [self tableView:tableView heightForHeaderInSection:section];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, h)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
        img.image = [UIImage imageNamed:@"切图 20160719-3"];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.centerY = h/2;
        [view addSubview:img];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.text = info.nike.length>0?info.nike:@" ";
        name.font = [UIFont systemFontOfSize:15];
        [name sizeToFit];
        [view addSubview:name];
        name.x = img.right+8;
        name.centerY = h/2;
        
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==3) {
        CGFloat h = [self tableView:tableView heightForFooterInSection:section];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, h)];
        view.backgroundColor = RGB(234, 234, 234);
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, h-10)];
        v.backgroundColor = [UIColor whiteColor];
        [view addSubview:v];
        
        UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
        msg.font = [UIFont systemFontOfSize:15];
        [view addSubview:msg];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectZero];
        price.font = [UIFont systemFontOfSize:18];
        [view addSubview:price];
        
        msg.text = @"共1件商品  合计：";
        [msg sizeToFit];
        
        price.text = [NSString stringWithFormat:@"￥%@", info.price.length>0?info.price:@"0"];
        [price sizeToFit];
        price.right = view.width-15;
        price.centerY = (view.height-10)/2;
        
        msg.right = price.left;
        msg.bottom = price.bottom;
        
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==3) {
        return 50;
    }
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==3) {
        return 60;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==3) {
        return 80;
    }
    return 70;
}

- (void)bottomBtnAction:(UIButton *)btn {
    if ([info.state integerValue]==0) {  //未支付
        QueRenViewController *vc = [[QueRenViewController alloc] init];
        DetailsInfo *detailsInfo = [[DetailsInfo alloc] init];
        
        detailsInfo.material_price = info.price;
        detailsInfo.image = info.image;
        detailsInfo.image_url = info.image_url;
        detailsInfo.u_id = info.u_id;
        detailsInfo.p_id = info.p_id;
        detailsInfo.electronic_price = info.price;
        
        vc.info = detailsInfo;
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
//        PayAgainViewController *vc = [[PayAgainViewController alloc] init];
//        vc.info = info;
//        [Tool setBackButtonNoTitle:self];
//        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([info.state integerValue]==1) {  //已支付
        
        
    } else if ([info.state integerValue]==2) {  //未发货
        
        
    } else if ([info.state integerValue]==3) {  //已发货
        
        
    } else if ([info.state integerValue]==4) {  //确认收货
        [userModel app_php_User_post_comd:self.o_id];
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
