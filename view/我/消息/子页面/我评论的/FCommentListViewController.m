//
//  FCommentListViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FCommentListViewController.h"
#import "FCommentCell.h"
#import "FCommentModel.h"
#import "XiangQingViewController.h"
#import "CircleConversDetailViewController.h"

@interface FCommentListViewController (){


    NSInteger _page;
    NSMutableArray * _dataArray;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_type == 0) {
        self.navigationItem.title = @"评论我的";
    }else{
    
        self.navigationItem.title = @"我评论的";

    }
    
    
    
    _dataArray = [NSMutableArray new];
    _page = 1;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;  //  随便设个不那么离谱的值
    [_tableView registerNib:[UINib nibWithNibName:@"FCommentCell" bundle:nil] forCellReuseIdentifier:@"FCommentCell"];
    _tableView.tableFooterView = [UIView new];
    
    [self loadMessageDataWithFirstPage:YES];
    
    [_tableView headerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:YES];
    }];
    
    
    [_tableView footerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:NO];
    }];
    
    
    
    // Do any additional setup after loading the view from its nib.
}



#pragma mark------请求消息中心接口

- (void)loadMessageDataWithFirstPage:(BOOL)first{
    
    
    if (first) {
        _page = 1;
    }
    
    
    /*
     
     get:/app.php/User/me_comm_list
     uid#用户id
     page:分页起始条数 //从0开始
     pagecount：分页每页条数（不传 默认为0-10）
     */
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"uid"]= kUserId;
    dict[@"page"]= @(_page);
    dict[@"pagecount"]= @"20";
    
    NSString * url;
    if (_type == 0) {
        url = @"/app.php/User/comm_me_list";
    }else{
        url =  @"/app.php/User/me_comm_list";
    }
    
    
    [MCNetTool postWithUrl:url params:dict hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        _page ++;
        
        NSArray * array = [FCommentModel mj_objectArrayWithKeyValuesArray:requestDic];
        first?[_dataArray setArray:array]:[_dataArray addObjectsFromArray:array];
        first?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
        [_tableView reloadData];
        if (array.count < 20) {
            [_tableView hidenFooter];
        }
        
    } fail:^(NSString *error) {
        first?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
    }];
    
}




#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCommentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FCommentCell"];
    FCommentModel * fCommentModel = _dataArray[indexPath.row];
    cell.fCommentModel = fCommentModel;
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FCommentModel * fCommentModel = _dataArray[indexPath.row];

    
    //"type": "1",         //评论分类（1评论作品，2评论话题）

    if (fCommentModel.type == 1) {
        
        XiangQingViewController * vc= [[XiangQingViewController alloc]init];
//        vc.p_id =fCommentModel.p_id;
        [vc readWithP_id:fCommentModel.p_id collBack:^(NSString *p_id) {
            
        }];
        vc.isRoot = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (fCommentModel.type == 2) {
        
        CircleConversDetailViewController *circleConversDetailVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CircleConversDetailViewController"];
        circleConversDetailVC.c_id = fCommentModel.c_id;
        [self.navigationController pushViewController:circleConversDetailVC animated:YES];
        
        
    }
 
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
