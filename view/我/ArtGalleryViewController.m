//
//  ArtGalleryViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "ArtGalleryViewController.h"
#import "SliderViewController.h"
#import "CollectViewController.h"
#import "MyArtViewController.h"
#import "SiMiViewController.h"
#import "UpDataViewController.h"

@interface ArtGalleryViewController () <SliderViewControllerDelegate> {
    
    CollectViewController *vc1;
    MyArtViewController *vc2;
    SiMiViewController *vc3;
}

@property (nonatomic, strong)  SliderViewController *sliderVC;

@end

@implementation ArtGalleryViewController
@synthesize sliderVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的艺术馆";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataSucc:) name:UPDATASUCC object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addZuoPin:)];
    
    sliderVC = [[SliderViewController alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-64)];
    sliderVC.slideSwitchViewDelegate = self;
    sliderVC.tabItemNormalColor = [UIColor blackColor];
    sliderVC.tabItemSelectedColor = RGB(0, 170, 229);
    [self.view addSubview:sliderVC];
    [sliderVC buildUI];
    
    [self loadModel];
    if (self.index) {
        [sliderVC selectIndex:self.index];
    }
}

- (void)setIndex:(NSInteger)index {
    if (_index != index) {
        _index = index;
    }
    if (sliderVC) {
        [sliderVC selectIndex:index];
        [self loadModel];
    }
}

- (void)upDataSucc:(NSNotification *)not {
    BOOL isPublic = [not.object boolValue];
    self.index = isPublic ? 1 : 2;
}

#pragma mark - SliderViewControllerDelegate

- (NSUInteger)numberOfTab:(SliderViewController *)view {
    return 3;
}

- (UIViewController *)slideSwitchView:(SliderViewController *)view viewOfTab:(NSUInteger)number {
    __weak ArtGalleryViewController *weakSelf = self;
    if (number == 0) {

        vc1 = [[CollectViewController alloc] init];
        vc1.title = @"收藏馆";
        [vc1 setEditBlock:^(BOOL isCancel){
            
            [weakSelf changeRightItemState:isCancel];

         
        }];
        vc1.nav = self.navigationController;
        return vc1;
    } else if (number == 1) {
        
        vc2 = [[MyArtViewController alloc] init];
        vc2.title = @"认证作品";
        [vc2 setEditBlock:^(BOOL isCancel){
            
            [weakSelf changeRightItemState:isCancel];
            
  
        }];
        vc2.nav = self.navigationController;
        return vc2;
    } else if (number == 2) {

        vc3 = [[SiMiViewController alloc] init];
        vc3.title = @"私密馆";
        [vc3 setEditBlock:^(BOOL isCancel){
           
            [weakSelf changeRightItemState:isCancel];

        }];
        vc3.nav = self.navigationController;
        return vc3;
    } else {
        UIViewController *vc = [[UIViewController alloc] init];
        return vc;
    }
}


- (void)changeRightItemState:(BOOL )cancle{

    
    if (cancle) {
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canel:)];
        [right setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPPCOLOR} forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = right;
        
        self.sliderVC.rootScrollView.scrollEnabled = NO;
        self.sliderVC.topScrollView.userInteractionEnabled = NO;
        
    }else{
        
        [self  canel:nil];
    }
    




}




- (void)canel:(UIBarButtonItem *)btn {
    sliderVC.rootScrollView.scrollEnabled = YES;
    sliderVC.topScrollView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addZuoPin:)];
    
    [vc1 canel];
    [vc2 canel];
    [vc3 canel];
}

- (void)loadModel {
    [vc1 loadModel];
    [vc2 loadModel];
    [vc3 loadModel];
}

- (void)addZuoPin:(UIBarButtonItem *)btn {
    UpDataViewController *vc = [[UpDataViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    vc.title = @"选择作品";
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
