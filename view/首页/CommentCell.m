//
//  CommentCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell () {
    UIImageView *imageView;
    UILabel *name;
    UILabel *time;
    UILabel *content;
    
    UILabel *line;
}

@end

@implementation CommentCell

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
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = KAPPCOLOR;
    name.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:name];
    
    time = [[UILabel alloc] initWithFrame:CGRectZero];
    time.textColor = [UIColor grayColor];
    time.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:time];
    
    content = [[UILabel alloc] initWithFrame:CGRectZero];
    content.font = [UIFont systemFontOfSize:15];
    content.numberOfLines = 0;
    [self.contentView addSubview:content];
    
    line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CommentInfo *comment = self.data;
    
    imageView.frame = CGRectMake(15, 15, 35, 35);
    imageView.layer.cornerRadius = imageView.width/2;
    [imageView sd_setImageWithURL:[NSURL URLWithString:comment.image] placeholderImage:KZHANWEI];
    
    name.text = comment.nike.length>0?comment.nike:@"无昵称";
    [name sizeToFit];
    
    name.x = imageView.right+10;
    name.y = imageView.y;
    
    content.frame = CGRectMake(name.x, name.bottom+15, self.width-name.x-15, 100);
    content.text = comment.content.length>0?comment.content:@" ";
    content.height = [Tool getLabelSizeWithText:content.text AndWidth:content.width AndFont:content.font attribute:nil].height;
    NSLog(@"\n\n  content.x  %@    content.y   %@  \n\n", @(content.x), @(content.y));
    
    line.frame = CGRectMake(content.x, content.y, content.width, .5);
    line.bottom = self.height;
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    if (self.iconAction) {
        CommentInfo *comment = self.data;
        self.iconAction(comment);
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
