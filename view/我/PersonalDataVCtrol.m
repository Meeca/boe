//
//  PersonalDataVCtrol.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PersonalDataVCtrol.h"
#import "NickViewController.h"
#import "MosViewController.h"

@interface PersonalDataVCtrol () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UserModel *userModel;
    UserInfoModel * userInfoModel;
//    UserInfoModel *userModel;
    
    UserInfo *info;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation PersonalDataVCtrol

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    
    userModel = [UserModel modelWithObserver:self];
    
    
    
    
    
}


-(void)laodUserinfoData{

    [MCNetTool postWithUrl:@"/app.php/User/user_info" params:@{@"uid":kUserId} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        
        userInfoModel = [UserInfoModel yy_modelWithJSON:requestDic];
        
        [UserManager archiverModel:userInfoModel];
        [self.table reloadData];
        
        
    } fail:^(NSString *error) {
        
    }];

}



- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self laodUserinfoData];

}


ON_SIGNAL3(UserModel, USERINFO, signal) {
    info = signal.object;
    [self.table reloadData];
}

ON_SIGNAL3(UserModel, USERIMAGE, signal) {
    [userModel app_php_Use_user_info];
    
    
    [self laodUserinfoData];
}

#pragma mark — UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 2;
    } 
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"头像";
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
            [icon sd_setImageWithURL:[NSURL URLWithString:kImage] placeholderImage:KZHANWEI];
            icon.layer.cornerRadius = icon.width/2;
            icon.layer.masksToBounds = YES;
            icon.contentMode = UIViewContentModeScaleAspectFill;
            icon.clipsToBounds = YES;
            icon.backgroundColor = KAPPCOLOR;
            cell.accessoryView = icon;
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"昵称";
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = kNike;

        } else if (indexPath.row==2) {
            cell.textLabel.text = @"简介";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"ID";
            
            cell.detailTextLabel.text = kUserId;
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"积分";
            
            cell.detailTextLabel.text = @"738";
            cell.detailTextLabel.textColor = KAPPCOLOR;
        }
    } else if (indexPath.section==2) {
        if (indexPath.row==0) {
            if (height) {                
                cell.textLabel.text = @"登录帐号";
                cell.detailTextLabel.text = userInfoModel.tel;
            }
            
        } else if (indexPath.row==1) {
            cell.textLabel.text = @"帐号类型";
            
//            cell.detailTextLabel.text = @"手机";
            if (!userInfoModel.type.length) {
                cell.detailTextLabel.text = @"手机号";
            }
            
            else
            {
                if ([userInfoModel.type integerValue] == 1) {
                    cell.detailTextLabel.text = @"微信";
                } else if ([userInfoModel.type integerValue] == 2) {
                    cell.detailTextLabel.text = @"QQ";
                } else if ([userInfoModel.type integerValue] == 3) {
                    cell.detailTextLabel.text = @"新浪";
                }
                
            
            }
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
            [sheet showInView:self.view];
        } else if (indexPath.row==1) {
            NickViewController *vc = [[NickViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.nick = kNike;
            [Tool setBackButtonNoTitle:self];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row==2) {
            MosViewController *vc = [[MosViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.context = kContent;
            [Tool setBackButtonNoTitle:self];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        if ([userInfoModel.type integerValue] == 1) {
            return 0;
        } else if ([userInfoModel.type integerValue] == 2) {
            return 0;
        } else if ([userInfoModel.type integerValue] == 3) {
            return 0;
        }
        return 0;
    }
    return 55;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%@", @(buttonIndex));
    if (buttonIndex==0) { // 拍照
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor orangeColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:NULL];

    } else if (buttonIndex==1) { // 相册
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor orangeColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)infoo {
    NSLog(@"%@", infoo);
    UIImage *image = infoo[UIImagePickerControllerEditedImage];
    
    NSString *urlstr = [@"http://boe.ccifc.cn/" stringByAppendingString:@"/app.php/Index/image_add"];
    
    NSString *url = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    NSDictionary *parameters = @{@"type" : @"2"};
    
    [[BoeHttp shareHttp] postWithUrl:url parameters:parameters data:data progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"result"] isEqualToString:@"succ"]) {
                NSDictionary *imgDic = responseObject[@"info"];
                
                UIWindow *win = [UIApplication sharedApplication].keyWindow;
                [win dismissTips];
                [userModel app_php_User_user_imageWithImage:imgDic[@"image_url"]];
            }
        } else {
            UIWindow *win = [UIApplication sharedApplication].keyWindow;
            [win presentMessageTips:@"数据格式错误"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win presentMessageTips:@"图片上传失败"];
        NSLog(@"%@", error);
    }];
    
//    [MCNetTool postWithUrl:url params:parameters hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
//        <#code#>
//    } fail:^(NSString *error) {
//        <#code#>
//    }]
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [userModel app_php_Use_user_info];
//}

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
