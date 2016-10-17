//
//  PrivateMessageListVC.m
//  jingdongfang
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PrivateMessageListVC.h"
#import "PrivateMessageCell.h"
#import "PrivateMessageListFooterView.h"
#import "UIButton+Block.h"
#import "SiXinModel.h"
#import "TLChatViewController.h"

@interface PrivateMessageListVC (){


    NSInteger _page;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) PrivateMessageListFooterView * footerView;
@property(nonatomic, strong) UIButton *selectedBtn;//选择按钮
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *chooseArr;//选中数据的数组
@property(nonatomic, strong) NSMutableArray *markArr;//标记数据的数组
@end

@implementation PrivateMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     self.navigationItem.title = @"私信";
    
    _dataArray = [NSMutableArray new];
    _page = 0;
    
    self.chooseArr = [NSMutableArray array];
    self.markArr = [NSMutableArray array];
    //选择按钮
    _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _selectedBtn.frame = CGRectMake(0, 0, 60, 30);
    [_selectedBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_selectedBtn setTitle:@"完成" forState:UIControlStateSelected];
    [_selectedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     [_selectedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [_selectedBtn sizeToFit];
    [_selectedBtn addTarget:self action:@selector(editItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc] initWithCustomView:_selectedBtn];
    self.navigationItem.rightBarButtonItem =selectItem;

    
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"PrivateMessageCell" bundle:nil] forCellReuseIdentifier:@"PrivateMessageCell"];
    _tableView.tableFooterView = [UIView new];
    
    
    
    
    [_tableView headerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:YES];
    }];
    
    
    [_tableView footerAddMJRefresh:^{
        [self loadMessageDataWithFirstPage:NO];
    }];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadMessageDataWithFirstPage:YES];
 
}

#pragma mark------请求消息中心接口

- (void)loadMessageDataWithFirstPage:(BOOL)first{
    
    
    if (first) {
        _page = 1;
    }
    
    /*
     
     get:/app.php/User/my_n_list
     uid#用户id
     page:分页起始条数 //从0开始
     pagecount：分页每页条数（不传 默认为0-10）
     
     */
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    dict[@"uid"]= kUserId;
    dict[@"page"]= @(_page);
    dict[@"pagecount"]= @"20";
    
    [MCNetTool postWithUrl:@"/app.php/User/my_n_list" params:dict hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        _page ++;
                
        NSArray * array = [SiXinModel mj_objectArrayWithKeyValuesArray:requestDic];
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







- (void)editItemAction:(UIButton *)item{

    item.selected =!item.selected;
    
    if (item.selected) {
        [self addFooterView];
        
    }else{
        
        [self hidenFooterView];
        
    }
    //支持同时选中多行
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;
   

}

- (void)addFooterView{
    
    _footerView = [PrivateMessageListFooterView privateMessageListFooterView];
    _footerView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 40);
    [self.view addSubview:_footerView];
     [UIView animateWithDuration:0.15 animations:^{
        _footerView.frame = CGRectMake(0, KSCREENHEIGHT - 40 , KSCREENWIDTH, 40);
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
    }];
    
    [_footerView.chooseAllBtn tapControlEventTouchUpInsideWithBlock:^(UIButton *btn) {
 
        for (int i = 0; i < self.dataArray.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self.chooseArr setArray:self.dataArray];
        }
      }];
    
    [_footerView.deleateBtn tapControlEventTouchUpInsideWithBlock:^(UIButton *btn) {
        
        
        NSLog(@"------  删除 ----  %@",_chooseArr);
        
        if (_chooseArr.count == 0) {
            [self showToastWithMessage:@"请选择要删除的会话"];
            return;
        }
        
        
        NSMutableArray * idArray = [NSMutableArray new];
        
        [_chooseArr enumerateObjectsUsingBlock:^(SiXinModel * sixinModel, NSUInteger idx, BOOL * _Nonnull stop) {
            [idArray addObject:sixinModel.u_id];
        }];
 
        NSArray * array = [NSArray arrayWithArray:idArray];
        
        NSString * idStr = [array componentsJoinedByString:@"-"];
        /*
         
         删除私信
         
         get:/app.php/User/my_n_del
         u_id#接受者id（id用 - 拼接）
         uid#发送者id

         
         */
        
        [MCNetTool postWithUrl:@"/app.php/User/my_n_del" params:@{@"u_id":idStr,@"uid":kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
            
            
            [self showToastWithMessage:msg];
            
            [self editItemAction:_selectedBtn];
            
        } fail:^(NSString *error) {
            
            [self showToastWithMessage:error];

        }];

        
    }];
    
}


- (void)hidenFooterView{
    [UIView animateWithDuration:0.25 animations:^{
        _footerView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 40);
        self.tableView.tableFooterView = nil;
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
    
    PrivateMessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PrivateMessageCell"];
    SiXinModel * siXinModel = _dataArray[indexPath.row];
    cell.siXinModel = siXinModel;
    [cell setNeedsLayout];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.tableView.editing) {
        
        [self.chooseArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
        
    }else{
        
        SiXinModel * siXinModel = _dataArray[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TLChatViewController * vc  = [[TLChatViewController alloc]init];
        vc.userId =siXinModel.u_id;
        vc.navigationItem.title = siXinModel.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
//取消选中时 将存放在self.deleteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [self.chooseArr removeObject:[self.dataArray objectAtIndex:indexPath.row]];
}









- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
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
