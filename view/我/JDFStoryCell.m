//
//  JDFStoryCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFStoryCell.h"
#import "JDFStory.h"

@interface JDFStoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;

@property (weak, nonatomic) IBOutlet UILabel *storyUserNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *storyContentLabel;

@end

@implementation JDFStoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    [self.contentView addGestureRecognizer:tap];
    
}

- (void)tap {
    if (self.tapAction) {
        self.tapAction(_story);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStory:(JDFStory *)story
{
    _story = story;
    
    [self.storyImageView sd_setImageWithURL:[NSURL URLWithString:story.image]];
    self.storyUserNameLabel.text = story.title;
    self.storyContentLabel.text = story.content;
}

@end
