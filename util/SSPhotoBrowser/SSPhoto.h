//
//  SSPhoto.h
//  test
//
//  Created by sskh on 14-9-25.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSPhotoProtocol.h"

@interface SSPhoto : NSObject<SSPhoto>
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL *photoURL;

+ (SSPhoto *)photoWithImage:(UIImage *)image;
+ (SSPhoto *)photoWithURL:(NSURL *)url;

- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;

@end
