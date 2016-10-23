/*
 File: ImageScrollView.m
 Abstract: Centers image within the scroll view and configures image sizing and display.
 Version: 1.3
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "SSImageScrollView.h"
#import "SSPhotoBrowser.h"
#import "DACircularProgressView.h"
#import "MWTapDetectingView.h"


@interface SSImageScrollView ()<UIScrollViewDelegate, MWTapDetectingViewDelegate, MWTapDetectingImageViewDelegate>
@property (nonatomic, weak) SSPhotoBrowser *photoBrowser;
@property (nonatomic, strong) MWTapDetectingView *tapView;
@property (nonatomic, strong) MWTapDetectingImageView *zoomView;
@property (nonatomic, strong) DACircularProgressView *loadingIndicator;
@property (nonatomic, strong) UIImageView *loadingError;

@property (nonatomic, assign) CGPoint pointToCenterAfterResize;
@property (nonatomic, assign) CGFloat scaleToRestoreAfterResize;


@end

@implementation SSImageScrollView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithPhotoBrowser:(SSPhotoBrowser *)browser
{
    if (self = [super init]) {
        
        _index = NSUIntegerMax;
        _photoBrowser = browser;
        
        // Tap view for background
        _tapView = [[MWTapDetectingView alloc] initWithFrame:self.bounds];
        _tapView.tapDelegate = self;
        _tapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tapView.backgroundColor = [UIColor blackColor];
        [self addSubview:_tapView];
        
        // Image view
        _zoomView = [[MWTapDetectingImageView alloc] initWithFrame:CGRectZero];
        _zoomView.tapDelegate = self;
        //貌似这名很关键的样子!!!
        _zoomView.contentMode = UIViewContentModeCenter;
        _zoomView.backgroundColor = [UIColor blackColor];
        [self addSubview:_zoomView];
        
        // Loading indicator
        _loadingIndicator = [[DACircularProgressView alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20.f, 30.0f, 40.0f, 40.0f)];
        _loadingIndicator.userInteractionEnabled = NO;
        //    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        //        _loadingIndicator.thicknessRatio = 0.1;
        //        _loadingIndicator.roundedCorners = NO;
        //    } else {
        //        _loadingIndicator.thicknessRatio = 0.2;
        //        _loadingIndicator.roundedCorners = YES;
        //    }
        _loadingIndicator.thicknessRatio = 0.1;
        _loadingIndicator.roundedCorners = NO;
        
        _loadingIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_loadingIndicator];
        
         //Listen progress notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(setProgressFromNotification:)
                                                         name:SSPHOTO_PROGRESS_NOTIFICATION
                                                       object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSSPhotoLoadingDidEndNotification:) name:SSPHOTO_LOADING_DID_END_NOTIFICATION object:nil];
        
        // Setup
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.bouncesZoom = YES;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

//- (void)prepareForReuse {
//    [self hideImageFailure];
//    self.photo = nil;
//    _zoomView.image = nil;
//    _index = NSUIntegerMax;
//}

#pragma mark - Layout

- (void)layoutSubviews
{
    // Update tap view frame
    _tapView.frame = self.bounds;
    
    // Position indicators (centre does not seem to work!)
    if (!_loadingIndicator.hidden)
        _loadingIndicator.frame = CGRectMake(floorf((self.bounds.size.width - _loadingIndicator.frame.size.width) / 2.),
                                             floorf((self.bounds.size.height - _loadingIndicator.frame.size.height) / 2),
                                             _loadingIndicator.frame.size.width,
                                             _loadingIndicator.frame.size.height);
    if (_loadingError)
        _loadingError.frame = CGRectMake(floorf((self.bounds.size.width - _loadingError.frame.size.width) / 2.),
                                         floorf((self.bounds.size.height - _loadingError.frame.size.height) / 2),
                                         _loadingError.frame.size.width,
                                         _loadingError.frame.size.height);
    
    [super layoutSubviews];
    
    // center the zoom view as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.zoomView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(self.zoomView.frame, frameToCenter)) {
        self.zoomView.frame = frameToCenter;
    }
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.scrollEnabled = YES; // reset
}

#pragma mark - Configure scrollView to display new image

- (void)setPhoto:(id<SSPhoto>)photo
{
    // Cancel any loading on old photo
    if (_photo && photo == nil) {
        if ([_photo respondsToSelector:@selector(cancelAnyLoading)]) {
            [_photo cancelAnyLoading];
        }
    }
    _photo = photo;
    UIImage *img = [_photoBrowser imageForPhoto:_photo];
    if (img) {
        [self displayImage];
    } else {
        // Will be loading so show loading
        [self showLoadingIndicator];
    }
}


// Get and display image
- (void)displayImage {
    if (_photo && _zoomView.image == nil) {
        
        // Reset
        self.maximumZoomScale = 1;
        self.minimumZoomScale = 1;
        self.zoomScale = 1;
        self.contentSize = CGSizeMake(0, 0);
        
        // Get image from browser as it handles ordering of fetching
        UIImage *img = [_photoBrowser imageForPhoto:_photo];
        if (img) {
            
            // Hide indicator
            [self hideLoadingIndicator];
            
            // Set image
            _zoomView.image = img;
            _zoomView.hidden = NO;
            
            // Setup photo frame
            CGRect photoImageViewFrame;
            photoImageViewFrame.origin = CGPointZero;
            photoImageViewFrame.size = img.size;
            _zoomView.frame = photoImageViewFrame;
            self.contentSize = photoImageViewFrame.size;
            
            // Set zoom to minimum zoom
            [self setMaxMinZoomScalesForCurrentBounds];
            
        } else {
            
            // Failed no image
            [self displayImageFailure];
            
        }
        [self setNeedsLayout];
    }
}

// Image failed so just show black!
- (void)displayImageFailure
{
    [self hideLoadingIndicator];
    _zoomView.image = nil;
    if (!_loadingError) {
        _loadingError = [UIImageView new];
        _loadingError.image = [UIImage imageNamed:@"SSPhotoBrowser_ImageError.png"];
        _loadingError.userInteractionEnabled = NO;
        _loadingError.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [_loadingError sizeToFit];
        [self addSubview:_loadingError];
    }
    _loadingError.frame = CGRectMake(floorf((self.bounds.size.width - _loadingError.frame.size.width) / 2.),
                                     floorf((self.bounds.size.height - _loadingError.frame.size.height) / 2),
                                     _loadingError.frame.size.width,
                                     _loadingError.frame.size.height);
}

- (void)hideImageFailure {
    if (_loadingError) {
        [_loadingError removeFromSuperview];
        _loadingError = nil;
    }
}

#pragma mark - Loading Progress

- (void)setProgressFromNotification:(NSNotification *)notification {
    NSDictionary *dict = [notification object];
    id <SSPhoto> photoWithProgress = [dict objectForKey:@"photo"];
    if (photoWithProgress == self.photo) {
        float progress = [[dict valueForKey:@"progress"] floatValue];
        _loadingIndicator.progress = MAX(MIN(1, progress), 0);
    }
}

- (void)handleSSPhotoLoadingDidEndNotification:(NSNotification *)notification
{
    id <SSPhoto> photo = [notification object];
    if (photo == self.photo) {
        if ([photo underlyingImage]) {
            // Successful load
            [self displayImage];
        } else {
            // Failed to load
            [self displayImageFailure];
        }
    }
}

- (void)hideLoadingIndicator
{
    _loadingIndicator.hidden = YES;
}

- (void)showLoadingIndicator
{
    self.zoomScale = 0;
    self.minimumZoomScale = 0;
    self.maximumZoomScale = 0;
    _loadingIndicator.progress = 0.f;
    _loadingIndicator.hidden = NO;
    [self hideImageFailure];
}


#pragma mark - Setup

- (CGFloat)initialZoomScaleWithMinScale {
    CGFloat zoomScale = self.minimumZoomScale;
    if (_zoomView) {
        // Zoom image to fill if the aspect ratios are fairly similar
        CGSize boundsSize = self.bounds.size;
        CGSize imageSize = _zoomView.image.size;
        CGFloat boundsAR = boundsSize.width / boundsSize.height;
        CGFloat imageAR = imageSize.width / imageSize.height;
        CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
        CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
        // Zooms standard portrait images on a 3.5in screen but not on a 4in screen.
        if (ABS(boundsAR - imageAR) < 0.17) {
            zoomScale = MAX(xScale, yScale);
            // Ensure we don't zoom in or out too far, just in case
            zoomScale = MIN(MAX(self.minimumZoomScale, zoomScale), self.maximumZoomScale);
        }
    }
    return zoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    // Bail if no image
    if (_zoomView.image == nil) return;
    
    // Reset position
    _zoomView.frame = CGRectMake(0, 0, _zoomView.frame.size.width, _zoomView.frame.size.height);
    
    // Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _zoomView.image.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // Calculate Max
    CGFloat maxScale = 3;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Let them go a bit bigger on a bigger screen!
        maxScale = 4;
    }
    
    // Image is smaller than screen so no zooming!
    if (xScale >= 1 && yScale >= 1) {
        minScale = 1.0;
    }
    
    // Set min/max zoom
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    
    // Initial zoom
    self.zoomScale = [self initialZoomScaleWithMinScale];
    
    // If we're zooming to fill then centralise
    if (self.zoomScale != minScale) {
        // Centralise
        self.contentOffset = CGPointMake((imageSize.width * self.zoomScale - boundsSize.width) / 2.0,
                                         (imageSize.height * self.zoomScale - boundsSize.height) / 2.0);
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.scrollEnabled = NO;
    }
    
    // Layout
    [self setNeedsLayout];
}

#pragma mark - Tap Detection

- (void)handleSingleTap:(CGPoint)touchPoint {
    [_photoBrowser performSelector:@selector(dismissSSPhotoBrowserWithIndex:) withObject:@(self.index) afterDelay:0.2f];
}

- (void)handleDoubleTap:(CGPoint)touchPoint {
    
    // Cancel any single tap handling
    [NSObject cancelPreviousPerformRequestsWithTarget:_photoBrowser];
    
    // Zoom
    if (self.zoomScale != self.minimumZoomScale && self.zoomScale != [self initialZoomScaleWithMinScale]) {
        
        // Zoom out
        [self setZoomScale:self.minimumZoomScale animated:YES];
        
    } else {
        
        // Zoom in to twice the size
        CGFloat newZoomScale = ((self.maximumZoomScale + self.minimumZoomScale) / 2);
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }
    
    // Delay controls
    //    [_photoBrowser hideControlsAfterDelay];
    
}

// Image View
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self handleSingleTap:[touch locationInView:imageView]];
}
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:imageView]];
}

// Background View
- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch {
    // Translate touch location to image view location
    CGFloat touchX = [touch locationInView:view].x;
    CGFloat touchY = [touch locationInView:view].y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.contentOffset.x;
    touchY += self.contentOffset.y;
    [self handleSingleTap:CGPointMake(touchX, touchY)];
}
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch {
    // Translate touch location to image view location
    CGFloat touchX = [touch locationInView:view].x;
    CGFloat touchY = [touch locationInView:view].y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.contentOffset.x;
    touchY += self.contentOffset.y;
    [self handleDoubleTap:CGPointMake(touchX, touchY)];
}



#pragma mark -
#pragma mark Methods called during rotation to preserve the zoomScale and the visible portion of the image

#pragma mark - Rotation support

- (void)setFrame:(CGRect)frame
{
    BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);
    
    if (sizeChanging) {
        [self prepareToResize];
    }
    
    [super setFrame:frame];
    
    if (sizeChanging) {
        [self recoverFromResizing];
    }
}

- (void)prepareToResize
{
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _pointToCenterAfterResize = [self convertPoint:boundsCenter toView:self.zoomView];
    
    _scaleToRestoreAfterResize = self.zoomScale;
    
    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
    // allowable scale when the scale is restored.
    if (_scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON)
        _scaleToRestoreAfterResize = 0;
}

- (void)recoverFromResizing
{
    [self setMaxMinZoomScalesForCurrentBounds];
    
    // Step 1: restore zoom scale, first making sure it is within the allowable range.
    CGFloat maxZoomScale = MAX(self.minimumZoomScale, _scaleToRestoreAfterResize);
    self.zoomScale = MIN(self.maximumZoomScale, maxZoomScale);
    
    // Step 2: restore center point, first making sure it is within the allowable range.
    
    // 2a: convert our desired center point back to our own coordinate space
    CGPoint boundsCenter = [self convertPoint:_pointToCenterAfterResize fromView:self.zoomView];
    
    // 2b: calculate the content offset that would yield that center point
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                                 boundsCenter.y - self.bounds.size.height / 2.0);
    
    // 2c: restore offset, adjusted to be within the allowable range
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];
    
    CGFloat realMaxOffset = MIN(maxOffset.x, offset.x);
    offset.x = MAX(minOffset.x, realMaxOffset);
    
    realMaxOffset = MIN(maxOffset.y, offset.y);
    offset.y = MAX(minOffset.y, realMaxOffset);
    
    self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
    return CGPointZero;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
