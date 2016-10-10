//
//  JDFSquareCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFSquareCell.h"

@interface JDFSquareCell ()


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end
@implementation JDFSquareCell


- (void)setJDFSquareItem:(JDFSquareItem *)jDFSquareItem{

    _jDFSquareItem = jDFSquareItem;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:jDFSquareItem.image] placeholderImage:nil];
    self.nameView.text = jDFSquareItem.nike;
 }


- (void)awakeFromNib {
    // Initialization code
       [super awakeFromNib];
    self.iconView.layer.cornerRadius = 25;
    self.iconView.layer.masksToBounds = YES;
    
    [self updateCheckImage];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.jDFSquareItem = nil;
    self.disabled = NO;
    
    [self updateCheckImage];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self updateCheckImage];
}

- (void)setIsShow:(BOOL)isShow{

    _chooseSquareBtn.hidden = !isShow;


}

- (void)setDisabled:(BOOL)disabled {
    if (_disabled == disabled) {
        return;
    }
    _disabled = disabled;
    
}

- (void)updateCheckImage {
    self.chooseSquareBtn.selected = self.selected;
}



@end
