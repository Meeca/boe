//
//  UIImage+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+MJ.h"
#import "SDWebImageManager.h"

@implementation UIImage (MJ)

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (void)loadImageWithUrl:(NSString *)imageUrl returnImage:(void (^)(UIImage * image))returnImage{
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //处理下载进度
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            NSLog(@"error is %@",error);
        }
        if (image) {
            //图片下载完成  在这里进行相关操作，如加到数组里 或者显示在imageView上
             returnImage(image);
         }
     }];
}


@end
