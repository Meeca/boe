//
//  PushTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/10.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PushTableViewCell.h"

@interface PushTableViewCell () {
    UILabel *name;
    UIImageView *selImg;
    UILabel *line;
}

@end

@implementation PushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    self.backgroundColor = [UIColor lightGrayColor];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = [UIColor blackColor];
    name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:name];
    
    selImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    selImg.contentMode = UIViewContentModeScaleAspectFit;
    selImg.clipsToBounds = YES;
    [self.contentView addSubview:selImg];
    
    line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    line.width = self.width;
    
    EquipmentList *list = self.data;
    name.text = list.title.length>0?list.title:@"";
    [name sizeToFit];
    name.x = 20;
    name.centerY = self.height/2;
    
    selImg.frame = CGRectMake(0, 0, self.height, self.height);
    selImg.right = self.width - 5;
    if (self.iSsel) {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-12"];
    } else {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-13"];
    }
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
