//
//  BillViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BillViewController.h"
#import "BillModel.h"
#import "BillTableViewCell.h"
#import "hzy.h"
#import "CheckExceptionalViewController.h"
#import "checkModel.h"

#import "DBHRedEnvelopeView.h"
#import "Masonry.h"
#import "DBHRedEnvelopeListViewController.h"

#import "DBHRedEnvelopeDataModels.h"

@interface BillViewController () <UITableViewDelegate, UITableViewDataSource> {
    checkModel *check;
    BillModel *billModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"帐单";
    
    billModel = [BillModel modelWithObserver:self];
    self.table.separatorInset = UIEdgeInsetsMake(0, KSCREENWIDTH, 0, 0);
    [self addHeader];
    [self addFooter];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedDaShang:) name:kRecivedDaShang object:nil];
}

- (void)addHeader {
    [billModel firstPage];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [billModel firstPage];
    }];
}

- (void)addFooter {
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [billModel nextPage];
    }];
}

ON_SIGNAL3(BillModel, RELOADED, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    [self.table.mj_footer resetNoMoreData];
    if (billModel.loaded) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }
    [self.table reloadData];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return billModel.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"billCell"];
    if (cell==nil) {
        cell = [[BillTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"billCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.data = billModel.recommends[indexPath.row];
    [cell setNeedsLayout];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CapitalFlow *info = billModel.recommends[indexPath.row];
    if ([info.types integerValue]==3 && [info.type isEqualToString:@"1"]) {
        [self loadDataWithId:info.o_id];
    }
}
- (void)jumpPageWithUserId:(NSString *)userId {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    DBHRedEnvelopeListViewController *redEnvelopeListVC = [[DBHRedEnvelopeListViewController alloc] init];
    redEnvelopeListVC.userId = userId;
    [self.navigationController pushViewController:redEnvelopeListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReceivedDaShang
- (void)loadDataWithId:(NSString *)orderId {
    NSString *path = @"/app.php/User/reward";
    NSDictionary *params = @{@"o_id":orderId};
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        DBHRedEnvelopeModelInfo *model = [DBHRedEnvelopeModelInfo modelObjectWithDictionary:requestDic];
        
        DBHRedEnvelopeView *redEnvelopeView = [[DBHRedEnvelopeView alloc] init];
        redEnvelopeView.model = model;
        
        [redEnvelopeView clickButtonBlock:^(NSString *userId) {
            [self jumpPageWithUserId:userId];
        }];
        
        [self.view addSubview:redEnvelopeView];
        
        [redEnvelopeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.offset(0);
        }];
        
    } fail:^(NSString *error) {
        
    }];
}
- (void)receivedDaShang:(NSNotification *)noti {
    NSString *nid = noti.object;
    
    [self loadDataWithId:nid];
    
//    NSString *path = @"/app.php/User/reward";
//    NSDictionary *params = @{
//                             @"o_id":nid,
//                             
//                             };
//    
//    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
//        
//        check = [checkModel yy_modelWithJSON:requestDic];
//        
//        CheckExceptionalViewController *checkDetail = [[UIStoryboard storyboardWithName:@"Check" bundle:nil]instantiateViewControllerWithIdentifier:@"CheckExceptionalViewController"];
//        
//        
//        checkDetail.uid = check.uid;
//        checkDetail.nike = check.nike;
//        checkDetail.price = check.price;
//        checkDetail.image = check.image;
//        checkDetail.content = check.content;
//        
//        [self.navigationController pushViewController:checkDetail animated:YES];
//        
//    } fail:^(NSString *error) {
//        
//    }];
//    //延迟一秒显示
//    [Tool performBlock:^{
//        // 收到打赏红包的推送 显示页面
//    } afterDelay:1];
}


@end
