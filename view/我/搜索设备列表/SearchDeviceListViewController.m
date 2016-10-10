//
//  SearchDeviceListViewController.m
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "SearchDeviceListViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "SearchDeviceCell.h"
#import "SearchDeviceModel.h"


@interface SearchDeviceListViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SearchDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    
    UITextField * searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH - 128, 34)];
    searchTextField.delegate = self;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.placeholder = @"用户注册邮箱/手机号";
    self.navigationItem.titleView = searchTextField;
    searchTextField.textAlignment = NSTextAlignmentCenter;
    [searchTextField addTarget:self action:@selector(textFieldSearchChangeValue:) forControlEvents:UIControlEventEditingChanged];

    [_tableView registerNib:[UINib nibWithNibName:@"SearchDeviceCell" bundle:nil] forCellReuseIdentifier:@"SearchDeviceCell"];
    _tableView.tableFooterView = [UIView new];
    
    [self loadSearchData];
    // Do any additional setup after loading the view from its nib.
}

- (void)textFieldSearchChangeValue:(UITextField *)textField{
    
    NSString * text = textField.text;
    
    _searchKey = text;
    
    [self loadSearchData];

}


/*
 搜索设备
 get:/app.php/User/shera_search
 tel#邮箱或手机号
 */

- (void)loadSearchData{

//    _searchKey = @"15201453583";
    
    [MCNetTool postWithUrl:@"/app.php/User/shera_search" params:@{@"tel":checkNULL(_searchKey), @"uid":kUserId, @"e_id":_eId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[SearchDeviceModel class] json:requestDic];
        
        [_dataArray setArray:array];
        
        [_tableView reloadData];
        
    } fail:^(NSString *error) {
        
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
    
    SearchDeviceCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SearchDeviceCell"];
    
    SearchDeviceModel * searchDeviceModel = _dataArray[indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:searchDeviceModel.image] placeholderImage:nil];
    cell.nameLab.text = searchDeviceModel.title;
    cell.phonelab.text = searchDeviceModel.mac_id;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     
     添加设备
     
     get:/app.php/User/equipment_add
     uid#用户id
     title#设备名称
     mac_id#设备mac id
     
     */
    SearchDeviceModel * searchDeviceModel = _dataArray[indexPath.row];
 
    [MCNetTool postWithUrl:@"/app.php/User/equipment_add" params:@{@"uid":searchDeviceModel.uid,@"title":searchDeviceModel.title,@"mac_id":searchDeviceModel.mac_id} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        
        [self pushMessageWithU_id:searchDeviceModel.uid title:searchDeviceModel.title mac_id:searchDeviceModel.mac_id];
        
        
    } fail:^(NSString *error) {
       
        [self showToastWithMessage:error];
        
    }];
    
    
    
}



- (void)pushMessageWithU_id:(NSString *)u_id title:(NSString *)title mac_id:(NSString *)mac_id{

    /*
     
     极光推送，适用于分享流程
     
     get:/app.php/User/shera_push
     uid#接受者id
     u_id#发送者id
     content#发送内容（根据原型定义文字）
     mac_id#设备id
     types  1
     返回值：
     
     */
    
    [MCNetTool postWithUrl:@"/app.php/User/shera_push" params:@{@"u_id":kUserId,@"uid":u_id,@"content":title,@"mac_id":mac_id,@"types":@"1"} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        
        BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"提示" message:@"分享邀请已发出" cancelButtonTitle:nil clickButton:^(NSInteger index) {

        
        } otherButtonTitles:@"确定"];
        
        [alert show];

    } fail:^(NSString *error) {
        
        [self showToastWithMessage:error];
        
    }];

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
