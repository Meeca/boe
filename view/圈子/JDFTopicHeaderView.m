//
//  JDFTopicHeaderView.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFTopicHeaderView.h"
#import "CircleCommentTableViewController.h"
#import "SDCycleScrollView.h"
#import "SSPhotoBrowser.h"
#import "AppDelegate.h"
#import "AgainCommentViewController.h"

@interface JDFTopicHeaderView ()<SDCycleScrollViewDelegate, SSPhotoBrowserDelegate> {
    NSArray *imageArr;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conversImageView;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UILabel *morePeoplePraiseLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation JDFTopicHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 22;
    self.iconImageView.layer.masksToBounds = YES;
//    self.conversImageView.backgroundColor = [UIColor whiteColor];
//    _conversImageView.contentMode = UIViewContentModeScaleAspectFill;
 
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.conversImageView layoutIfNeeded];
    CGRect frame = self.conversImageView.bounds;
    self.cycleScrollView.frame = frame;
}



//"co_id": "1",                    //话题id
//"u_id": "52",
//"name": "123456",
//"u_image": "http://boe.ccifc.cn/assets/upload/userimages/280da45aee72e93079f9a543a972bd01.jpg",
//"title": "zuopin",              //话题名称
//"image": "dfsf1ds5f1s51.jpg",   //话题图地址
//"content": "梵高",               //话题简介
//"c_zam_num": "2",               //话题赞数量
//"c_zam_type": "2",               //是否已赞（1未赞，2已赞）
//"gag_it": "2",               //是否禁言（1是，2否）
//"created_at": "14856325896",              //发布时间

- (void)setCtcrModel:(CircleTopicConverseRead *)ctcrModel{
    _ctcrModel = ctcrModel;
    [self.cycleScrollView removeFromSuperview];
    self.cycleScrollView = nil;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:ctcrModel.u_image] placeholderImage:nil];
    self.nameLabel.text = ctcrModel.name;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:ctcrModel.created_at];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    self.contentLabel.text = ctcrModel.title;
    self.morePeoplePraiseLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",ctcrModel.c_zam_num];
//    self.praiseButton.selected = ctcrModel.c_zam_type == 2;
    if (ctcrModel.c_zam_type == 2) {
        self.praiseButton.selected = YES;
    }
    else
    {
        self.praiseButton.selected = NO;
    }
    NSArray *images = [ctcrModel.image componentsSeparatedByString:@"-"];
    imageArr = images;
    if (ctcrModel.image.length > 0)
    {
        self.conversImageView.hidden = NO;
        [_conversImageView sd_setImageWithURL:[NSURL URLWithString:ctcrModel.image] placeholderImage:nil];
        self.conversImageViewHeightConstraint.constant = 181;
    }
    else
    {
        self.conversImageView.hidden = YES;
        self.conversImageViewHeightConstraint.constant = 0;
    }
    if (_ctcrModel.gag_it.integerValue == 1) {
        self.commentBtn.hidden = YES;
    }
    else
    {
        
        self.commentBtn.hidden = NO;
    }
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.conversImageView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"def_banner"]];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    cycleScrollView.imageURLStringsGroup = images;
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
    cycleScrollView.autoScrollTimeInterval = 3;
    
    cycleScrollView.infiniteLoop = images.count > 1;
    
    cycleScrollView.currentPageDotColor = KAPPCOLOR;
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    
    [self.conversImageView addSubview:cycleScrollView];
    self.conversImageView.userInteractionEnabled = YES;
    self.cycleScrollView = cycleScrollView;

    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BaseTabBarController *ctrl = ((AppDelegate *)[UIApplication sharedApplication].delegate).ctrl;
    NSLog(@"%ld",(long)index);
    SSPhotoBrowser *ss = [[SSPhotoBrowser alloc] initWithDelegate:self];
    ss.numberOfPhotos = imageArr.count;
    [ss setCurrentPhotoIndex:index];
    [ss showInViewController:ctrl.selectedViewController];
}

#pragma mark - SSPhotoBrowserDelegate
- (id<SSPhoto>)ss_photoBrowser:(SSPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    NSLog(@"%d",(int)index);
    return [SSPhoto photoWithURL:[NSURL URLWithString:imageArr[index]]];
}


//点赞按钮
#pragma mark ------- 点赞请求接口

- (IBAction)praiseButtonClick:(UIButton *)sender
{
    
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected)
    {
        _ctcrModel.c_zam_num = [NSString stringWithFormat:@"%ld", _ctcrModel.c_zam_num.integerValue + 1 ];
        _morePeoplePraiseLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",_ctcrModel.c_zam_num];
        NSString *path = @"/app.php/Circles/zan_add";
        NSDictionary *params = @{
                                 @"co_id":_ctcrModel.co_id,
                                 @"u_id":kUserId,
                                 
                                 };
        [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
         {
             
             
             
         } fail:^(NSString *error) {
             
         }];
    }
    else
    {
        _ctcrModel.c_zam_num = [NSString stringWithFormat:@"%ld", _ctcrModel.c_zam_num.integerValue - 1 ];
        _morePeoplePraiseLabel.text = [NSString stringWithFormat:@"%@人觉得很赞",_ctcrModel.c_zam_num];
        NSString *path = @"/app.php/Circles/zan_del";
        NSDictionary *params = @{
                                 @"co_id":_ctcrModel.co_id,
                                 @"u_id":kUserId,
                                 
                                 };
        [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
         {
             
             
             
         } fail:^(NSString *error) {
             
         }];
    }
    
}
//评论按钮点击
- (IBAction)comments:(id)sender
{
 
    NSLog(@"你点击了评论按钮");
    
    AgainCommentViewController * vc = [[AgainCommentViewController alloc]initWithNibName:@"AgainCommentViewController" bundle:nil];
     vc.coId = _ctcrModel.co_id;
    [[self viewController1].navigationController pushViewController:vc animated:YES];

    
//    
//    CircleCommentTableViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleCommentTableViewController"];
//    conversVC.coId = _ctcrModel.co_id;
//    
//    [[self viewController1].navigationController pushViewController:conversVC animated:YES];
    
}

- (UIViewController *)viewController1{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
    
}

- (void)setIsHideComent:(BOOL)isHideComent {
    _isHideComent = isHideComent;
    
    _commentBtn.hidden = _isHideComent;
}

@end
