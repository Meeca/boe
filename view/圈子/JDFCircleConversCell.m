//
//  JDFCircleConversCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFCircleConversCell.h"
#import "Convers.h"
#import "SDCycleScrollView.h"

@interface JDFCircleConversCell ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conversImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conversImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *articleReviewsLabel;//评论条数
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation JDFCircleConversCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius =22;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.conversImageView layoutIfNeeded];
    CGRect frame = self.conversImageView.bounds;
    self.cycleScrollView.frame = frame;
}

-(void)setConvers:(Convers *)convers
{
    _convers = convers;
    
    [self.cycleScrollView removeFromSuperview];
    self.cycleScrollView = nil;
    
    self.usernameLabel.text = convers.name;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:convers.createdAT];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM-dd HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:convers.uImage] placeholderImage:nil];
    self.contentLabel.text = convers.title;
    self.articleReviewsLabel.text = [NSString stringWithFormat:@"%ld",(long)convers.commsNum];
    NSArray *images = [convers.image componentsSeparatedByString:@"-"];
    
    
    
    if (convers.image.length > 0)
    {
        self.conversImageView.hidden = NO;
        [_conversImageView sd_setImageWithURL:[NSURL URLWithString:convers.image] placeholderImage:nil];
        self.conversImageViewHeightConstraint.constant = 181;
    }
    else
    {
        self.conversImageView.hidden = YES;
        self.conversImageViewHeightConstraint.constant = 0;
    }
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.conversImageView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"def_banner"]];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    cycleScrollView.imageURLStringsGroup = images;
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
    cycleScrollView.autoScrollTimeInterval = 3;
    
    cycleScrollView.infiniteLoop = images.count > 1;
    
    cycleScrollView.currentPageDotColor = [UIColor lightGrayColor];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    
    [self.conversImageView addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}

@end
