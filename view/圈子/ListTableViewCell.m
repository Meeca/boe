//
//  ListTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell () {
    UIImageView *imageView;
    UILabel *name;
    UILabel *type;
    UILabel *price;
    UILabel *num;
}

@end

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.contentView.backgroundColor = RGB(244, 244, 244);
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:name];
    
    type = [[UILabel alloc] initWithFrame:CGRectZero];
    type.font = [UIFont systemFontOfSize:13];
    type.textColor = [UIColor grayColor];
    [self.contentView addSubview:type];
    
    price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:price];
    
    num = [[UILabel alloc] initWithFrame:CGRectZero];
    num.font = [UIFont systemFontOfSize:13];
    num.textColor = [UIColor grayColor];
    [self.contentView addSubview:num];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.data isMemberOfClass:[DetailsInfo class]]) {
        
        DetailsInfo *info = self.data;
        
        
         
        [imageView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
        imageView.frame = CGRectMake(15, 15, self.height-30, self.height-30);
        
        name.text = info.title?:@" ";
        [name sizeToFit];
        name.x = imageView.right + 10;
        name.y = imageView.top + 5;
        
        type.text = @"画框购买";
        [type sizeToFit];
        type.x = imageView.right + 10;
        type.top = name.bottom + 5;

        //        price.text = [@"￥" stringByAppendingString:info.material_price.length>0?info.material_price:@"0"];
        
        price.text = [@"￥" stringByAppendingString:_priceNum>0?_priceNum:@"0"];

        
        [price sizeToFit];
        price.right = self.width - 15;
        price.centerY = name.centerY;
        
        num.text = info.material_num.length != 0 ? [NSString stringWithFormat:@"x%@", info.material_num] : @"x1";
        [num sizeToFit];
        num.right = price.right;
        num.centerY = type.centerY;
        
        
        
    } else if ([self.data isMemberOfClass:[OrderInfo class]]) {
        OrderInfo *info = self.data;

        [imageView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
        imageView.frame = CGRectMake(15, 15, self.height-30, self.height-30);
        
        name.text = info.title?:@" ";
        [name sizeToFit];
        name.x = imageView.right + 10;
        name.y = imageView.top + 5;
        
        type.text = @"电子版收藏品";
        if ([info.types integerValue]==1) {
            type.text = @"电子版收藏品";
        } else if ([info.types integerValue]==2) {
            type.text = @"真品购买";
        } else if ([info.types integerValue]==3) {
            type.text = @"打赏";
        }
        [type sizeToFit];
        type.x = imageView.right + 10;
        type.top = name.bottom + 5;
        
        price.text = [@"￥" stringByAppendingString:info.price.length>0?info.price:@"0"];
        [price sizeToFit];
        price.right = self.width - 15;
        price.centerY = name.centerY;
        
        num.text = @"x1";
        [num sizeToFit];
        num.right = price.right;
        num.centerY = type.centerY;
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
