//
//  ShareDeviceViewController.m
//  jingdongfang
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ShareDeviceViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ShareDeviceHeaderView.h"
#import "SearchDeviceListViewController.h"



@interface ShareDeviceViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tabeleView;

@property (nonatomic, copy) NSString  *searchKey;

@end

@implementation ShareDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"分享设备";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"A-back_single" highImage:@"A-back_single" target:self action:@selector(rightSearchItemAction:)];
    
    _searchKey = @"";
    
    ShareDeviceHeaderView * headView = [ShareDeviceHeaderView shareDeviceHeaderView];
    
    _tabeleView.tableFooterView = headView;
    headView.textField.delegate = self;
    [headView.textField addTarget:self action:@selector(textFieldChangeValue:) forControlEvents:UIControlEventEditingChanged];
    
    [headView.textField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}


- (void)textFieldChangeValue:(UITextField *)textField{
    NSString * text = textField.text;
    _searchKey = text;

}

- (void)rightSearchItemAction:(UIBarButtonItem *)item{


    [self.navigationController popViewControllerAnimated:YES];

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    /// 调用你需要处理的事情  ///
    
    SearchDeviceListViewController * vc= [[SearchDeviceListViewController alloc]initWithNibName:@"SearchDeviceListViewController" bundle:nil];
    vc.eId = _eId;
    
    [Tool setBackButtonNoTitle:self];
    vc.searchKey = _searchKey;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    return YES;
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
