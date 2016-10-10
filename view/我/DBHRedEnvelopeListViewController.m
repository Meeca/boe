//
//  DBHRedEnvelopeListViewController.m
//  Jiatingquan
//
//  Created by DBH on 16/9/20.
//  Copyright © 2016年 邓毕华. All rights reserved.
//

#import "DBHRedEnvelopeListViewController.h"

#import "DBHRedEnvelopeListTableViewCell.h"

#import "DBHRedEnveloPeListHeaderView.h"

#import "DBHRedEnvelopeListDataModels.h"

#import "Masonry.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))
#define  SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width

static NSString * const kRedEnvelopeListTableViewCellIdentifier = @"kRedEnvelopeListTableViewCellIdentifier";
static NSString * const kRedEnvelopeListYearTableViewCellIdentifier = @"kRedEnvelopeListYearTableViewCellIdentifier";

@interface DBHRedEnvelopeListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *yearTableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) DBHRedEnveloPeListHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *yearData;

@property (nonatomic, strong) DBHRedEnvelopeListModelInfo *infoModel;

@property (nonatomic, assign) NSInteger currenPage;
@property (nonatomic, strong) NSString *year;

@end

@implementation DBHRedEnvelopeListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收到打赏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
    [self loadDataWithRefreshType:YES];
}

#pragma mark - ui
- (void)setUI {
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
}

#pragma mark - data
- (void)loadDataWithRefreshType:(BOOL)refreshType {
    if (refreshType) {
        _currenPage = 1;
    } else {
        _currenPage += 1;
    }
    NSString *path = @"/app.php/User/reward_list";
    NSMutableDictionary *params = [@{@"uid":kUserId, @"page":@(_currenPage), @"pagecount":@(10)} mutableCopy];
    if (_year) {
        [params setObject:[NSString stringWithFormat:@"%@年", _year] forKey:@"years"];
    }
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        self.infoModel = [DBHRedEnvelopeListModelInfo modelObjectWithDictionary:requestDic];
        for (NSDictionary *dic in requestDic[@"r_list"]) {
            DBHRedEnvelopeListModelRList *model = [DBHRedEnvelopeListModelRList modelObjectWithDictionary:dic];
            
            [self.datasource addObject:model];
        }
        
        [_tableView reloadData];
    } fail:^(NSString *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return self.datasource.count;
    } else {
        return self.yearData.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        DBHRedEnvelopeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRedEnvelopeListTableViewCellIdentifier forIndexPath:indexPath];
        DBHRedEnvelopeListModelRList *model = self.datasource[indexPath.row];
        cell.model = model;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRedEnvelopeListYearTableViewCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.yearData[indexPath.row];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _yearTableView) {
        _year = self.yearData[indexPath.row];
        [self loadDataWithRefreshType:YES];
        [self hideYearTableView];
    }
}

#pragma mark - event responds
- (void)respondsToTapGR {
    [self hideYearTableView];
}

#pragma mark - private methods
- (void)showYearTableView {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC.view addSubview:self.bottomView];
    [rootVC.view addSubview:self.yearTableView];

    [_yearTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(AUTOLAYOUTSIZE(AUTOLAYOUTSIZE(70)));
        make.height.offset(AUTOLAYOUTSIZE(50) * self.yearData.count);
        make.top.offset(AUTOLAYOUTSIZE(115));
        make.right.offset(- AUTOLAYOUTSIZE(10));
    }];
}
- (void)hideYearTableView {
    [_yearTableView removeFromSuperview];
    [_bottomView removeFromSuperview];
}

#pragma mark - getters and setters
- (void)setInfoModel:(DBHRedEnvelopeListModelInfo *)infoModel {
    _infoModel = infoModel;
    
    _headerView.model = _infoModel;
}
- (DBHRedEnveloPeListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DBHRedEnveloPeListHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, AUTOLAYOUTSIZE(260))];
        [_headerView clickButtonBlock:^{
            [self showYearTableView];
        }];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _tableView.rowHeight = AUTOLAYOUTSIZE(75);
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[DBHRedEnvelopeListTableViewCell class] forCellReuseIdentifier:kRedEnvelopeListTableViewCellIdentifier];
    }
    return _tableView;
}
- (UITableView *)yearTableView {
    if (!_yearTableView) {
        _yearTableView = [[UITableView alloc] init];
        _yearTableView.backgroundColor = [UIColor whiteColor];
        
        _yearTableView.layer.cornerRadius = AUTOLAYOUTSIZE(5);
        
        _yearTableView.rowHeight = AUTOLAYOUTSIZE(50);
        
        _yearTableView.dataSource = self;
        _yearTableView.delegate = self;
        
        [_yearTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kRedEnvelopeListYearTableViewCellIdentifier];
    }
    return _yearTableView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapGR)];
        [_bottomView addGestureRecognizer:tapGR];
    }
    return _bottomView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (NSMutableArray *)yearData {
    if (!_yearData) {
        _yearData = [NSMutableArray array];
        [_yearData addObject:@"2016"];
    }
    return _yearData;
}

@end
