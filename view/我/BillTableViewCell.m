//
//  BillTableViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BillTableViewCell.h"

@interface BillTableViewCell () {
    UILabel *time;
    UIImageView *imageView;
    UILabel *name;
    UILabel *type;
    UILabel *price;
    NSString *c;
}

@end

@implementation BillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    time = [[UILabel alloc] initWithFrame:CGRectZero];
    time.numberOfLines = 2;
    time.font = [UIFont systemFontOfSize:13];
    time.textColor = [UIColor grayColor];
    [self.contentView addSubview:time];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:name];
    
    type = [[UILabel alloc] initWithFrame:CGRectZero];
    type.font = [UIFont systemFontOfSize:14];
    type.textColor = [UIColor grayColor];
    [self.contentView addSubview:type];
    
    price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:price];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CapitalFlow *info = self.data;
    
    time.text = [Tool timestampToString:info.created_at Format:@"MM-dd\nHH:mm"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:time.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    time.attributedText = str;
    [time sizeToFit];
    time.x = 10;
    time.centerY = self.height/2;
    
    if ([info.type integerValue]==1) { //收
        imageView.image = [UIImage imageNamed:@"切图 20160719-7"];
        price.textColor = KAPPCOLOR;
        c = @"+";
    } else if ([info.type integerValue]==2) {  //支
        imageView.image = [UIImage imageNamed:@"切图 20160719-8"];
        price.textColor = [UIColor blackColor];
        c = @"-";
    }
    imageView.frame = CGRectMake(time.right+20, 8, self.height-16, self.height-16);
    
    name.text = info.title.length>0?info.title:@" ";
    [name sizeToFit];
//    name.width = 
    if ([info.types integerValue]==1) {  //购买类型（1购买收藏，2真品购买，3打赏）
        type.text = @"电子收藏";
    } else if ([info.types integerValue]==2) {
        type.text = @"真品购买";
    } else if ([info.types integerValue]==3) {
        type.text = @"打赏";
    }
    [type sizeToFit];
    
    name.x = imageView.right+5;
    name.y = (self.height-name.height-type.height-8)/2;
    
    type.x = name.x;
    type.top = name.bottom+8;
    
    price.text = [c stringByAppendingString:[NSString stringWithFormat:@"%.2f", [info.price.length>0?info.price:@"0" floatValue]]];
    [price sizeToFit];
    
    price.right = self.width-15;
    price.centerY = self.height/2;
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
