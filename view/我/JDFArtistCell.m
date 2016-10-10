//
//  JDFArtistCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFArtistCell.h"
#import "JDFArtist.h"

@interface JDFArtistCell ()
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UILabel *artistUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistContentLabel;

@end

@implementation JDFArtistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArtist:(JDFArtist *)artist
{
    _artist = artist;
    
    [self.artistImageView sd_setImageWithURL:[NSURL URLWithString:artist.image]];
    self.artistUserNameLabel.text = artist.nike;
    self.artistContentLabel.text = artist.content;
}

@end
