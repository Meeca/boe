//
//  IntroViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "IntroViewController.h"
#import "MingRenSlider.h"
#import "ZPViewController.h"
#import "JJViewController.h"
#import "GZViewController.h"
#import "FSViewController.h"
#import "ShareModel.h"
#import "UIImage+MJ.h"
#import "YXScrollowActionSheet.h"
#import "TLChatViewController.h"
#import "ShangViewController.h"
#define followBtnTag 494

@interface IntroViewController () <MingRenSliderVCDelegate,YXScrollowActionSheetDelegate> {
    UIImageView *background;
    UIImageView *icon;
    UILabel *name;
    
    MingRenSlider *slider;
    ArtistInfo *infos;
    
    UIImageView *shadowImageView;
    NSInteger userSelectedChannelID;
    
    UIView *header;
    DetailsInfo * detailsInfo;
    UIView *footer;
    
    ZPViewController *vc1;
    JJViewController *vc2;
    GZViewController *vc3;
    FSViewController *vc4;
    
    UserModel *userModel;
    
    
    UIImage * _shareImage;
    
}

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    userModel = [UserModel modelWithObserver:self];
    
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, KSCREENWIDTH, INTROHEIGHT)];
    background.image = [UIImage imageNamed:@"个人主页bj1"];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.clipsToBounds = YES;
    [self.view addSubview:background];
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.layer.borderWidth = 1;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.layer.cornerRadius = icon.width/2;
    icon.layer.masksToBounds = YES;
    [background addSubview:icon];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.text = @"用户昵称";
    name.font = [UIFont boldSystemFontOfSize:17];
    name.textColor = [UIColor whiteColor];
    [background addSubview:name];
    [name sizeToFit];
    
    icon.y = (background.height-icon.height-name.height-10)/2;
    icon.centerX = background.width/2;
    name.y = icon.bottom+10;
    name.centerX = background.width/2;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(3, 20, 48, 48);
    [backBtn setImage:[UIImage imageNamed:@"A-sousuo-1"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0, 22, 48, 48);
    [share setImage:[UIImage imageNamed:@"A-fenxiang-1"] forState:UIControlStateNormal];
    [share setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [share addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    share.right=KSCREENWIDTH-3;
    
    slider = [[MingRenSlider alloc] initWithFrame:CGRectMake(0, INTROHEIGHT+20, KSCREENWIDTH, KSCREENHEIGHT-49-20-INTROHEIGHT)];
    slider.slideSwitchViewDelegate = self;
    slider.tabItemNormalColor = [UIColor blackColor];
    slider.tabItemSelectedColor = KAPPCOLOR;
    
    [self.view addSubview:slider];
    
    [slider buildUI];
    
    [slider addObserver:self forKeyPath:@"userSelectedChannelID" options:NSKeyValueObservingOptionNew context:NULL];
    userSelectedChannelID = 100;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, INTROHEIGHT+20, KSCREENWIDTH, 44)];
    shadowImageView = [[UIImageView alloc] init];
    shadowImageView.backgroundColor = slider.tabItemSelectedColor;
    [header addSubview:shadowImageView];
    
//    NSArray *title = @[@"简介", @"作品", @"关注", @"粉丝"];
    NSArray *title = @[ @"作品",@"简介", @"关注", @"粉丝"];

    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(KSCREENWIDTH/4*i, 0, KSCREENWIDTH/4, 44)];
        
        //计算下一个tab的x偏移量
        [button setTag:i+100];
        if (i == 0) {
            shadowImageView.frame = CGRectMake(0, button.height-2, button.width-10, 2);
            shadowImageView.centerX = button.centerX;
            shadowImageView.bottom = button.bottom;
            button.selected = YES;
        }
        [button setTitle:title[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:slider.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:slider.tabItemSelectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:button];
    }
    header.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, header.height-0.5, header.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:line];

    [self.view addSubview:header];
    
    NSArray *titleArr = @[@"＋  关注", @"私信", @"打赏"];
    NSArray *imgs = @[@"GALLERY icon  20160620-15", @"GALLERY icon  20160620-16"];
    footer = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT-49, KSCREENWIDTH, 49)];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(KSCREENWIDTH/3*i, 0, KSCREENWIDTH/3, 49);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = followBtnTag+i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:btn];
        if (i==0) {
            continue;
        }
        [btn setImage:[UIImage imageNamed:imgs[i-1]] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
    }
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH/3, (49-28)/2, 1, 28)];
    line1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.5];
    [footer addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH/3*2, (49-28)/2, 1, 28)];
    line2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.5];
    [footer addSubview:line2];
    
    [self.view addSubview:footer];
    
    [self loadModel];
}

ON_SIGNAL3(UserModel, COLLECTIONADD, signal) {
    infos.collection = @"1";
    infos.fans = [NSString stringWithFormat:@"%@",@([infos.fans integerValue]+1)];
    [self upDateBtn:infos];
}

ON_SIGNAL3(UserModel, COLLECTIONDEL, signal) {
    infos.collection = @"0";
    infos.fans = [NSString stringWithFormat:@"%@",@([infos.fans integerValue]-1)];
    [self upDateBtn:infos];
}

- (void)upDateBtn:(ArtistInfo *)info {
    UIButton *follow = [footer viewWithTag:followBtnTag];
    
    if ([info.collection integerValue]==1) { //是否 关注  0=未关注，1=已关注
        [follow setTitle:@"已关注" forState:UIControlStateNormal];
        [follow setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        [follow setTitle:@"＋  关注" forState:UIControlStateNormal];
        [follow setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    }
    
    NSString *zpUnm = [NSString stringWithFormat:@"作品 %@", info.works_num.length>0?info.works_num:@"0"];
    NSString *gzUnm = [NSString stringWithFormat:@"关注 %@", info.collection_num.length>0?info.collection_num:@"0"];
    NSString *fansUnm = [NSString stringWithFormat:@"粉丝 %@", info.fans.length>0?info.fans:@"0"];
    
    for (UIView *sub in header.subviews) {
        if (sub.tag == 100) { // 作品
            [(UIButton *)sub setTitle:zpUnm forState:UIControlStateNormal];
        }else
        if (sub.tag == 101) { // 作品
            [(UIButton *)sub setTitle:@"简介" forState:UIControlStateNormal];
        } else if (sub.tag == 102) { // 关注
            [(UIButton *)sub setTitle:gzUnm forState:UIControlStateNormal];
        } else if (sub.tag == 103) { // 粉丝
            [(UIButton *)sub setTitle:fansUnm forState:UIControlStateNormal];
        }
    }
}

- (void)btnAction:(UIButton *)btn {
    if (btn.tag-followBtnTag==0) {  // 关注
        if ([infos.collection integerValue]==1) { //是否 关注  0=未关注，1=已关注
            // 取消关注
            [userModel app_php_Index_collection_del:infos.u_id];
        } else { // 添加关注
            [userModel app_php_Index_collection_add:infos.u_id];
        }
    } else if (btn.tag-followBtnTag==1) {  // 私信
        
        
        TLChatViewController *vc = [TLChatViewController new];
        vc.userId = infos.u_id;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } else if (btn.tag-followBtnTag==2) {  //  打赏
        
        [self.view endEditing:YES];
        
        ShangViewController *vc = [[ShangViewController alloc] init];
        vc.info = detailsInfo;
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
}

#pragma mark - MingRenSliderVCDelegate

- (NSUInteger)numberOfTab:(MingRenSlider *)view {
    return 4;
}

- (UIViewController *)slideSwitchView:(MingRenSlider *)view viewOfTab:(NSUInteger)number {
    if (number == 0) {
        vc1 = [[ZPViewController alloc] init];
        vc1.nav = self.navigationController;
        vc1.title = @"作品";
        return vc1;
    } else if (number == 1) {
        vc2 = [[JJViewController alloc] init];
        [vc2 loadDataSucc:^(ArtistInfo *info) {
            infos = info;
            
            
            [UIImage loadImageWithUrl:infos.image returnImage:^(UIImage *image) {
                _shareImage = image;
            }];
            
            
            
            [icon sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:[UIImage imageNamed:@"个人主页icon"]];
            name.text = info.nike;
            [name sizeToFit];
            
            icon.y = (background.height-icon.height-name.height-10)/2;
            icon.centerX = background.width/2;
            name.y = icon.bottom+10;
            name.centerX = background.width/2;
            
            [self upDateBtn:info];
        }];
        vc2.title = @"简介";
        return vc2;
    } else if (number == 2) {
        vc3 = [[GZViewController alloc] init];
        vc3.nav = self.navigationController;
        vc3.title = @"关注";
        return vc3;
    } else if (number == 3) {
        vc4 = [[FSViewController alloc] init];
        vc4.nav = self.navigationController;
        vc4.title = @"粉丝";
        return vc4;
    } else  {
        UIViewController *vc = [[UIViewController alloc] init];
        return vc;
    }
}

- (void)selectNameButton:(UIButton *)sender {
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[header viewWithTag:userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        //设置新页出现
        [slider selectNameButton:sender];
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            shadowImageView.centerX = sender.centerX;
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"userSelectedChannelID"]) {
        NSLog(@"%@", change);
        NSNumber *new = [change objectForKey:@"new"];
        if ([new integerValue]!=userSelectedChannelID) {
            //取之前的按钮
            UIButton *lastButton = (UIButton *)[header viewWithTag:userSelectedChannelID];
            lastButton.selected = NO;
            //赋值按钮ID
            userSelectedChannelID = [new integerValue];
            UIButton *newButton = (UIButton *)[header viewWithTag:userSelectedChannelID];
            
            if (!newButton.selected) {
                newButton.selected = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    shadowImageView.centerX = newButton.centerX;
                }];
            }
        }
    }
}

- (void)back {
//    if (self.navigationController.viewControllers.count>2) {
//        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
//    } else {
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnAction:(UIButton *)btn {
    NSLog(@"分享");
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
    NSInteger index = btn.tag;
    
    NSLog(@"-----  %ld",index);
    
    [ShareModel shareUMengWithVC:self withPlatform:index withTitle:[NSString stringWithFormat:@"%@的iGallery主页",infos.nike] withShareTxt:infos.content withImage:_shareImage withID:infos.u_id withType:3 withUrl:nil success:^(NSDictionary *requestDic) {
        
        
    } failure:^(NSString *error) {
        
    }];
    

}

- (void)loadModel {
    [vc1 loadModel:self.u_id];
    [vc2 loadModel:self.u_id];
    [vc3 loadModel:self.u_id];
    [vc4 loadModel:self.u_id];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *arr = @[@"个人主页bj1", @"个人主页bj2", @"个人主页bj2", @"个人主页bj1", @"个人主页bj1", @"个人主页bj2"];
    NSInteger index = arc4random_uniform(100)%6;
    
    background.image = [UIImage imageNamed:arr[index]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)followerChanged:(void(^)())block {
    self.block = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.block) {
        self.block();
    }
    [super viewWillDisappear:animated];
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
