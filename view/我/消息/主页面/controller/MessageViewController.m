//
//  MessageViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageContentCell.h"
#import "PrivateMessageListVC.h"
#import "SystemMessageModel.h"
#import "SystemDetaileViewController.h"
#import "FCommentListViewController.h"

@interface MessageViewController (){


    NSInteger _page;
    NSMutableArray * _dataArray;
    
    NSString * num;

}
@property (weak, nonatomic) IBOutlet UITableView *tabelView;





@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"消息中心";
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"私信" target:self action:@selector(sixinItemAction:)];
    
    
    _page = 1;
    _dataArray = [NSMutableArray new];
    
    
    _tabelView.rowHeight = UITableViewAutomaticDimension;
    _tabelView.estimatedRowHeight = 100;  //  随便设个不那么离谱的值
     [_tabelView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
    [_tabelView registerNib:[UINib nibWithNibName:@"MessageContentCell" bundle:nil] forCellReuseIdentifier:@"MessageContentCell"];
    _tabelView.tableFooterView = [UIView new];
    
    

    
    [self loadMessageDataWithFirstPage:YES];

    [_tabelView headerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:YES];
    }];
    
    
    [_tabelView footerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:NO];
    }];
    
    
    
}
- (void)sixinItemAction:(UIBarButtonItem *)item{

    PrivateMessageListVC * vc = [[PrivateMessageListVC alloc]initWithNibName:@"PrivateMessageListVC" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];


}


#pragma mark------请求消息中心接口

- (void)loadMessageDataWithFirstPage:(BOOL)first{

    
    if (first) {
        _page = 1;
    }

    
    /*
     
     get:/app.php/User/news_list
     uid#用户id
     page:分页起始条数 //从0开始
     pagecount：分页每页条数（不传 默认为0-10）
     
     */
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"uid"]= kUserId;
    dict[@"page"]= @(_page);
    dict[@"pagecount"]= @"20";
    
    [MCNetTool postWithUrl:@"/app.php/User/news_list" params:dict hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        if (![msg isEqualToString:@"暂无数据"]) {
            _page ++;
            
            num = requestDic[@"comm_num"];
            
            NSArray * array = [SystemMessageModel mj_objectArrayWithKeyValuesArray:requestDic[@"new_list"]];
            first?[_dataArray setArray:array]:[_dataArray addObjectsFromArray:array];
            [_tabelView reloadData];
            if (array.count < 20) {
                [_tabelView hidenFooter];
            }
        }
        first?[_tabelView headerEndRefresh]:[_tabelView footerEndRefresh];
    } fail:^(NSString *error) {
        first?[_tabelView headerEndRefresh]:[_tabelView footerEndRefresh];
    }];

}



#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        
        if(indexPath.row == 0){
            
            if ([num isEqualToString:@"0"]) {
                cell.numLab.hidden = YES;
             }else{
                cell.numLab.text = num;
                cell.numLab.hidden = NO;
             }
        }else{
            cell.numLab.hidden = YES;
        }
        
        return cell;
    }
    MessageContentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MessageContentCell"];
    
    SystemMessageModel * systemMessageModel = _dataArray[indexPath.row];
    cell.contentLab.text = systemMessageModel.title;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        return  44;
     }
     return  44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        FCommentListViewController  * vc = [[FCommentListViewController alloc]initWithNibName:@"FCommentListViewController" bundle:nil];
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];

        
        
    }
    
    
    
    
    if(indexPath.section == 1){
    
        SystemMessageModel * systemMessageModel = _dataArray[indexPath.row];
        SystemDetaileViewController * vc = [[SystemDetaileViewController alloc]initWithNibName:@"SystemDetaileViewController" bundle:nil];
        vc.n_id =systemMessageModel.n_id;
        
        vc.systemDBlock= ^(){
            [self loadMessageDataWithFirstPage:YES];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    
    }
}

  
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KSCREENWIDTH, 40)];
        titleLab.text = [NSString stringWithFormat:@"  %@",@"系统消息"];
        titleLab.backgroundColor = [UIColor clearColor];
        return titleLab;
     }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 40;
    }
    return 10.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
