//
//  JDFSquareCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFSquareCell.h"
#import "JDFSquareItem.h"

@interface JDFSquareCell ()


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end
@implementation JDFSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = 25;
    self.iconView.layer.masksToBounds = YES;
   
}

- (void)setItem:(JDFSquareItem *)item
{

    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil];
    self.nameView.text = item.nike;
}

@end
