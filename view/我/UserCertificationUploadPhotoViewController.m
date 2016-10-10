//
//  UserCertificationUploadPhotoViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "UserCertificationUploadPhotoViewController.h"
#import "PictureUpLoad.h"
#import "UIViewController+XHPhoto.h"


PictureUpLoad *pictureUpLoad;

@interface UserCertificationUploadPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *zhengBtn;
@property (weak, nonatomic) IBOutlet UIImageView *zhengImageView;
@property (weak, nonatomic) IBOutlet UIButton *fanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fanImageView;
@property (weak, nonatomic) IBOutlet UILabel *zhengLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanLabel;



@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imageUrls;



@end

@implementation UserCertificationUploadPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户认证";
    _images = [NSMutableArray array];
    _imageUrls = [NSMutableArray array];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    _imageUrls = [NSMutableArray new];
    _images = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---- 上传正面的照片
- (IBAction)zhengClickBtn:(id)sender {
    
    [self uploadPhotoFace];
  }
#pragma mark ------- 上传反面的照片
- (IBAction)fanClickBtn:(id)sender {
    [self uploadPhotoFan];
}
#pragma mark ------- 提交申请
- (IBAction)confirmAgreement:(id)sender {
    
    NSString * imagesStr = [self array2string:_imageUrls];
    
    NSString *path = @"/app.php/User/authen";
    NSDictionary *params = @{
                             @"a_id":@"",
                             @"uid":kUserId,
                             @"type":@"1",
                             @"order_code":_paperNum,
                             @"name":_paperName,
                             @"tel":_paperPhoneNum,
                             @"order_image":imagesStr,
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self.navigationController popToRootViewControllerAnimated:YES];
        
     }
                      fail:^(NSString *error) {
                          
                      }];

}
- (NSString *)array2string:(NSArray *)array{
    if (array.count == 0) {
        return @"";
    }
    NSString *ns=[array componentsJoinedByString:@"-"];
    return ns;
}
-(void)uploadPhotoFace
{

    
    [self showCanEdit:YES photo:^(UIImage *photo, NSData *imageData) {
       
        _zhengImageView.image = photo;
        
        _zhengBtn.hidden = YES;
        _zhengLabel.hidden = YES;
        
        NSString *path = @"/app.php/User/image_add";
     
//        NSData *data = UIImageJPEGRepresentation(_zhengImageView.image, 1.0f);
        
            NSDictionary *params = @{
                                   @"image":photo,
        
                                   };
        //    NSDictionary *parameters = @{@"type" : @"2"};
        
        
        [MCNetTool uploadDataWithURLStr:path withDic:params imageKey:@"image" withData:imageData uploadProgress:^(NSString *progress) {
            
            
          
            
        } success:^(NSDictionary *requestDic, NSString *msg) {
            
            
            pictureUpLoad = [PictureUpLoad yy_modelWithJSON:requestDic];
//            NSLog[@"_______%@_______",pictureUpLoad.image_url ];
            [_imageUrls addObject:pictureUpLoad.image_url];
            
        } failure:^(NSString *error) {
            
        }];
        
        
    }];
    

}


-(void)uploadPhotoFan
{
    
    [self showCanEdit:YES photo:^(UIImage *photo, NSData *imageData) {
        
        _fanImageView.image = photo;
       
        _fanBtn.hidden = YES;
        _fanLabel.hidden = YES;
        
        NSString *path = @"/app.php/User/image_add";
        
        
        //        NSData *data = UIImageJPEGRepresentation(_zhengImageView.image, 1.0f);
        
        //    NSDictionary *params = @{
        //                           @"image":,
        //
        //                           };
        //    NSDictionary *parameters = @{@"type" : @"2"};
        
        
        [MCNetTool uploadDataWithURLStr:path withDic:nil imageKey:@"image" withData:imageData uploadProgress:^(NSString *progress) {
            
            
        } success:^(NSDictionary *requestDic, NSString *msg) {
            
            pictureUpLoad = [PictureUpLoad yy_modelWithJSON:requestDic];
            //            NSLog[@"_______%@_______",pictureUpLoad.image_url ];
            [_imageUrls addObject:pictureUpLoad.image_url];
            
            
        } failure:^(NSString *error) {
            
        }];
        
        
    }];
}


- (void)upLoadConfirm
{

    NSString *path = @"/app.php/User/authen";

    NSDictionary *params = @{
                             
                                 @"a_id":@"",
                                 @"uid":kUserId,
                                 @"type":_paperType,
                                 @"order_code":_paperNum,
                                 @"name":_paperName,
                                 @"tel":_paperNum,
                                 @"order_image":@"",
                                 
                                 };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
    } fail:^(NSString *error) {
        
    }];


}

/*
 //get:/app.php/User/authen
 //a_id#认证id(不为空表示修改)
 //uid#用户id
 //type#证件类型
 //order_code#证件号码
 //name#证件姓名
 //tel#手机号码
 //order_image#证件照，（正反面，用 - 拼接，正面照在前面）
  */

@end
