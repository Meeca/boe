//
//  ShareViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/4.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareDeviceModel.h"
#import "ShareDeviceViewController.h"
#import "BaseModel.h"

@interface ShareViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSMutableArray * myDataArray;
@property (nonatomic, strong) NSMutableArray * allDataArray;
@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) BaseModel *baseModel;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设备分享";
    
    _baseModel = [BaseModel modelWithObserver:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"添加" target:self action:@selector(rightAddItemAction:)];

    [self addHeader];
    
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
    _page = 1;
    _myDataArray = [NSMutableArray new];
    _allDataArray = [NSMutableArray new];
    
    _titles = @[@"拥有者",@"分享者"];
    
    
//    [self loadMyShareDeviceLsitFirstPage:YES];
//    
//    
//    [self.table headerAddMJRefresh:^{
//        
//        _page = 1;
//
//        [self loadMyShareDeviceLsitFirstPage:YES];
//        
//    }];
//    
//    [self.table footerAddMJRefresh:^{
//        
//        [self loadMyShareDeviceLsitFirstPage:NO];
//        
//    }];
    
    [_baseModel app_php_ShareTo_User_equipment_list_mac_id:_macId];
    [_baseModel app_php_ShareTo_User_equipment_list_mac_id:_macId];
    
}


-(void)rightAddItemAction:(UIBarButtonItem *)item{

    ShareDeviceViewController * vc= [[ShareDeviceViewController alloc]initWithNibName:@"ShareDeviceViewController" bundle:nil];
    vc.eId = _eId;
    [Tool setBackButtonNoTitle:self];

    [self.navigationController pushViewController:vc animated:YES];

}

- (void)addHeader {
    
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_baseModel app_php_ShareTo_User_equipment_list_mac_id:_macId];
        [_baseModel app_php_ShareTo_User_equipment_list_mac_id:_macId];
        
    }];
}


ON_SIGNAL3(BaseModel,SHARETOEQUIPMENTLIST,singnal){

    [self.table.mj_header endRefreshing];
    _equip = singnal.object;
    [self.table reloadData];
}

/**
 *  加载设备列表（我分享出去的设备列表）
 *
 *  @param firstPage 是否是第一页
 */
- (void)loadMyShareDeviceLsitFirstPage:(BOOL )firstPage {

//get:/app.php/User/share_to_equipment_list
//    uid#用户id
    
    if (firstPage) {
        [_myDataArray removeAllObjects];
        [_allDataArray removeAllObjects];
        _page = 1;

    }
    
    [MCNetTool postWithUrl:@"/app.php/User/share_to_equipment_list" params:@{@"uid":kUserId,@"page":@(_page),@"pagecount":@"20"} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        _page ++;
        
        NSArray * myArray =requestDic[@"my_list"];
        
        NSArray * allArray =requestDic[@"all_list"];

        
        NSArray * myModelarray = [NSArray yy_modelArrayWithClass:[My_List class] json:myArray];
        
        NSArray * allModelarray = [NSArray yy_modelArrayWithClass:[All_List class] json:allArray];

        firstPage?[_myDataArray setArray:myModelarray]:[_myDataArray addObjectsFromArray:myModelarray];
        firstPage?[_allDataArray setArray:allModelarray]:[_myDataArray addObjectsFromArray:allModelarray];

        [self.table headerEndRefresh];
        [self.table footerEndRefresh];

        [self.table reloadData];

    } fail:^(NSString *error) {
      
        [self.table headerEndRefresh];
        [self.table footerEndRefresh];

    }];
}



#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
//        return _equip.all_list.count;
        return _equip.my_list.count;
    }
//    return _equip.my_list.count;
     return _equip.all_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    headerImg.backgroundColor = [UIColor whiteColor];
    [cell addSubview:headerImg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerImg.right + 10, 0, 100, 60)];
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:titleLabel];
    
    if (indexPath.section==0) {
        
        my_listObje * my_List = _equip.my_list[indexPath.row];
        titleLabel.text = my_List.nike;
        [headerImg sd_setImageWithURL:[NSURL URLWithString:my_List.image] placeholderImage:[UIImage imageNamed:@""]];
        
        headerImg.layer.cornerRadius = 20.0;
        headerImg.layer.masksToBounds = YES;
        
    }
    if (indexPath.section==1) {
        all_listObje * all_List = _equip.all_list[indexPath.row];
        titleLabel.text = all_List.nike;
        [headerImg sd_setImageWithURL:[NSURL URLWithString:all_List.image] placeholderImage:[UIImage imageNamed:@""]];
        
        headerImg.layer.cornerRadius = 20.0;
        headerImg.layer.masksToBounds = YES;
        
        UILongPressGestureRecognizer *lo = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
        [self.table addGestureRecognizer:lo];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * title = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 40)];
     title.text = [NSString stringWithFormat:@"   %@",_titles[section]];
     return title;
}

- (void)longTap:(UIGestureRecognizer *)lon {
    if (lon.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [lon locationInView:self.table];
        NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:point];
        NSLog(@"section---%ld", indexPath.section);
        NSLog(@"row-------%ld", indexPath.row);

        if (indexPath != nil) {
            BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"删除分享用户" message:@"删除后，该用户将不能推送图片到此设备" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
                
//                解除分享
//                
//                get:/app.php/User/shera_del
//                uid#用户id
//                mac_id#设备mac id
                
//                all_listObje * all_List = _equip.my_list[indexPath.row];
                if (index == 1) {
                    
                    [MCNetTool postWithUrl:@"/app.php/User/shera_del" params:@{@"uid":kUserId,@"mac_id":_macId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
                        
                        
                        [self showToastWithMessage:msg];
                        
                        
                        //                    [self loadMyShareDeviceLsitFirstPage:YES];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } fail:^(NSString *error) {
                        
                        [self showToastWithMessage:error];
                        
                    }];
                }
            } otherButtonTitles:@"确定"];
            [alert show];
        }
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
