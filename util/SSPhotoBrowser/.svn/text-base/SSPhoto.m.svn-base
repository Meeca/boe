//
//  SSPhoto.m
//  test
//
//  Created by sskh on 14-9-25.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import "SSPhoto.h"
#import "SSPhotoBrowser.h"
#import "SDWebImageManager.h"
#import "SDWebImageOperation.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SSPhoto ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, assign) BOOL loadingInProgress;
@property (nonatomic, strong) id <SDWebImageOperation> webImageOperation;

@end

@implementation SSPhoto
@synthesize underlyingImage = _underlyingImage; // synth property from protocol

#pragma mark - Class Methods

+ (SSPhoto *)photoWithImage:(UIImage *)image {
    return [[SSPhoto alloc] initWithImage:image];
}

+ (SSPhoto *)photoWithURL:(NSURL *)url {
    return [[SSPhoto alloc] initWithURL:url];
}

#pragma mark - Init

- (id)initWithImage:(UIImage *)image {
    if ((self = [super init])) {
        _image = image;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    if ((self = [super init])) {
        _photoURL = [url copy];
    }
    return self;
}

#pragma mark - MWPhoto Protocol Methods

- (UIImage *)underlyingImage {
    return _underlyingImage;
}

- (void)loadUnderlyingImageAndNotify {
    NSAssert([[NSThread currentThread] isMainThread], @"This method must be called on the main thread.");
    if (_loadingInProgress) return;
    _loadingInProgress = YES;
    @try {
        if (self.underlyingImage) {
            [self imageLoadingComplete];
        } else {
            [self performLoadUnderlyingImageAndNotify];
        }
    }
    @catch (NSException *exception) {
        self.underlyingImage = nil;
        _loadingInProgress = NO;
        [self imageLoadingComplete];
    }
    @finally {
    }
}

// Set the underlyingImage
- (void)performLoadUnderlyingImageAndNotify {
    
    // Get underlying image
    if (_image) {
        
        // We have UIImage!
        self.underlyingImage = _image;
        [self imageLoadingComplete];
        
    } else if (_photoURL) {
        
        // Check what type of url it is
        if ([[[_photoURL scheme] lowercaseString] isEqualToString:@"assets-library"]) {
            
            // Load from asset library async
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @autoreleasepool {
                    @try {
                        ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
                        [assetslibrary assetForURL:_photoURL
                                       resultBlock:^(ALAsset *asset){
                                           ALAssetRepresentation *rep = [asset defaultRepresentation];
                                           CGImageRef iref = [rep fullScreenImage];
                                           if (iref) {
                                               self.underlyingImage = [UIImage imageWithCGImage:iref];
                                           }
                                           [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
                                       }
                                      failureBlock:^(NSError *error) {
                                          self.underlyingImage = nil;
                                          NSLog(@"Photo from asset library error: %@",error);
                                          [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
                                      }];
                    } @catch (NSException *e) {
                        NSLog(@"Photo from asset library error: %@", e);
                        [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
                    }
                }
            });
            
        } else if ([_photoURL isFileReferenceURL]) {
            
            // Load from local file async
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                @autoreleasepool {
                    @try {
                        self.underlyingImage = [UIImage imageWithContentsOfFile:_photoURL.path];
                        if (!_underlyingImage) {
                            NSLog(@"Error loading photo from path: %@", _photoURL.path);
                        }
                    } @finally {
                        [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
                    }
                }
            });
            
        } else {
            
            // Load async from web (using SDWebImage)
            @try {
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                _webImageOperation = [manager downloadWithURL:_photoURL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    NSLog(@"receivedSize:%ld, expectedSize:%ld", (long)receivedSize, (long)expectedSize);
                    if (expectedSize > 0) {
                        float progress = receivedSize / (float)expectedSize;
                        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithFloat:progress], @"progress",
                                              self, @"photo", nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:SSPHOTO_PROGRESS_NOTIFICATION object:dict];
                    }
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
                    if (error) {
                        NSLog(@"SDWebImage failed to download image: %@", error);
                    }
                    _webImageOperation = nil;
                    self.underlyingImage = image;
                    [self imageLoadingComplete];
                }];
//                _webImageOperation = [manager downloadImageWithURL:_photoURL
//                                                           options:SDWebImageRetryFailed
//                                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
////                                                              NSLog(@"receivedSize:%d, expectedSize:%d", receivedSize, expectedSize);
//                                                              if (expectedSize > 0) {
//                                                                  float progress = receivedSize / (float)expectedSize;
//                                                                  NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                                                        [NSNumber numberWithFloat:progress], @"progress",
//                                                                                        self, @"photo", nil];
//                                                                  [[NSNotificationCenter defaultCenter] postNotificationName:SSPHOTO_PROGRESS_NOTIFICATION object:dict];
//                                                              }
//                                                          }
//                                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                                             if (error) {
//                                                                 NSLog(@"SDWebImage failed to download image: %@", error);
//                                                             }
//                                                             _webImageOperation = nil;
//                                                             self.underlyingImage = image;
//                                                             [self imageLoadingComplete];
//                                                         }];
                
            } @catch (NSException *e) {
                NSLog(@"Photo from web: %@", e);
                _webImageOperation = nil;
                [self imageLoadingComplete];
            }
            
        }
        
    } else {
        
        // Failed - no source
        @throw [NSException exceptionWithName:nil reason:nil userInfo:nil];
        
    }
}

// Release if we can get it again from path or url
- (void)unloadUnderlyingImage {
    _loadingInProgress = NO;
    self.underlyingImage = nil;
}

- (void)imageLoadingComplete {
    NSAssert([[NSThread currentThread] isMainThread], @"This method must be called on the main thread.");
    // Complete so notify
    _loadingInProgress = NO;
    // Notify on next run loop
    [self performSelector:@selector(postCompleteNotification) withObject:nil afterDelay:0];
}

- (void)postCompleteNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SSPHOTO_LOADING_DID_END_NOTIFICATION object:self];
}

- (void)cancelAnyLoading {
    if (_webImageOperation) {
        [_webImageOperation cancel];
        _loadingInProgress = NO;
    }
}


@end
