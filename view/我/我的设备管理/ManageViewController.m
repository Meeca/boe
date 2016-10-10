//
//  ManageViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/23.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "ManageViewController.h"
#import "FrameViewController.h"
#import "TwoCodeVCtrl.h"
#import "BaseModel.h"
#import "ManageModel.h"

@interface ManageViewController () <UITableViewDelegate, UITableViewDataSource> {
    BaseModel *baseModel;
    
    NSArray *dataArr;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSArray *shareToMeDeviceArray;

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的设备管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    
    self.table.tintColor = [UIColor grayColor];
    
    baseModel = [BaseModel modelWithObserver:self];
    
    [self addHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [baseModel app_php_User_equipment_list];
    [baseModel app_php_Share_User_equipment_list];
//    [self loadShareToMeDeviceList];
    
}
- (void)addHeader {
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [baseModel app_php_User_equipment_list];
        [baseModel app_php_Share_User_equipment_list];
//         [self loadShareToMeDeviceList];
        
    }];
}
ON_SIGNAL3(BaseModel, EQUIPMENTLIST, signal) {
    [self.table.mj_header endRefreshing];
    dataArr = signal.object;
    [self.table reloadData];
}

ON_SIGNAL3(BaseModel, SHAREEQUIPMENTLIST, signal){
    _shareToMeDeviceArray = signal.object;
    [self.table reloadData];
}


- (void)loadShareToMeDeviceList{

    /*
     get:/app.php/User/share_equipment_list
     uid#用户id
     

     
     */
    
    
    
//    [MCNetTool postWithUrl:@"/app.php/User/share_equipment_list" params:@{@"uid":kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
    
    [MCNetTool getWithUrl:@"/app.php/User/share_equipment_list" params:@{@"uid":kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
    
        _shareToMeDeviceArray = [NSArray yy_modelArrayWithClass:[ManageModel class] json:requestDic];
        
        NSLog(@"1111---%@",[_shareToMeDeviceArray objectToString]);
        
        [self.table reloadData];
        
        
    } fail:^(NSString *error) {
        
    }];
}




#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return dataArr.count;
    }
    return _shareToMeDeviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.text = @"       Gallery 客厅";
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    img.center = CGPointMake(25, 55/2);
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = [UIImage imageNamed:@"切图 QH 20160704-8"];
    [cell.contentView addSubview:img];
    
    if (indexPath.section==0) {
        EquipmentList *list = dataArr[indexPath.row];
        cell.textLabel.text = [@"       " stringByAppendingString:list.title.length>0?list.title:@""];
    }
    
    if (indexPath.section==1) {
        EquipmentList * manageModel = _shareToMeDeviceArray[indexPath.row];
        cell.textLabel.text = [@"       " stringByAppendingString:manageModel.title.length>0?manageModel.title:@""];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        EquipmentList *list = dataArr[indexPath.row];
        FrameViewController *vc = [[FrameViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.list = list;
        [Tool setBackButtonNoTitle:self];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section==1){
        EquipmentList *s = _shareToMeDeviceArray[indexPath.row];
        FrameViewController *vc = [[FrameViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.list = s;
        [Tool setBackButtonNoTitle:self];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return @"我的Gallery";
    } else if (section==1) {
        return @"分享的Gallery";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.01f;
}

- (void)add:(UIBarButtonItem *)item {
    TwoCodeVCtrl *vc = [[TwoCodeVCtrl alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
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
