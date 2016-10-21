//
//  DBHBuyPictureFrameViewController.m
//  jingdongfang
//
//  Created by DBH on 16/9/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "DBHBuyPictureFrameViewController.h"
#import "TLChatViewController.h"
#import "QueRenViewController.h"

#import "DBHBuyPictureFrameView.h"

#import "DBHBuyPictureFrameInfoTableViewCell.h"
#import "DBHBuyPictureFrameImageTableViewCell.h"

#import "Masonry.h"

#import "DBHBuyPictureFrameDataModels.h"
#import "DBHBuyPictureFrameSizeInfoDataModels.h"


#import "DBHBuyPictureFrameModel.h"


#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

static NSString * const kBuyPictureFrameInfoTableViewCellIdentifier = @"kBuyPictureFrameInfoTableViewCellIdentifier";
static NSString * const kBuyPictureFrameImageTableViewCellIdentifier = @"kBuyPictureFrameImageTableViewCellIdentifier";

@interface DBHBuyPictureFrameViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DBHBuyPictureFrameView *buyPictureFrameView;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) DBHBuyPictureFrameModel *model;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *pictureFrameSizeArray;
@property (nonatomic, strong) NSMutableArray *pictureFrameBorderArray;

@property (nonatomic, strong) NSMutableArray *imageHeightArray;;



@end

@implementation DBHBuyPictureFrameViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iGallery高清电子画框";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageHeightArray = [NSMutableArray new];
    
    
    [self setUI];
    [self loadData];
}

#pragma mark - ui
- (void)setUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buyButton];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.bottom.equalTo(_buyButton.mas_top);
    }];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.offset(AUTOLAYOUTSIZE(44));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - data
- (void)loadData {
    NSString *urlString = @"/app.php/Index/arrti_read";
    NSDictionary *paramters = @{};
    
    [MCNetTool postWithUrl:urlString params:paramters hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        _model = [DBHBuyPictureFrameModel mj_objectWithKeyValues:requestDic];
        
        [_tableView reloadData];
        
    } fail:^(NSString *error) {
        
    }];
}
- (void)loadPictureFrameInfoWityType:(NSString *)type {
    NSString *urlString = @"/app.php/Index/arrti";
    NSDictionary *paramters = @{@"types":type};
    
    [MCNetTool postWithUrl:urlString params:paramters hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        for (NSDictionary *dic in requestDic) {
            DBHBuyPictureFrameSizeInfoModelInfo *model = [DBHBuyPictureFrameSizeInfoModelInfo modelObjectWithDictionary:dic];
            
            if ([type isEqualToString:@"1"]) {
                [self.pictureFrameSizeArray addObject:model];
            } else {
                [self.pictureFrameBorderArray addObject:model];
            }
        }
        
        if ([type isEqualToString:@"1"]) {
            [self loadPictureFrameInfoWityType:@"2"];
        } else {
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            [rootVC.view addSubview:self.buyPictureFrameView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_buyPictureFrameView viewShow];
            });
        }
    } fail:^(NSString *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.all_image.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DBHBuyPictureFrameInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBuyPictureFrameInfoTableViewCellIdentifier forIndexPath:indexPath];
        cell.model = _model;
        return cell;
    } else {
        DBHBuyPictureFrameImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBuyPictureFrameImageTableViewCellIdentifier forIndexPath:indexPath];
        All_Image * image = _model.all_image[indexPath.row - 1];
        cell.image = image.a_image;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.view endEditing:YES];
        
        UIControl *ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 20, KSCREENWIDTH, KSCREENHEIGHT-20)];
        ctrl.backgroundColor = RGB(66, 66, 66);
        [ctrl addTarget:self action:@selector(hiddenCtrl:) forControlEvents:UIControlEventTouchUpInside];
        
        DBHBuyPictureFrameInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:cell.topImageView.image];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        imgView.layer.borderWidth = 15;
        imgView.layer.masksToBounds = YES;
        [ctrl addSubview:imgView];
        
        //        if ([detailsInfo.plates integerValue]==1) { // 横屏
        //            imgView.frame = CGRectMake(0, 0, (KSCREENWIDTH-80)*1920/1080, KSCREENWIDTH-80);
        //            imgView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        //        } else {  //竖屏
        imgView.frame = CGRectMake(0, 0, KSCREENWIDTH-80, (KSCREENWIDTH-80)*1920/1080);
        //        }
        imgView.center = CGPointMake(ctrl.width/2, ctrl.height/2);
        
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win addSubview:ctrl];
        ctrl.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            ctrl.alpha = 1;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row ==0){
        return AUTOLAYOUTSIZE(373);
    }
    All_Image * image = _model.all_image[indexPath.row - 1];
    CGFloat height = SCREENWIDTH / image.kuan  * image.gao;
    return height;
}



#pragma mark - event responds
- (void)hiddenCtrl:(UIControl *)ctrl {
    [UIView animateWithDuration:.3 animations:^{
        ctrl.alpha = 0;
    } completion:^(BOOL finished) {
        [ctrl removeFromSuperview];
    }];
}
- (void)sixinAction:(UIButton *)btn
{
    NSLog(@"你点击了私信");
    TLChatViewController *vc = [TLChatViewController new];
    //    vc.userId = _model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)buyAction:(UIButton *)btn {
    // 立即购买
    [self loadPictureFrameInfoWityType:@"1"];
}

#pragma mark - private methods
- (void)buyPictureFrameWithShopInfo:(DetailsInfo *)model {
    QueRenViewController *vc = [[QueRenViewController alloc] init];
    vc.isBuyPictureFrame = YES;
    
    model.u_name = _model.title;
    model.p_id = _model.p_id;
    model.image = _model.image;
    vc.info = model;
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getters and setters
//- (void)setModel:(DBHBuyPictureFrameModel *)model {
//    _model = model;
//
////    _imageArray = [_model.allImage componentsSeparatedByString:@"-"];
//
//
//
//    [_tableView reloadData];
//}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[DBHBuyPictureFrameInfoTableViewCell class] forCellReuseIdentifier:kBuyPictureFrameInfoTableViewCellIdentifier];
        [_tableView registerClass:[DBHBuyPictureFrameImageTableViewCell class] forCellReuseIdentifier:kBuyPictureFrameImageTableViewCellIdentifier];
    }
    return _tableView;
}
- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = KAPPCOLOR;
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _buyButton;
}
- (DBHBuyPictureFrameView *)buyPictureFrameView {
    if (!_buyPictureFrameView) {
        _buyPictureFrameView = [[DBHBuyPictureFrameView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _buyPictureFrameView.pictureFrameSizeArray = self.pictureFrameSizeArray;
        _buyPictureFrameView.pictureFrameBorderArray = self.pictureFrameBorderArray;
        
        [_buyPictureFrameView clickBuyButtonBlock:^(DetailsInfo *model) {
            [self buyPictureFrameWithShopInfo:model];
        }];
    }
    return _buyPictureFrameView;
}

- (NSMutableArray *)pictureFrameSizeArray {
    if (!_pictureFrameSizeArray) {
        _pictureFrameSizeArray = [NSMutableArray array];
    }
    return _pictureFrameSizeArray;
}
- (NSMutableArray *)pictureFrameBorderArray {
    if (!_pictureFrameBorderArray) {
        _pictureFrameBorderArray = [NSMutableArray array];
    }
    return _pictureFrameBorderArray;
}




















@end
