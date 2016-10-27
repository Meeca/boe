//
//  FrameShareViewController.m
//  jingdongfang
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FrameShareViewController.h"
#import "ShareViewController.h"
#import "BaseModel.h"
#import "ChangeDeviceNameViewController.h"
#import "FrameViewModel.h"


@interface FrameShareViewController () {
    
    BaseModel *baseModel;
    
    EquipmentList *listInfo;
    
    FrameViewModel * frameViewModel;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FrameShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"画框设置";
    
    
    [self loadDeviceInfoData];
    
    baseModel = [BaseModel modelWithObserver:self];
    [self addHeader];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

//http://boe.ccifc.cn//app.php/User/equipment_info?uid=115&e_id=206

- (void)loadDeviceInfoData{
    
    [MCNetTool postWithUrl:@"/app.php/User/equipment_info" params:@{@"uid":kUserId,@"e_id":self.list.e_id} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        frameViewModel = [FrameViewModel yy_modelWithJSON:requestDic];
        [self.tableView reloadData];
        
    } fail:^(NSString *error) {
        
    }];
}



- (void)addHeader {
    
    [baseModel app_php_User_equipment_infoWithE_id:self.list.e_id];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [baseModel app_php_User_equipment_infoWithE_id:self.list.e_id];
        [self loadDeviceInfoData];
        
    }];
}

ON_SIGNAL3(BaseModel, EQUIPMENTINFO, signal) {
    [self.tableView.mj_header endRefreshing];
    listInfo = signal.object;
    [self.tableView reloadData];
}

ON_SIGNAL3(BaseModel, EQUIPMENTDEL, signal) {
    [Tool performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:.3];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"重命名";
            cell.detailTextLabel.text = frameViewModel.title.length>0?frameViewModel.title:@"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"设备ID";
            cell.detailTextLabel.text = frameViewModel.mac_id.length>0?frameViewModel.mac_id:@"";
        }
    }
    
    if (indexPath.section==1) {
        cell.textLabel.text = @"设备解绑";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0 ) {
            ChangeDeviceNameViewController * vc = [[ ChangeDeviceNameViewController alloc]initWithNibName:@"ChangeDeviceNameViewController" bundle:nil];
            vc.name =frameViewModel.title;
            vc.e_id = frameViewModel.e_id;
            vc.changeDeviceNameBlock = ^(NSString * name){
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = name;
            };
            [Tool setBackButtonNoTitle:self];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section==1) {

        BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"确定与此设备解绑？" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
            if (index==1) {
                
                [baseModel app_php_User_equipment_delWithMac_id:listInfo.mac_id.length > 0 ? listInfo.mac_id:@""];
            }
        } otherButtonTitles:@"确定"];
        
        [alert show];
    
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.01f;
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
