//
//  FindCollectionViewCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/1.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FindCollectionViewCell.h"

@interface FindCollectionViewCell () {
    UIImageView *imgView;
    UILabel *numberLaber;
}

@end

@implementation FindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
//        if (_isShow) {
            numberLaber = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-20, 100 , 20)];
            numberLaber.textColor = [UIColor whiteColor];
//        numberLaber.font = [UIFont fontWithName:@"" size:10];
        numberLaber.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:8];
            numberLaber.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.7];
            numberLaber.textAlignment = UITextAlignmentCenter;
            [imgView addSubview:numberLaber];
        numberLaber.hidden = YES;
//        }
      
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    imgView.image = nil;
    imgView.frame = CGRectMake(0, 0, self.width, self.height);
    
    if (_isShow) {
        if (self.index.section == 0) {
            numberLaber.text = [NSString stringWithFormat:@"%@人收藏",_shoucang.length>0?_shoucang:@"0"];
        } else if (self.index.section == 1) {
            numberLaber.text = [NSString stringWithFormat:@"%@人点赞",_goumai.length>0?_goumai:@"0"];
        } else if (self.index.section == 2) {
            numberLaber.text = [NSString stringWithFormat:@"%@人推送",_guanzhu.length>0?_guanzhu:@"0"];
        }
        
        
        
        numberLaber.hidden = NO;
    }
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:KZHANWEI];
}

@end
