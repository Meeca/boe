//
//  SSPhotoViewController.h
//  test
//
//  Created by sskh on 14-9-23.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPhoto.h"
#import "SSImageScrollView.h"

@class SSPhotoBrowser;

@interface SSPhotoViewController : UIViewController
@property (nonatomic, readonly) NSUInteger pageIndex;
@property (nonatomic, readonly) SSImageScrollView *imageScrollView;
@property (nonatomic, strong) id <SSPhoto> photo;

+ (SSPhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex photoBrowser:(SSPhotoBrowser *)photoBrowser;

- (void)resetImageScrollView;

@end
