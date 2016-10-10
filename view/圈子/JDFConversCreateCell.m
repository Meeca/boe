//
//  JDFConversCreateCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/26.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "JDFConversCreateCell.h"

@interface JDFConversCreateCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end


@implementation JDFConversCreateCell

-(void)setPhotoImage:(UIImage *)photoImage
{
    _photoImage = photoImage;
    
    self.photoImageView.image = photoImage;
    _photoImageView.contentMode= UIViewContentModeScaleAspectFill;
    _photoImageView.clipsToBounds = YES;
}

@end
