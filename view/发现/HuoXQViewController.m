//
//  HuoXQViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "HuoXQViewController.h"
#import "HuoDongModel.h"
#import "YXScrollowActionSheet.h"
#import "ShareModel.h"

@interface HuoXQViewController () <UITableViewDelegate, UITableViewDataSource,YXScrollowActionSheetDelegate> {
    HuoDongModel *model;
    UIImage * _shareImage;
    SpecialInfo *info;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HuoXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"活动与展览";
    model = [HuoDongModel modelWithObserver:self];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, -13, 2, 17)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
#pragma mark -------- 分享删除
//    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
//    share.frame = CGRectMake(0, 0, 44, 44);
//    [share setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
//    [share setImageEdgeInsets:UIEdgeInsetsMake(2, 17, 2, -13)];
//    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    [self addHeader];
   
}


- (void)loadImage
{
    UIImageView * pliceHoader = [UIImageView new];

        
        [pliceHoader sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            _shareImage = image;
        }];
    


}

- (void)addHeader {
    [model app_php_Finds_activity_read:self.s_id];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [model app_php_Finds_activity_read:self.s_id];
    }];
}

ON_SIGNAL3(HuoDongModel, ACTIVITYREAD, signal) {
    [self.table.mj_header endRefreshing];
    
    info = signal.object;
     [self loadImage];
    [self.table reloadData];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    if (indexPath.row==0) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:img];
        
        [img sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    } else if (indexPath.row==1) {
        cell.textLabel.text = info.title.length>0?info.title:@"未知";
    } else if (indexPath.row==2) {
        CGFloat height = [Tool getLabelSizeWithText:info.content.length>0?info.content:@"暂无内容" AndWidth:KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left AndFont:[UIFont systemFontOfSize:15] attribute:nil].height;
        
        UILabel *context = [[UILabel alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, 0, KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left, height)];
        context.font = [UIFont systemFontOfSize:15];
        context.text = info.content.length>0?info.content:@"暂无内容";
        context.textColor = [UIColor grayColor];
        context.numberOfLines = 0;
        [cell.contentView addSubview:context];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return KSCALE(650);
    } else if (indexPath.row==1) {
        return 50;
    } else if (indexPath.row==2) {
        return [Tool getLabelSizeWithText:info.content.length>0?info.content:@"暂无内容" AndWidth:KSCREENWIDTH-tableView.separatorInset.left-tableView.separatorInset.left AndFont:[UIFont systemFontOfSize:15] attribute:nil].height+10;
    }
    return 0;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share {
#pragma mark ---------分享
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
    [ShareModel shareUMengWithVC:self withPlatform:btn.tag withTitle:info.title withShareTxt:info.content withImage:_shareImage withID:info.s_id withType:4 withUrl:nil success:^(NSDictionary *requestDic) {
        
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
