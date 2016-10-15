//
//  FenLeiViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FenLeiViewController.h"
#import "FenLeiDetailViewController.h"
#import "JHCusomHistory.h"
#import "JDFClassificationModel.h"
#import "JHCell.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface FenLeiViewController ()/*<UICollectionViewDataSource,UICollectionViewDelegate>*/
@property (weak, nonatomic) IBOutlet UICollectionView *hotKeyCollectionView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong)NSMutableArray *searchHotArray;


@property(nonatomic,strong)JHCusomHistory *history;

@end

@implementation FenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _searchHotArray  = [NSMutableArray array];
    CGFloat h=0;
       _page = 1;
    
    self.view.backgroundColor = RGB(234, 234, 234);
    NSArray *arr = @[@"传世经典", @"当代名家", @"新锐艺术"];
   
    for (int i=0; i<3; i++) {

        NSString *imageName = [NSString stringWithFormat:@"classification%d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15+((KSCREENWIDTH-50)/3+10)*i, 15, (KSCREENWIDTH-50)/3, (KSCREENWIDTH-50)/3)];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = view.bounds;
        imageView.image = image;
        [view addSubview:imageView];
        
        UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
        msg.textColor = [UIColor whiteColor];
        msg.text = arr[i];
        msg.font = [UIFont boldSystemFontOfSize:18];
        [view addSubview:msg];
        [msg sizeToFit];
        msg.bottom = view.height-3;
        msg.x = 5;
        
        h = view.bottom;
        
        UIButton *button = [[UIButton alloc]initWithFrame:view.bounds];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
 
    [self loadCircleDataWithFirstPage:YES hud:NO];
    
    _history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, (KSCREENWIDTH/3)+30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andItems:@[@"熊出没",@"死神来了19",@"钢铁侠0",@"海上钢琴师",@"最后一只恐龙",@"苍井空",@"假如爱有天意",@"好好先生",@"特种部队",@"生化危机",@"魔兽"] andItemClickBlock:^(NSInteger i) {
        
        
        /*        相应点击事件 i为点击的索引值         */
        FenLeiDetailViewController *vc = [[FenLeiDetailViewController alloc]init];
        vc.classId = [NSString stringWithFormat:@"%ld", i];
        vc.type = 4;
        vc.hidesBottomBarWhenPushed  = YES;
        [self.nav pushViewController:vc animated:YES];
    }];
    
    [self.hotKeyCollectionView addSubview:_history];
}

- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud
{
    if (firstPage) {
        _page = 1;
    }
    
   NSString *path = @"/app.php/Finds/class_list";
    NSDictionary *params = @{
                             @"page":@(_page),
                             @"pagecount":@"20",
                             @"artist":@"0",
 
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
     _page ++;

        
        NSArray * array = [ JDFClassificationModel mj_objectArrayWithKeyValuesArray:requestDic];
        _history.dataArray = array;

//        NSArray *info = (NSArray *)requestDic;
//        for (NSDictionary *dict in info) {
//            JDFClassificationModel *model = [JDFClassificationModel yy_modelWithJSON:dict];
//            [_searchHotArray addObject:model];
//
//        }
//        _history.dataArray = _searchHotArray;
        [self.hotKeyCollectionView reloadData];
     } fail:^(NSString *error) {
        
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.history.dataArray.count;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

 

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 0)
    {
        //传世经典
        
    }
    else if(button.tag == 1)
    {
        //当代名家
    }
    else if(button.tag == 2)
    {
        //新锐艺术
    }
    FenLeiDetailViewController *vc = [[FenLeiDetailViewController alloc]init];
    vc.type = button.tag;
    vc.hidesBottomBarWhenPushed  = YES;
    [self.nav pushViewController:vc animated:YES];
}



- (void)yuanxian
{


    //    UILabel *ti = [[UILabel alloc] initWithFrame:CGRectMake(15, h+10, (KSCREENWIDTH-30)/5, (KSCREENWIDTH-30)/3)];
    //    ti.text = @"题材";
    //    ti.textAlignment = NSTextAlignmentCenter;
    //    ti.font = [UIFont systemFontOfSize:15];
    //    ti.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:ti];
    //
    //    UILabel *fen = [[UILabel alloc] initWithFrame:CGRectMake(ti.right, ti.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    fen.text = @"风景";
    //    fen.textAlignment = NSTextAlignmentCenter;
    //    fen.font = [UIFont systemFontOfSize:15];
    //    fen.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:fen];
    //
    //    UILabel *ren = [[UILabel alloc] initWithFrame:CGRectMake(fen.right, ti.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    ren.text = @"人物";
    //    ren.textAlignment = NSTextAlignmentCenter;
    //    ren.font = [UIFont systemFontOfSize:15];
    //    ren.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:ren];
    //
    //    UILabel *dong = [[UILabel alloc] initWithFrame:CGRectMake(ren.right, ti.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    dong.text = @"动物";
    //    dong.textAlignment = NSTextAlignmentCenter;
    //    dong.font = [UIFont systemFontOfSize:15];
    //    dong.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:dong];
    //
    //    UILabel *zhi = [[UILabel alloc] initWithFrame:CGRectMake(ti.right, fen.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    zhi.text = @"植物";
    //    zhi.textAlignment = NSTextAlignmentCenter;
    //    zhi.font = [UIFont systemFontOfSize:15];
    //    zhi.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:zhi];
    //
    //    UILabel *chen = [[UILabel alloc] initWithFrame:CGRectMake(zhi.right, fen.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    chen.text = @"城市";
    //    chen.textAlignment = NSTextAlignmentCenter;
    //    chen.font = [UIFont systemFontOfSize:15];
    //    chen.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:chen];
    //
    //    UILabel *d = [[UILabel alloc] initWithFrame:CGRectMake(chen.right, fen.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    d.text = @"动物";
    //    d.textAlignment = NSTextAlignmentCenter;
    //    d.font = [UIFont systemFontOfSize:15];
    //    d.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:d];
    //
    //    UILabel *ci = [[UILabel alloc] initWithFrame:CGRectMake(15, ti.bottom+10, (KSCREENWIDTH-30)/5, (KSCREENWIDTH-30)/3)];
    //    ci.text = @"材料";
    //    ci.textAlignment = NSTextAlignmentCenter;
    //    ci.font = [UIFont systemFontOfSize:15];
    //    ci.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:ci];
    //
    //    UILabel *you = [[UILabel alloc] initWithFrame:CGRectMake(ci.right, ci.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    you.text = @"油画";
    //    you.textAlignment = NSTextAlignmentCenter;
    //    you.font = [UIFont systemFontOfSize:15];
    //    you.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:you];
    //
    //    UILabel *ban = [[UILabel alloc] initWithFrame:CGRectMake(you.right, ci.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    ban.text = @"版画";
    //    ban.textAlignment = NSTextAlignmentCenter;
    //    ban.font = [UIFont systemFontOfSize:15];
    //    ban.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:ban];
    //
    //    UILabel *don = [[UILabel alloc] initWithFrame:CGRectMake(ban.right, ci.top, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    don.text = @"动物";
    //    don.textAlignment = NSTextAlignmentCenter;
    //    don.font = [UIFont systemFontOfSize:15];
    //    don.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:don];
    //
    //    UILabel *zh = [[UILabel alloc] initWithFrame:CGRectMake(ci.right, you.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    zh.text = @"植物";
    //    zh.textAlignment = NSTextAlignmentCenter;
    //    zh.font = [UIFont systemFontOfSize:15];
    //    zh.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:zh];
    //
    //    UILabel *guo = [[UILabel alloc] initWithFrame:CGRectMake(zh.right, you.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    guo.text = @"国画";
    //    guo.textAlignment = NSTextAlignmentCenter;
    //    guo.font = [UIFont systemFontOfSize:15];
    //    guo.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:guo];
    //
    //    UILabel *dw = [[UILabel alloc] initWithFrame:CGRectMake(guo.right, you.bottom, (KSCREENWIDTH-30)/5*4/3, (KSCREENWIDTH-30)/3/2)];
    //    dw.text = @"动物";
    //    dw.textAlignment = NSTextAlignmentCenter;
    //    dw.font = [UIFont systemFontOfSize:15];
    //    dw.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:dw];
    
    //    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(ti.right, ti.top, 2, ti.height*2+10)];
    //    line1.backgroundColor = self.view.backgroundColor;
    //    [self.view addSubview:line1];
    //
    //    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(fen.right, fen.top, 2, ti.height*2+10)];
    //    line2.backgroundColor = self.view.backgroundColor;
    //    [self.view addSubview:line2];
    //
    //    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(ren.right, ren.top, 2, ti.height*2+10)];
    //    line3.backgroundColor = self.view.backgroundColor;
    //    [self.view addSubview:line3];
    //    
    //    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(ti.right, fen.bottom, (KSCREENWIDTH-30)/5*4, 2)];
    //    line4.backgroundColor = self.view.backgroundColor;
    //    [self.view addSubview:line4];
    //    
    //    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(ci.right, you.bottom, (KSCREENWIDTH-30)/5*4, 2)];
    //    line5.backgroundColor = self.view.backgroundColor;
    //    [self.view addSubview:line5];



}

@end
