//
//  ZTViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ZTViewCell.h"

@interface ZTViewCell () {
    UIImageView *imgView;
    UIImageView *tras;
    UILabel *name;
    UIImageView *eye;
    UILabel *eyeNum;
    
    UILabel *context;
}

@end

@implementation ZTViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    
    tras = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"B-16-2"];
    [image stretchableImageWithLeftCapWidth:4 topCapHeight:2];
    tras.image = image;
    [self.contentView addSubview:tras];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont boldSystemFontOfSize:18];
    [tras addSubview:name];
    
    eye = [[UIImageView alloc] initWithFrame:CGRectZero];
    eye.image = [UIImage imageNamed:@"GALLERY icon  20160620-17"];
    eye.contentMode = UIViewContentModeScaleAspectFit;
    [tras addSubview:eye];
    
    eyeNum = [[UILabel alloc] initWithFrame:CGRectZero];
    eyeNum.textColor = [[UIColor whiteColor] colorWithAlphaComponent:.5];
    eyeNum.font = [UIFont systemFontOfSize:14];
    [tras addSubview:eyeNum];
    
    context = [[UILabel alloc] initWithFrame:CGRectZero];
    context.textColor = [UIColor grayColor];
    context.numberOfLines = 2;
    context.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:context];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    SpecialInfo *info = self.data;
    [imgView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    imgView.frame = CGRectMake(0, 0, self.width, self.height-55);
    
    tras.frame = CGRectMake(0, 0, self.width, 44);
    tras.bottom = imgView.bottom;
    
    name.text = info.title.length>0?info.title:@"未知";
    name.frame = CGRectMake(15, 0, self.width-30, 44);

    eyeNum.text = info.read_num.length>0?info.read_num:@"0";
    [eyeNum sizeToFit];
    eyeNum.right = self.width-20;
    eyeNum.centerY = tras.height/2;
    
    eye.frame = CGRectMake(0, 0, 25, 25);
    eye.right = eyeNum.left-5;
    eye.centerY = tras.height/2;
    
    context.text = info.content.length>0?info.content:@"暂无内容";
    context.frame = CGRectMake(15, imgView.bottom, self.width-30, 55);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:context.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    context.attributedText = text;
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
