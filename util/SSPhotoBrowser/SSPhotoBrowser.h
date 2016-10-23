//
//  SSPhotoBrowser.h
//  test
//
//  Created by sskh on 14-9-23.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPhoto.h"

@class SSPhotoBrowser;

@protocol SSPhotoBrowserDelegate <NSObject>

- (id<SSPhoto>)ss_photoBrowser:(SSPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;

@optional
//这个方法可选，如果没有实现，就必须设置属性 numberOfPhotos
- (NSUInteger)ss_numberOfPhotosInPhotoBrowser:(SSPhotoBrowser *)photoBrowser;

//如果某些photo不想返回特定的CGRect，则返回CGRectNull
- (CGRect)ss_photoBrowser:(SSPhotoBrowser *)photoBrowser photoRectAtIndex:(NSUInteger)index;

@end


@interface SSPhotoBrowser : UIViewController
@property (nonatomic, weak) id <SSPhotoBrowserDelegate> delegate;
@property (nonatomic, assign) NSUInteger numberOfPhotos;//总的图片数

- (id)initWithDelegate:(id <SSPhotoBrowserDelegate>)delegate;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;

//开始展示图片
- (void)showInViewController:(UIViewController *)viewController;
- (void)dismissSSPhotoBrowserWithIndex:(NSNumber *)indexNumber;


- (UIImage *)imageForPhoto:(id<SSPhoto>)photo;


@end













