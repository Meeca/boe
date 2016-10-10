//
//  HuoTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/8.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "HuoTableViewCell.h"

@interface HuoTableViewCell () {
    UIImageView *imageView;
    UIView *trans;
    UILabel *title;
    UILabel *context;
}

@end

@implementation HuoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    trans = [[UIView alloc] initWithFrame:CGRectZero];
    trans.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
    [self.contentView addSubview:trans];
    
    title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:20];
    [self.contentView addSubview:title];
    
    context = [[UILabel alloc] initWithFrame:CGRectZero];
    context.textColor = [UIColor whiteColor];
    context.font = [UIFont systemFontOfSize:14];
    context.numberOfLines = 0;
    [self.contentView addSubview:context];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    SpecialInfo *info = self.data;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    imageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    trans.frame = CGRectMake(0, 0, self.width, self.height);
    
    title.text = info.title.length>0?info.title:@"未知标题";
    [title sizeToFit];
    
    context.text = info.content.length>0?info.content:@"暂无内容";
    context.frame = CGRectMake(25, 0, self.width-50, self.height/3);
    context.centerY = self.height/2+30;
    
    title.center = CGPointMake(self.width/2, self.height/2);
    title.bottom = context.top-10;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
