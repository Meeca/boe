//
//  ZTXQViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZTXQViewController.h"
#import "ZTModel.h"
#import "YXScrollowActionSheet.h"
#import "XiangQingViewController.h"
#import "HomeModel.h"
#import "HomeCellView.h"
#import "TopModel.h"
#import "MingRenCell.h"
#import "XiangQingViewController.h"
#import "ShareModel.h"
#import "UIImage+MJ.h"

#import "Masonry.h"

@interface ZTXQViewController () <UITableViewDelegate, UITableViewDataSource,YXScrollowActionSheetDelegate> {
    ZTModel *ztModel;
    
    SpecialInfo *_specialInfo;
    UIImage * _shareImage;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ZTXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"专题";
    ztModel = [ZTModel modelWithObserver:self];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -13, 2, 17)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0, 0, 44, 44);
    [share setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    [share setImageEdgeInsets:UIEdgeInsetsMake(2, 17, 2, -13)];
    [share addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    [self addHeader];
}

- (void)addHeader {
    [ztModel app_php_Finds_special_read:self.s_id];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ztModel app_php_Finds_special_read:self.s_id];
    }];
}

ON_SIGNAL3(ZTModel, SPECIALREAD, signal) {
    [self.table.mj_header endRefreshing];
    
    _specialInfo = signal.object;
    
    
    [UIImage loadImageWithUrl:_specialInfo.image returnImage:^(UIImage *image) {
        _shareImage = image;
    }];
    
    
    [self.table reloadData];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.clipsToBounds = YES;
    
    if (indexPath.row==0) {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        [icon sd_setImageWithURL:[NSURL URLWithString:_specialInfo.u_image] placeholderImage:KZHANWEI];
        icon.layer.cornerRadius = icon.width/2;
        icon.layer.masksToBounds = YES;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:icon];
        icon.x = tableView.separatorInset.left;
        icon.centerY = [self tableView:tableView heightForRowAtIndexPath:indexPath]/2;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:name];
        name.textColor = [UIColor darkGrayColor];
        name.text = _specialInfo.nike.length>0?_specialInfo.nike:@"无昵称";
        [name sizeToFit];
        name.centerY = icon.centerY;
        name.x = icon.right + 10;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@次阅读", _specialInfo.time.length>0?_specialInfo.time:@"未知时间", _specialInfo.read_num.length>0?_specialInfo.read_num:@"0"];
    } else if (indexPath.row==1) {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:img];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(cell.contentView);
            make.height.equalTo(cell.contentView);
            make.center.equalTo(cell.contentView);
        }];
        
        [img sd_setImageWithURL:[NSURL URLWithString:_specialInfo.image] placeholderImage:KZHANWEI];
    } else if (indexPath.row==2) {
        cell.textLabel.text = _specialInfo.title.length>0?_specialInfo.title:@"未知";
    } else if (indexPath.row==3) {
        CGFloat height = [Tool getLabelSizeWithText:_specialInfo.content.length>0?_specialInfo.content:@"暂无内容" AndWidth:KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left AndFont:[UIFont systemFontOfSize:15] attribute:nil].height;
        
        UILabel *context = [[UILabel alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, 0, KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left, height)];
        context.font = [UIFont systemFontOfSize:15];
        context.text = _specialInfo.content.length>0?_specialInfo.content:@"暂无内容";
        context.textColor = [UIColor grayColor];
        context.numberOfLines = 0;
        [cell.contentView addSubview:context];
    }
    
    return cell;
}
#pragma mark -------点击图片进入图片详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//
//    if (indexPath.row == 1) {
//        NSLog(@"你点击了图片详情 ---  %@ ----  \n   %ld",ztModel.recommends,indexPath.row);
//    
//        ArtistWorkList *f = ztModel.recommends[0];
//        XiangQingViewController *vc = [[XiangQingViewController alloc] init];
//        vc.p_id = f.p_id ;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
////    }
//
    
    
    NSLog(@"你点击了图片详情 ---  %@ ----  \n   %ld",ztModel.recommends,indexPath.row);
    
    SpecialInfo * specialInfo = ztModel.recommends[0];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
    vc.p_id =specialInfo.p_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 55;
    } else if (indexPath.row==1) {
        return KSCALE(650);
    } else if (indexPath.row==2) {
        return 50;
    } else if (indexPath.row==3) {
        return [Tool getLabelSizeWithText:_specialInfo.content.length>0?_specialInfo.content:@"暂无内容" AndWidth:KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left AndFont:[UIFont systemFontOfSize:15] attribute:nil].height+10;
    }
    return 0;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnAction {
    NSLog(@"分享");
    YXScrollowActionSheet *cusSheet = [[YXScrollowActionSheet alloc] init];
    cusSheet.delegate = self;
    NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"}];
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];
    

}
#pragma mark ------分享代理
#pragma mark - YXScrollowActionSheetDelegate
- (void) scrollowActionSheetButtonClick:(YXActionSheetButton *) btn
{
    NSLog(@"第%li个按钮被点击了",(long)btn.tag);
    
    NSInteger index = btn.tag;
    
    [ShareModel shareUMengWithVC:self withPlatform:index withTitle:_specialInfo.title withShareTxt:_specialInfo.content withImage:_shareImage withID:_specialInfo.s_id withType:4 withUrl:nil success:^(NSDictionary *requestDic) {
        
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

@end
