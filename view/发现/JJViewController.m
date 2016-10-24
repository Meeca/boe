//
//  JJViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JJViewController.h"
#import "WorksModel.h"

@interface JJViewController () <UITableViewDelegate, UITableViewDataSource> {
    WorksModel *worksModel;
    
    ArtistInfo *info;
    
    CGFloat contextHeight;
    UILabel *msg;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation JJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    worksModel = [WorksModel modelWithObserver:self];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    
    [self addHeader];
}

- (void)loadDataSucc:(void(^)(ArtistInfo *info))block {
    self.block = block;
}

- (void)loadModel:(NSString *)u_id {
    worksModel.u_id = u_id;
    [worksModel app_php_Finds_artist_read];
}

- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [worksModel app_php_Finds_artist_read];
    }];
}

ON_SIGNAL3(WorksModel, ARTISTREAD, signal) {
    info = signal.object;
    
    if (info) {
        if (self.block) {
            self.block(info);
        }
    }
    [self hidden];
    [self.table.mj_header endRefreshing];
    if (info.content.length == 0) {
        [self show];
    }
    [self.table reloadData];
}

- (void)show {
    if (!msg) {
        msg = [[UILabel alloc] initWithFrame:CGRectZero];
        msg.text = @"好像什么也没有哎。。。";
        msg.textColor = [UIColor grayColor];
        [msg sizeToFit];
    }
    
    [self.view addSubview:msg];
    msg.center = CGPointMake(self.view.width/2, self.view.height/2);
}

- (void)hidden {
    [msg removeFromSuperview];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = tableView.backgroundColor;
    
    CGFloat x = cell.separatorInset.left;
    UIFont *font = [UIFont systemFontOfSize:16];
    
    UILabel *context = [[UILabel alloc] initWithFrame:CGRectMake(x, x, KSCREENWIDTH-x*2, 0)];
    context.numberOfLines = 0;
    context.text = info.content;
    context.textColor = [UIColor darkGrayColor];
    context.font = font;
    [cell.contentView addSubview:context];
    CGSize size = [Tool getLabelSizeWithText:context.text AndWidth:context.width AndFont:font attribute:nil];
    context.height = size.height;

    if (contextHeight != context.height+x+x) {
        contextHeight = context.height+x+x;
        [tableView reloadData];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return contextHeight;
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
