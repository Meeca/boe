//
//  CirclePropertyTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CirclePropertyTableViewController.h"
#import "CirclesRead.h"
#import "CreatCircleTableViewController.h"
#import "PictureUpLoad.h"
#import "UIViewController+XHPhoto.h"
#import "MCHttp.h"
#import "UIViewController+MBShow.h"

PictureUpLoad *pictureUpLoad;

@interface CirclePropertyTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;//属性
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;


@end

//"c_id": "1",                    //圈id
//"title": "zuopin",              //圈名称
//"image": "dfsf1ds5f1s51.jpg",   //圈图地址
//"icons": "dfsf1ds5f1s51.jpg",   //圈二维码
//"content": "梵高",               //圈简介
//"created_at": "14856325896",              //发布时间
//"attributes": "1",      //属性（1公开，2密码）
//"pass": "123456",      //密码
//"convers_num": "2",     //话题数量

@implementation CirclePropertyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconImageView.layer.cornerRadius = 20;
    self.iconImageView.layer.masksToBounds = YES;
    self.title =@"圈儿属性";
    
}
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:YES];
    [self loadCircleAttribute];
}
#pragma mark ------ 上传图像
-(void)UpLoadPicture
{
    
    
    [self showCanEdit:YES photo:^(UIImage *photo, NSData *imageData) {
        
        _iconImageView.image = photo;
        
        NSString *path = @"/app.php/User/image_add";
        
        //        NSData *data = UIImageJPEGRepresentation(_zhengImageView.image, 1.0f);
        
        NSDictionary *params = @{
                                 @"image":photo,
                                 
                                 };
        //    NSDictionary *parameters = @{@"type" : @"2"};
        
        
        [MCNetTool uploadDataWithURLStr:path withDic:params imageKey:@"image" withData:imageData uploadProgress:^(NSString *progress) {
            
            
            
            
        } success:^(NSDictionary *requestDic, NSString *msg) {
            
            
            pictureUpLoad = [PictureUpLoad yy_modelWithJSON:requestDic];
            NSString *path = @"/app.php/Circles/add";
            NSDictionary *params = @{
                                     @"c_id" : self.circleLabelNew.text,
                                     @"u_id" : kUserId,
                                     @"title" : self.nameLabel.text,
                                     @"attributes" : self.circlesRead.attributes,
                                     @"pass" : self.passwordLabel.text,
                                     @"image" : pictureUpLoad.image_url,
                                     @"content":self.introduceLabel.text,
                                     };
            [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
             {
                 [self showToastWithMessage:msg];
                 
                 [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:pictureUpLoad.image_url] placeholderImage:nil];
                 
                 [self.tableView reloadData];
                 
             }
                              failure:^(NSString *error) {
                                  
                              }];
            
            //            [_imageUrls addObject:pictureUpLoad.image_url];
            
        } failure:^(NSString *error) {
            
        }];
        
        
    }];
    
    
}


#pragma mark -------修改接口


- (void)loadCircleAttribute
{
    
    NSString *path = @"/app.php/Circles/read";
    NSDictionary *params = @{
                             @"c_id" : self.circlesRead.cId,
                             };
    [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         _circlesRead = [CirclesRead yy_modelWithJSON:requestDic];
         
         
         [self fuzhi];
         [self.tableView reloadData];
         
         //         CirclePropertyTableViewController *circlePropertyVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CirclePropertyTableViewController"];
         //
         //         circlePropertyVC.circlesRead = _circlesRead;
         //
         //         [self.navigationController pushViewController:circlePropertyVC animated:YES];
         
     }
                      failure:^(NSString *error)
     {
         
     }];
    
    
    
}
- (void)fuzhi
{
    self.nameLabel.text = self.circlesRead.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.circlesRead.image] placeholderImage:nil];
    [self.QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:self.circlesRead.icons] placeholderImage:nil ];
    self.circleLabelNew.text = self.circlesRead.cId;
//    self.timeLabel.text = self.circlesRead.createdAT;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.circlesRead.createdAT];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    
    if (self.circlesRead.attributes.integerValue == 1)
    {
        self.attributeLabel.text = @"公开";
        
    }
    else
    {
     self.attributeLabel.text = @"私密";
    }
//    self.attributeLabel.text  = self.circlesRead.attributes;
    self.passwordLabel.text = self.circlesRead.pass;
    self.introduceLabel.text = self.circlesRead.content;
    
    
}

- (void)changeContent

{



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 5;
        
    }
    else if (section ==1)
    {
        return 2;
    
    }
    return 1;
    
}

//名称
- (IBAction)mingchengBtnClick:(id)sender {
    
    if ([self.circlesRead.u_id isEqualToString:kUserId]) {
        CreatCircleTableViewController *createTopicVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatCircleTableViewController"];
        createTopicVC.type = 2;
        createTopicVC.c_id =self.circlesRead.cId;
        createTopicVC.name = self.circlesRead.title;
        createTopicVC.attribute = self.circlesRead.attributes;
        createTopicVC.product = self.circlesRead.content;
        createTopicVC.againPassword = self.circlesRead.pass;
        [self.navigationController pushViewController:createTopicVC animated:YES];
    }
    else
    {
        
        [self showToastWithMessage:@"没有权限修改"];
        
    }
}
//头像
- (IBAction)touxiangBtnClick:(id)sender
{
    
    if ([self.circlesRead.u_id isEqualToString:kUserId]) {
        
        [self UpLoadPicture];
    }
    else
    {
        [self showToastWithMessage:@"没有权限修改"];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)shuxingBtnClick:(id)sender
{
    if ([self.circlesRead.u_id isEqualToString:kUserId]) {
        
        
        CreatCircleTableViewController *createTopicVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatCircleTableViewController"];
        createTopicVC.type = 2;
        createTopicVC.c_id =self.circlesRead.cId;
        createTopicVC.name = self.circlesRead.title;
        createTopicVC.attribute = self.circlesRead.attributes;
        createTopicVC.product = self.circlesRead.content;
        createTopicVC.againPassword = self.circlesRead.pass;
        [self.navigationController pushViewController:createTopicVC animated:YES];
    }
    else
    {
        [self showToastWithMessage:@"没有权限修改"];
        
    }
}

- (IBAction)mimaBtnClick:(id)sender
{
    if ([self.circlesRead.u_id isEqualToString:kUserId]) {
        
        CreatCircleTableViewController *createTopicVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatCircleTableViewController"];
        
        createTopicVC.type = 2;
        createTopicVC.c_id =self.circlesRead.cId;
        
        createTopicVC.name = self.circlesRead.title;
        createTopicVC.attribute = self.circlesRead.attributes;
        createTopicVC.product = self.circlesRead.content;
        createTopicVC.againPassword = self.circlesRead.pass;
        [self.navigationController pushViewController:createTopicVC animated:YES];
    }
    else
    {
        [self showToastWithMessage:@"没有权限修改"];
        
    }
}
- (IBAction)jianjieBtnClicc:(id)sender
{
    if ([self.circlesRead.u_id isEqualToString:kUserId]) {
        
        CreatCircleTableViewController *createTopicVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatCircleTableViewController"];
        
        createTopicVC.type = 2;
        createTopicVC.c_id =self.circlesRead.cId;
        createTopicVC.name = self.circlesRead.title;
        createTopicVC.attribute = self.circlesRead.attributes;
        createTopicVC.product = self.circlesRead.content;
        createTopicVC.againPassword = self.circlesRead.pass;
        
        [self.navigationController pushViewController:createTopicVC animated:YES];
        
    }
    else
    {
        [self showToastWithMessage:@"没有权限修改"];
        
    }
}
@end
