//
//  TLPhotoMessageCell.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "TLPhotoMessageCell.h"
#import <UIImageView+WebCache.h>
#import "TLPhotoBrowser.h"

static  CGFloat fitImgWidth  = 150;
static  CGFloat fitImgHeight = 150;


@interface TLPhotoMessageCell ()
@property(nonatomic,strong)UIImageView *photoImageView;
@end

@implementation TLPhotoMessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bubbleImageView addSubview:self.photoImageView];
        [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bubbleImageView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage)];
        [self.photoImageView addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)didClickImage{
    
     NSString * imageUrl =  self.message.title;
    
 
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [TLPhotoBrowser showOriginalImage:image];
    }];
 }

-(void)updateMessage:(MessageModel *)message showDate:(BOOL)showDate{
    [super updateMessage:message showDate:showDate];
    
    
    NSString * imageUrl =  self.message.title;

    
    
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        
//        CGSize imgSize = self.photoImageView.image.size;
//        CGFloat scale = imgSize.width / imgSize.height;
//        
//        CGFloat newWidth  = MAX(MIN(imgSize.width, fitImgWidth), fitImgWidth);
//        CGFloat newHeight = MAX(MIN(imgSize.height, fitImgHeight), fitImgHeight);
//        
////        CGSize newSize = scale > 1 ? CGSizeMake(newWidth, newWidth / scale) : CGSizeMake(newHeight * scale, newHeight);
        
        
        CGSize newSize = CGSizeMake(150, 150);

        UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:self.bubbleImageView.image];
        imageViewMask.frame = CGRectMake(0, 0, newSize.width, newSize.height);
 
        
        self.photoImageView.layer.mask = imageViewMask.layer;
        
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(newSize).priorityHigh(1);
        }];
        
        
     }];
    

}
-(UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.userInteractionEnabled = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_photoImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _photoImageView;
}
@end