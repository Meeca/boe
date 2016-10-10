//
//  FindViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "FindViewController.h"
#import "FindSliderVC.h"
#import "YiShuViewController.h"
#import "MingRenViewController.h"
#import "ZuanTiViewController.h"
#import "TopViewController.h"
#import "FenLeiViewController.h"
#import "HuoDongViewController.h"
#import "ManageViewController.h"
#import "SeachViewController.h"

@interface FindViewController () <FindSliderVCDelegate> {
    FindSliderVC *slider;
    
    YiShuViewController *vc1;
    MingRenViewController *vc2;
    ZuanTiViewController *vc3;
    TopViewController *vc4;
    FenLeiViewController *vc5;
    HuoDongViewController *vc6;
}

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发现";
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 50, 50);
    [left setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [left setImage:[UIImage imageNamed:@"A-set"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(manage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [right setImage:[UIImage imageNamed:@"A-sousuo"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    slider = [[FindSliderVC alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-49-64)];
    slider.slideSwitchViewDelegate = self;
    slider.tabItemNormalColor = [UIColor grayColor];
    slider.tabItemSelectedColor = [UIColor blackColor];
    
    [self.view addSubview:slider];
    
    [slider buildUI];
    
    [self loadModel];
}

#pragma mark — FindSliderVCDelegate

- (NSUInteger)numberOfTab:(FindSliderVC *)view {
    return 6;
}

- (UIViewController *)slideSwitchView:(FindSliderVC *)view viewOfTab:(NSUInteger)number {
    if (number == 0) {
        vc1 = [[YiShuViewController alloc] init];
        vc1.title = @"艺术馆";
        vc1.nav = self.navigationController;
        return vc1;
    } else if (number == 1) {
        vc2 = [[MingRenViewController alloc] init];
        vc2.title = @"艺术家";
        vc2.nav = self.navigationController;
        return vc2;
    } else if (number == 2) {
        vc3 = [[ZuanTiViewController alloc] init];
        vc3.title = @"专题";
        vc3.nav = self.navigationController;
        return vc3;
    } else if (number == 3) {
        vc4 = [[TopViewController alloc] init];
        vc4.title = @"排行榜";
        vc4.nav = self.navigationController;
        return vc4;
    } else if (number == 4) {
        vc5 = [[FenLeiViewController alloc] init];
        vc5.title = @"分类";
        vc5.nav = self.navigationController;
        return vc5;
    } else if (number == 5) {
        vc6 = [[HuoDongViewController alloc] init];
        vc6.title = @"活动与展览";
        vc6.nav = self.navigationController;
        return vc6;
    } else {
        UIViewController *vc = [[UIViewController alloc] init];
        return vc;
    }
}

- (void)loadModel {
    [vc1 loadModel];
    [vc2 loadModel];
    [vc3 loadModel];
    [vc4 loadModel];
    [vc6 loadModel];
}

- (void)manage:(UIBarButtonItem *)item {
    ManageViewController *vc = [[ManageViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)search:(UIBarButtonItem *)item {
    SeachViewController *vc = [[SeachViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
