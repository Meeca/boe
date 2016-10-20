//
//  SystemDetaileViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "SystemDetaileViewController.h"

@interface SystemDetaileViewController (){

    NSInteger  _type;

}
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation SystemDetaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"系统消息";
        
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithImage:@"C-13-3" highImage:@"C-13-3" target:self action:@selector(deleteItemAction)];

    /*
     
     系统消息详情
     
     get:/app.php/User/news_read
     n_id#消息id
     

     
     */
    
    
    
    
    [MCNetTool postWithUrl:@"/app.php/User/news_read" params:@{@"n_id":_n_id} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        NSString * time =requestDic[@"created_at"];
        
//        timestampToString
        _timeLab.text = [Tool timestampToString:time Format:@"yyyy-MM-dd HH:mm"];
        _contentLab.text = requestDic[@"title"];
        _type = [requestDic[@"types"] integerValue];
        
        if (_type == 2) {
            NSString * image = checkNULL(requestDic[@"image"]) ;
        
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
        }
            
        
    } fail:^(NSString *error) {
        
    }];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)deleteItemAction{

    
//            删除系统消息
//            
//        get:/app.php/User/news_del
//            uid#用户id
//            n_id#消息id
//            types#消息类型（3系统消息，2订单消息）


    
    [MCNetTool postWithUrl:@"/app.php/User/news_del" params:@{@"uid":kUserId,@"n_id":_n_id,@"types":@(_type)} hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        [self showToastWithMessage:msg];

        if (_systemDBlock) {
            _systemDBlock();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
