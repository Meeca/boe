//
//  SettingsViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"
#import "AboutUsViewController.h"
#import "PhoneNumViewController.h"
#import "MailBindingViewController.h"
#import "FeedBackViewController.h"
#import "JDFSettingModel.h"

JDFSettingModel *jdfSettingModel;

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource> {
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic ,strong)NSMutableArray *settingArray;
@end

@implementation SettingsViewController

DEF_NOTIFICATION(LOGOUT)

- (void)viewDidLoad {
    [super viewDidLoad];
    _settingArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
    userModel = [UserModel modelWithObserver:self];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 100)];
    UIButton *logOut = [UIButton buttonWithType:UIButtonTypeCustom];
    logOut.layer.cornerRadius = 3.f;
    logOut.layer.masksToBounds = YES;
    logOut.backgroundColor = [UIColor redColor];
    logOut.frame = CGRectMake(0, 0, KSCALE(1100), 44);
    logOut.titleLabel.font = [UIFont systemFontOfSize:16];
    [logOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOut addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    logOut.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:logOut];
    [self settingLoadNet];
    self.table.tableFooterView = view;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self settingLoadNet];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)settingLoadNet
{
    
    NSString *path = @"/app.php/User/set_up";
    NSDictionary *params = @{@"uid":kUserId};
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        jdfSettingModel = [JDFSettingModel yy_modelWithJSON:requestDic];
        
        [self.table reloadData];
        
        //        for (NSDictionary * dic in (NSArray *)requestDic) {
        //
        //
        //
        //            JDFSettingModel * model = [[JDFSettingModel alloc]init];
        //            [model setValuesForKeysWithDictionary:dic];
        //            [_settingArray  addObject:model];
        
        //            JDFSettingModel * model = [JDFSettingModel yy_modelWithJSON:dic];
        //            [_settingArray  addObject:model];
        
        
        //        }
        
        
        //        NSArray * arr = [NSArray yy_modelArrayWithClass:[JDFSettingModel class] json:requestDic];
        //
        
        //        NSInteger page;
        //
        //        if (page == 1) {
        //            [_settingArray removeAllObjects];
        //        }
        //
        ////        [_settingArray setArray:arr];//  page = 1
        //
        //        [_settingArray addObjectsFromArray:arr];// page > 1
        
        
        
    } fail:^(NSString *error) {
        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //            cell.textLabel.text = @"软件升级";
            cell.textLabel.text = @"关于我们";
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"意见反馈";
            
        }
        //        else if (indexPath.row==2) {
        //
        //        }
    } else if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"手机号";
            if (!jdfSettingModel.tel.length) {
                cell.detailTextLabel.text = @"请绑定";
            }
            else
            {
                cell.detailTextLabel.text = jdfSettingModel.tel;
                
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"邮箱";
            if (!jdfSettingModel.email.length) {
                
                cell.detailTextLabel.text = @"请绑定";
            }
            else
            {
                cell.detailTextLabel.text =jdfSettingModel.email;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row==2) {
            cell.textLabel.text = @"密码修改";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"";
    }
    
    return @"账户安全";
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 ) {
        //关于我们
        if (indexPath.row == 0) {
            AboutUsViewController *aboutUsVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            
            [self.navigationController pushViewController:aboutUsVC animated:YES];
            NSLog(@"__________我们");
            
        }
        if (indexPath.row == 1) {
            NSLog(@"你点击了意见反馈");
            
            FeedBackViewController *feedBackVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
            
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }
    }
    if (indexPath.section==1) {
        //跳转到绑定手机号界面
        if (indexPath.row == 0) {
            PhoneNumViewController *phoneVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"PhoneNumViewController"];
            [self.navigationController pushViewController:phoneVC animated:YES];
        }
        //跳转到绑定邮箱
        if (indexPath.row == 1) {
            
            MailBindingViewController *mailVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"MailBindingViewController"];
            [self.navigationController pushViewController:mailVC animated:YES];
            
        }
        
        
        //跳转到修改密码界面
        if (indexPath.row==2) {
            NSLog(@"你——————————————-密码");
            ChangePasswordViewController *changePassVC = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
            
            [self.navigationController pushViewController:changePassVC animated:YES];
            
        }
    }
}

- (void)logOutAction:(UIButton *)btn {
    BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"确定退出登录?" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
        if (index == 1) {
            [self logOut];
        }
    } otherButtonTitles:@"确定"];
    [alert show];
}

- (void)logOut {
    [userModel loadCache];
    [userModel clearCache];
    
    UserInfoModel * userInfoModel = [[UserInfoModel alloc] init];
    [UserManager archiverModel:userInfoModel];
    
    [self postNotification:self.LOGOUT];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [Tool performBlock:^{
        [self presentViewController:nav animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [Tool performBlock:^{
                appDelegate.ctrl.selectedIndex = 0;
            } afterDelay:.3];
        }];
    } afterDelay:1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
