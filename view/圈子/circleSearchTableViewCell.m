//
//  circleSearchTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "circleSearchTableViewCell.h"


@interface circleSearchTableViewCell ()

@end
@implementation circleSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [super awakeFromNib];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCircleSearchModel:(CircleSearch *)circleSearchModel
{

    _circleSearchModel = circleSearchModel;
//    [self.iconImageView.image ]
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:circleSearchModel.image] placeholderImage:nil];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld人",(long)circleSearchModel.people_num];
//    self.lockImageView.hidden = circleSearchModel.attributes == 1;
    if (circleSearchModel.attributes == 1) {
        self.lockImageView.hidden = YES;
    }
    else if (circleSearchModel.attributes == 2)
    {
    
        self.lockImageView.hidden = NO;
    }
    self.titleLabel.text = circleSearchModel.title;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.titleLabel.right>self.width) {
        self.titleLabel.width = self.width-self.titleLabel.left-25;
    }
}

@end
