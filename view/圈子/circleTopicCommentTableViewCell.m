//
//  circleTopicCommentTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/29.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "circleTopicCommentTableViewCell.h"
#import "circleTopicConverseRead.h"
#import "ViewAllContentViewController.h"

#import "DBHTopicModelCommsList.h"
#import "AvatarBrowser.h"


@interface circleTopicCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
 
@end
@implementation circleTopicCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 22;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(DBHTopicModelCommsList *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.uImage] placeholderImage:nil];
    self.nameLabel.text = _model.uName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_model.createdAt.integerValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.dateFormat = @"HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    if (_model.zamNum.length == 0) {
        self.zanCountLabel.text = @"0";
    }
    else{
        
        self.zanCountLabel.text  = _model.zamNum;
    }
    
    //    self.heartButton.selected = _commsList.zam_type == 2;
    if ([_model.zamType isEqual:@2]) {
        self.heartButton.selected = YES;
    }
    else
    {
        self.heartButton.selected = NO;
    }
    
//    if (self.contentLabel.text.length < 40) {
//        
//        self.viewBtn.hidden = YES;
//    }
//    else
//    {
//        _contentLabel.numberOfLines=3;
//        self.viewBtn.hidden = NO;
//    }
    
    
    self.contentLabel.text = _model.title;
_contentLabel.numberOfLines=0;
    
    self.viewBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (model.image.length != 0) {

        [_viewBtn sd_setImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal placeholderImage:nil];
        
        
        _viewBtn.hidden = NO;
        

    }else{
        _viewBtn.hidden = YES;
     }

    
    
    
    
}

//"comm_id": "1",                 //评论id
//"title": "zuopin",              //评论内容
//"u_id": "1",                    //评论者id
//"u_name": "梵高",               //评论者昵称
//"u_image": "梵高",              //评论者头像
//"created_at": "14856325896",    //评论时间
//"zam_num": "2",               //评论赞数量
//"zam_type": "2",               //是否已赞（1未赞，2已赞）
- (void)setCommsList:(Comms_List *)commsList
{
    _commsList = commsList;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:commsList.u_image] placeholderImage:nil];
    self.nameLabel.text = commsList.u_name;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:commsList.created_at];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.dateFormat = @"HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    if (commsList.zam_num.length == 0) {
        self.zanCountLabel.text = @"0";
    }
    else{
        
        self.zanCountLabel.text  = commsList.zam_num;
    }
    self.contentLabel.text = commsList.title;

//    self.heartButton.selected = _commsList.zam_type == 2;
    
    
    if (_commsList.zam_type == 2) {
        self.heartButton.selected = YES;
    }
    else
    {
        self.heartButton.selected = NO;
    }
    if (self.contentLabel.text.length < 40) {
        
        self.viewBtn.hidden = YES;
    }
    else
    {
        _contentLabel.numberOfLines=3;
        self.viewBtn.hidden = NO;
    }
}
- (IBAction)zanCountBtnClick:(UIButton *)sender
{
//    if (sender.isSelected) {
//        return;
//    }
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
       
       NSLog(@"点赞之前-----%@",_model.zamNum);
        _model.zamNum = [NSString stringWithFormat:@"%ld",_model.zamNum.integerValue +1];
        NSLog(@"点赞之后-----%@",_model.zamNum);
        
        _zanCountLabel.text = [NSString stringWithFormat:@"%@",_model.zamNum];
        NSString *path = @"/app.php/Circles/zan_comm_add";
        NSDictionary *params = @{
                                 //                             @"comm_id" : _commsList.comm_id,
                                 @"comm_id" : _model.commId,
                                 @"u_id" :kUserId,
                                 
                                 };
        
        [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
         {
             
         } fail:^(NSString *error)
         {
             
         }];
    }
    else{
        _model.zamNum = [NSString stringWithFormat:@"%ld",_model.zamNum.integerValue -1];
        
        _zanCountLabel.text = [NSString stringWithFormat:@"%@",_model.zamNum];
        NSString *path = @"/app.php/Circles/zan_comm_del";
        NSDictionary *params = @{
                                 //                             @"comm_id" : _commsList.comm_id,
                                 @"comm_id" : _model.commId,
                                 @"u_id" :kUserId,
                                 
                                 };
        
        [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
         {
             
         } fail:^(NSString *error)
         {
             
         }];
    }
}
- (IBAction)viewAllArticleAction:(UIButton *)sender {
    
    NSLog(@"你点击了查看全文按钮");
    
    if(_isShow){
    
        AvatarBrowser *browser = [[AvatarBrowser alloc] initWithImage:_viewBtn.imageView.image view:_viewBtn];
        
        [browser show];

    }else{
    
    
        
        
        //    ViewAllContentViewController *circleConversDetailVC = [[UIStoryboard storyboardWithName:@"ViewContent" bundle:nil]instantiateViewControllerWithIdentifier:@"ViewAllContentViewController"];
        //
        //    [self pushViewController:circleConversDetailVC animated:YES];
        ViewAllContentViewController *circleSearchVC = [[UIStoryboard storyboardWithName:@"ViewContent" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewAllContentViewController"];
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:circleSearchVC];
        circleSearchVC.content = _contentLabel.text;
        [naviVC setNavigationBarHidden:NO animated:YES];
        
        [[self getCurrentViewController] presentViewController:naviVC animated:YES completion:^{
            
        }];
        

    
    }
    
    

    
    
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
