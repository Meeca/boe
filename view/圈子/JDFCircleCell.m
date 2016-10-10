//
//  JDFCircleCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/21.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFCircleCell.h"
#import "JDFCircleModel.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

@interface JDFCircleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;
@property (weak, nonatomic) IBOutlet UILabel *circleTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lockImageView;

@property (weak, nonatomic) IBOutlet UILabel *circleContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *circleConversNumLabel;
@end

@implementation JDFCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.circleTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    self.circleTitleLabel.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(16)];
    self.circleContentLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(14)];
    self.circleConversNumLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCircle:(JDFCircleModel *)circle
{
    _circle = circle;
    
    NSString *title = circle.title.length > 10 ? [[circle.title substringToIndex:10] stringByAppendingString:@"..."] : circle.title;
    self.circleTitleLabel.text = title;
    self.circleContentLabel.text = circle.content;
    self.circleConversNumLabel.text = [NSString stringWithFormat:@"%ld个新话题", (long)circle.conversNum];
    [self.circleImageView sd_setImageWithURL:[NSURL URLWithString:circle.image] placeholderImage:nil];
    self.lockImageView.hidden = circle.attributes == 1;
    
    
}


@end
