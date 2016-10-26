//
//  MeViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "MeViewController.h"
#import "ArtGalleryViewController.h"
#import "FriendViewController.h"
#import "FansViewController.h"
#import "MessageViewController.h"
#import "PersonalDataVCtrol.h"
#import "MyOrderViewController.h"
#import "AddressViewController.h"
#import "SettingsViewController.h"
#import "UpDataViewController.h"
#import "MyBuyViewController.h"
#import "WalletViewController.h"
#import "PhotoUpLoadAgreementViewController.h"
#import "UserBalanceModel.h"

UserBalanceModel *userBlance;

@interface MeViewController () <UITableViewDelegate, UITableViewDataSource> {
    UIView *header;
    UIImageView *shadowImageView;
    NSInteger userSelectedChannelID;
    
    UserModel *userModel;
    UserInfoModel *userModel1;
    UserInfo *info;
    
    UIImageView *background;
    UIImageView *icon;
    UILabel *name;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我";
    self.table.backgroundColor = RGB(234, 234, 234);
    
    //    userModel = [UserModel modelWithObserver:self];
    
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, INTROHEIGHT+44)];
    
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, INTROHEIGHT)];
    background.image = [UIImage imageNamed:@"个人主页bj1"];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.clipsToBounds = YES;
    [header addSubview:background];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataSucc:) name:UPDATASUCC object:nil];
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.layer.borderWidth = 1;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.layer.cornerRadius = icon.width/2;
    icon.layer.masksToBounds = YES;
    [background addSubview:icon];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.text = @"用户昵称";
    name.font = [UIFont boldSystemFontOfSize:17];
    name.textColor = [UIColor whiteColor];
    [background addSubview:name];
    [name sizeToFit];
    
    icon.y = (background.height-icon.height-name.height-10)/2;
    icon.centerX = background.width/2;
    name.y = icon.bottom+10;
    name.centerX = background.width/2;
    
    NSArray *title = @[@"艺术馆", @"关注 0", @"粉丝 0", @"消息"];
    shadowImageView = [[UIImageView alloc] init];
    shadowImageView.backgroundColor = KAPPCOLOR;
    
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(KSCREENWIDTH/4*i, header.height-44, KSCREENWIDTH/4, 44)];
        [button setTag:i+100];
        [button setTitle:title[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:KAPPCOLOR forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:button];
        shadowImageView.frame = CGRectMake(-button.width, button.height-2, button.width, 2);
        shadowImageView.bottom = button.bottom;
    }
    [header addSubview:shadowImageView];
    [self.table addSubview:header];
    
    [self laodUserinfoData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    [userModel app_php_Use_user_info];
    
    [self laodUserinfoData];
    [self loadUserBalanceNetData];
    
    NSArray *arr = @[@"个人主页bj1", @"个人主页bj2", @"个人主页bj2", @"个人主页bj1", @"个人主页bj1", @"个人主页bj2"];
    NSInteger index = arc4random_uniform(100)%6;
    
    background.image = [UIImage imageNamed:arr[index]];
}
- (void)loadUserBalanceNetData
{
    
    NSString *path = @"/app.php/User/balance";
    NSDictionary *params = @{
                             @"uid":kUserId,
                             
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         userBlance = [UserBalanceModel yy_modelWithJSON:requestDic];
         [self.table reloadData];
     }
                      fail:^(NSString *error) {
                          
                      }];
    
}

-(void)laodUserinfoData{
    
    [MCNetTool postWithUrl:@"/app.php/User/user_info" params:@{@"uid":kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        
        UserInfoModel * userInfoModel = [UserInfoModel yy_modelWithJSON:requestDic];
        
        [UserManager archiverModel:userInfoModel];
        [self.table reloadData];
        
        
        [self updateUI];
        
        
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
}



ON_SIGNAL3(UserModel, USERINFO, signal) {
    info = signal.object;
    [self.table reloadData];
    
    [self updateUI];
}


- (void)updateUI{
    
    [icon sd_setImageWithURL:[NSURL URLWithString:kImage] placeholderImage:[UIImage imageNamed:@"个人主页icon"]];
    name.text = kNike;
    [name sizeToFit];
    
    icon.y = (background.height-icon.height-name.height-10)/2;
    icon.centerX = background.width/2;
    name.y = icon.bottom+10;
    name.centerX = background.width/2;
    
    UIButton *btn1 = [header viewWithTag:101];
    UIButton *btn2 = [header viewWithTag:102];
    //    NSString *title1 = [NSString stringWithFormat:@"关注 %@", kCollection_num.length>0?kCollection_num:@"0"];
    NSString *title1 = [NSString stringWithFormat:@"关注 %@",kCollection_num.length>0?kCollection_num:@"0"];
    NSString *title2 = [NSString stringWithFormat:@"粉丝 %@", kFans.length>0?kFans:@"0"];
    
    [btn1 setTitle:title1 forState:UIControlStateNormal];
    [btn2 setTitle:title2 forState:UIControlStateNormal];
    
}






- (void)upDataSucc:(NSNotification *)not {
    BOOL isPublic = [not.object boolValue];
    
    NSArray *views = self.navigationController.viewControllers;
    if (views.count>1) {
        return;
    }
    ArtGalleryViewController *vc = [[ArtGalleryViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    vc.index = isPublic ? 1 : 2;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 1;
    }
//    else if (section == 4) {
//        return 1;
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    img.center = CGPointMake(25, 55/2);
    img.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"个人资料";
            
            img.image = [UIImage imageNamed:@"C-1-3"];
            [cell.contentView addSubview:img];
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"身份认证";
            
            if ([userBlance.authen integerValue] == 1) {
                cell.detailTextLabel.text = @"待审核";
                cell.detailTextLabel.textColor = [UIColor redColor];
                
//                [self showToastWithMessage:@"待审核"];
            }
            else if([userBlance.authen integerValue] == 2)
            {
                //通过
                cell.detailTextLabel.text = @"通过";
                //                cell.detailTextLabel.textColor = [UIColor redColor];
//                [self showToastWithMessage:@"通过"];
            }
            else{
                //是否认证（0未认证，1待审核，2通过，3不通过）
                //未认证------不通过进去修改信息
                if ([userBlance.authen integerValue] == 0) {
                    cell.detailTextLabel.text = @"未认证";
//                    [self showToastWithMessage:@"未认证"];
                }
                else  if([userBlance.authen integerValue]== 3)
                {
                    cell.detailTextLabel.text = @"不通过";
                    cell.detailTextLabel.textColor = [UIColor redColor];
//                    [self showToastWithMessage:@"不通过"];
                    
                }
                
                
            }

            img.image = [UIImage imageNamed:@"C-2-03-3"];
            [cell.contentView addSubview:img];
        }
    } else if (indexPath.section==2) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"我购买的";
            
            img.image = [UIImage imageNamed:@"C-3-3"];
            [cell.contentView addSubview:img];
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"我出售的";
            
            img.image = [UIImage imageNamed:@"C-4-3"];
            [cell.contentView addSubview:img];
        } else if (indexPath.row==2) {
            cell.textLabel.text = @"钱包";
//            cell.detailTextLabel.text = @"118";
            cell.detailTextLabel.textColor = KAPPCOLOR;
            
            img.image = [UIImage imageNamed:@"C-5-3"];
            [cell.contentView addSubview:img];
        } else if (indexPath.row==3) {
            cell.textLabel.text = @"收货地址";
            
            img.image = [UIImage imageNamed:@"C-6-3"];
            [cell.contentView addSubview:img];
        }
    }
//    else if (indexPath.section==3) {
//        cell.textLabel.text = @"我的艺术基因测试";
//        
//        img.image = [UIImage imageNamed:@"C-7-3"];
//        [cell.contentView addSubview:img];
//    }
    else if (indexPath.section==3) {
        cell.textLabel.text = @"设置";
        
        img.image = [UIImage imageNamed:@"C-8-3"];
        [cell.contentView addSubview:img];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) { // 个人资料
            PersonalDataVCtrol *vc = [[PersonalDataVCtrol alloc] init];
            [Tool setBackButtonNoTitle:self];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row==1) {

            if ([userBlance.authen integerValue] == 1) {
                //待审核
                    #pragma mark ------待审核,不可点击


               
  
            }
            else if([userBlance.authen integerValue] == 2)
            {
#pragma mark --- 通过
            }
            
            else
            {
                if ([userBlance.authen integerValue] == 0) {
#pragma mark ------ 未认证
              PhotoUpLoadAgreementViewController *photoAgreenmentVC = [[UIStoryboard storyboardWithName:@"UserCertification" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoUpLoadAgreementViewController"];
                [self.navigationController pushViewController:photoAgreenmentVC animated:YES];
                
                }
                else  if([userBlance.authen integerValue]== 3)
                {
#pragma mark ------ 不通过
              PhotoUpLoadAgreementViewController *photoAgreenmentVC = [[UIStoryboard storyboardWithName:@"UserCertification" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoUpLoadAgreementViewController"];
                    
                    photoAgreenmentVC.aID = userBlance.authen_id;
                    photoAgreenmentVC.authon = userBlance.authen;
                  [self.navigationController pushViewController:photoAgreenmentVC animated:YES];
                }

            
            }
             NSLog(@"_________用户认证");
            
        }
    } else if (indexPath.section==2) {
        if (indexPath.row==0) { //  我购买的
            MyBuyViewController *vc = [[MyBuyViewController alloc] init];
            [Tool setBackButtonNoTitle:self];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row==1) { //  我出售的
            MyOrderViewController *vc = [[MyOrderViewController alloc] init];
            [Tool setBackButtonNoTitle:self];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row==2) { //  我的钱包
            WalletViewController *vc = [[WalletViewController alloc] init];
            [Tool setBackButtonNoTitle:self];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row==3) { //  收货地址
            AddressViewController *vc = [[AddressViewController alloc] init];
            [Tool setBackButtonNoTitle:self];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
//    else if (indexPath.section==3) {  // 我的基因
//        
//    }
    else if (indexPath.section==3) {  // 设置
        SettingsViewController *vc = [[SettingsViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 65)];
        view.backgroundColor = tableView.backgroundColor;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:KAPPCOLOR];
        [btn setTitle:@"上传作品" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(upDate:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, KSCALE(888), 44);
        btn.center = view.center;
        [view addSubview:btn];
        
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return .01f;
    } else if (section == 1) {
        return 65;
    } else if (section == 2) {
        return 25;
    }
//    else if (section == 3) {
//        return 15;
//    }
    else if (section == 3) {
        return 25;
    }
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==3) {
        return 60;
    }
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return INTROHEIGHT+44;
    }
    return 55;
}

- (void)selectNameButton:(UIButton *)sender {
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[header viewWithTag:userSelectedChannelID];
        if (userSelectedChannelID) {
            lastButton.selected = NO;
        }
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            shadowImageView.centerX = sender.centerX;
        }];
    }
    
    if (sender.tag-100 == 0) { //  艺术馆
        ArtGalleryViewController *vc = [[ArtGalleryViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (sender.tag-100 == 1) { // 关注
        FriendViewController *vc = [[FriendViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (sender.tag-100 == 2) { //  粉丝
        FansViewController *vc = [[FansViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (sender.tag-100 == 3) { //  消息
        MessageViewController *vc = [[MessageViewController alloc] init];
        [Tool setBackButtonNoTitle:self];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)upDate:(UIButton *)btn {
    UpDataViewController *vc = [[UpDataViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    vc.title = @"选择作品";
    [self presentViewController:nav animated:YES completion:NULL];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
