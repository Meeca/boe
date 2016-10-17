//
//  HomeViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "HomeViewController.h"
#import "SUNSlideSwitchView.h"
#import "ChoiceViewController.h"
#import "FollowViewController.h"
#import "EScrollerView.h"
#import "ManageViewController.h"
#import "SeachViewController.h"
#import "LoginViewController.h"

#import "DBHBuyPictureFrameViewController.h"

@interface HomeViewController () <SUNSlideSwitchViewDelegate, EScrollerViewDelegate> {
    SUNSlideSwitchView *slide;
    EScrollerView *banner;
    NSArray *bannerArr;
    
    UIImageView *shadowImageView;
    NSInteger userSelectedChannelID;
    ChoiceViewController *vc1;
    FollowViewController *vc2;
    
    UserModel *userModel;
}

@property (nonatomic, strong) UIView *header;
@property (nonatomic, assign) BOOL isAnm;

@end

@implementation HomeViewController

@synthesize header,isAnm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"iGALLERY";

    userModel = [UserModel modelWithObserver:self];
    [self observeNotification:userModel.LOGIN];
    [self observeNotification:userModel.REGISTER];

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
    userSelectedChannelID = 100;
    slide = [[SUNSlideSwitchView alloc] initWithFrame:CGRectMake(0, -44, KSCREENWIDTH, KSCREENHEIGHT-20-49)];
    slide.slideSwitchViewDelegate = self;
    slide.tabItemNormalColor = [UIColor blackColor];
    slide.tabItemSelectedColor = KAPPCOLOR;
    [self.view addSubview:slide];
    [slide buildUI];
    
    [slide addObserver:self forKeyPath:@"userSelectedChannelID" options:NSKeyValueObservingOptionNew context:NULL];
    NSArray *title = @[@"艺术精选", @"我的关注"];
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, BANNERHEIGHT+44)];
    shadowImageView = [[UIImageView alloc] init];
    shadowImageView.backgroundColor = slide.tabItemSelectedColor;
    [header addSubview:shadowImageView];

    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake((KSCREENWIDTH-180)/3+((KSCREENWIDTH-180)/3+90)*i, header.height-44, 90, 44)];
        
        //计算下一个tab的x偏移量
        [button setTag:i+100];
        if (i == 0) {
            shadowImageView.frame = CGRectMake(0, button.height-2, button.width+20, 2);
            shadowImageView.centerX = button.centerX;
            shadowImageView.bottom = button.bottom;
            button.selected = YES;
        }
        [button setTitle:title[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:slide.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:slide.tabItemSelectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:button];
    }
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    [self loadModel];
}

ON_SIGNAL3(UserModel, BANNER, signal) {
    [banner removeFromSuperview];
    banner = nil;
    NSMutableArray *imgs = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    bannerArr = signal.object;
    if (bannerArr.count>0) {
        for (BannerInfo *b_info in bannerArr) {
            [imgs addObject:b_info.banner_image.length>0 ? b_info.banner_image : @""];
            [titles addObject:b_info.banner_title.length>0 ? b_info.banner_title : @""];
        }
    }
    
    if (imgs.count>0) {
        banner = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, KSCREENWIDTH, BANNERHEIGHT) ImageArray:imgs TitleArray:titles];
        banner.delegate = self;
        
        [header addSubview:banner];
    }
}

ON_NOTIFICATION3(UserModel, LOGIN, notification) {
    [self loadModel];
}

ON_NOTIFICATION3(UserModel, REGISTER, notification) {
    [self loadModel];
}

#pragma mark - EScrollerViewDelegate

-(void)EScrollerViewDidClicked:(NSUInteger)index {
    BannerInfo *model = bannerArr[index-1];
    if ([model.types isEqualToString:@"1"]) {
        DBHBuyPictureFrameViewController *buyPictureFrameVC = [[DBHBuyPictureFrameViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        buyPictureFrameVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:buyPictureFrameVC animated:YES];
        return;
    }
    NIWebController *vc = [[NIWebController alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SUNSlideSwitchViewDelegate

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view {
    return 2;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number {
    
    __weak HomeViewController *weakSelf = self;
    
    if (number == 0) {
        vc1 = [[ChoiceViewController alloc] init];
        vc1.title = @"艺术精选";
        vc1.nav = self.navigationController;
        [vc1 setContentOffset:^(CGPoint point, BOOL isUp) {
            NSLog(@"艺术精选 collect contentOffset  \n%@", NSStringFromCGPoint(point));
            if (isUp) {
                if (point.y > weakSelf.header.height-44) {
                    if (weakSelf.header.y != -weakSelf.header.height) {
                        if (!weakSelf.isAnm) {
                            weakSelf.isAnm = YES;
                            [UIView animateWithDuration:.3 animations:^{
                                weakSelf.header.y = -weakSelf.header.height;
                            } completion:^(BOOL finished) {
                                weakSelf.isAnm = NO;
                                [weakSelf check];
                            }];
                        }
                    }
                } else {
                    weakSelf.header.y = -point.y;
                    [weakSelf check];
                }
            } else {
                if (weakSelf.header.y != -weakSelf.header.height+44 && point.y > BANNERHEIGHT) {
                    if (!weakSelf.isAnm) {
                        weakSelf.isAnm = YES;
                        [UIView animateWithDuration:.3 animations:^{
                            weakSelf.header.y = -weakSelf.header.height+44;
                        } completion:^(BOOL finished) {
                            weakSelf.isAnm = NO;
                            [weakSelf check];
                        }];
                    }
                }
                if (point.y <= BANNERHEIGHT) {
                    weakSelf.header.y = -point.y;
                    [weakSelf check];
                }
            }
        }];
        return vc1;
    } else if (number == 1) {
        vc2 = [[FollowViewController alloc] init];
        vc2.title = @"我的关注";
        vc2.nav = self.navigationController;
        [vc2 setContentOffset:^(CGPoint point, BOOL isUp) {
            NSLog(@"我的关注 collect contentOffset  \n%@", NSStringFromCGPoint(point));
            if (isUp) {
                if (point.y > weakSelf.header.height-44) {
                    if (weakSelf.header.y != -weakSelf.header.height) {
                        if (!weakSelf.isAnm) {
                            weakSelf.isAnm = YES;
                            [UIView animateWithDuration:.3 animations:^{
                                weakSelf.header.y = -weakSelf.header.height;
                            } completion:^(BOOL finished) {
                                weakSelf.isAnm = NO;
                                [weakSelf check];
                            }];
                        }
                    }
                } else {
                    weakSelf.header.y = -point.y;
                    [weakSelf check];
                }
            } else {
                if (weakSelf.header.y != -weakSelf.header.height+44 && point.y > BANNERHEIGHT) {
                    if (!weakSelf.isAnm) {
                        weakSelf.isAnm = YES;
                        [UIView animateWithDuration:.3 animations:^{
                            weakSelf.header.y = -weakSelf.header.height+44;
                        } completion:^(BOOL finished) {
                            weakSelf.isAnm = NO;
                            [weakSelf check];
                        }];
                    }
                }
                if (point.y <= BANNERHEIGHT) {
                    weakSelf.header.y = -point.y;
                    [weakSelf check];
                }
            }
        }];
        return vc2;
    } else {
        UIViewController *vc = [[UIViewController alloc] init];
        return vc;
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
            if (self.header.y != -self.header.height+44) {
                if (-self.header.y<self.header.height-44) {
                    return;
                }
                if (!self.isAnm) {
                    self.isAnm = YES;
                    [UIView animateWithDuration:.3 animations:^{
                        self.header.y = -self.header.height+44;
                    } completion:^(BOOL finished) {
                        self.isAnm = NO;
                        [self check];
                    }];
                }
            }
        }
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
        [slide selectNameButton:sender];
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            shadowImageView.centerX = sender.centerX;
        }];
    }
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

- (void)check {
    [vc1 checkViewCountView:-self.header.y];
    [vc2 checkViewCountView:-self.header.y];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [userModel app_php_Index_banner];
    [userModel loadCache];
    
    if (kUserId.length == 0) { // 没登录
        LoginViewController *vc = [[LoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        
        [Tool performBlock:^{
            [self presentViewController:nav animated:YES completion:NULL];
        } afterDelay:.3];
    }
}

- (void)loadModel {
    [vc1 loadModel];
    [vc2 loadModel];
}

- (void)dealloc {
    [slide removeObserver:self forKeyPath:@"userSelectedChannelID"];
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
