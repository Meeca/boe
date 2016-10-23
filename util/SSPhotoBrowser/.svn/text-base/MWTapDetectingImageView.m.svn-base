//
//  UIImageViewTap.m
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "MWTapDetectingImageView.h"

@interface MWTapDetectingImageView () <UIActionSheetDelegate> {
    UILongPressGestureRecognizer *longTap;
}

@end

@implementation MWTapDetectingImageView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
        longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
        [self addGestureRecognizer:longTap];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image {
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled = YES;
        longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
        [self addGestureRecognizer:longTap];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
		self.userInteractionEnabled = YES;
        longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
        [self addGestureRecognizer:longTap];
	}
	return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
			[self handleSingleTap:touch];
			break;
		case 2:
			[self handleDoubleTap:touch];
			break;
		case 3:
			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)handleSingleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
		[_tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
		[_tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([_tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
		[_tapDelegate imageView:self tripleTapDetected:touch];
}

- (void)longTapAction:(UILongPressGestureRecognizer *)Tap {
    if (Tap == longTap) {
        if (Tap.state==UIGestureRecognizerStateBegan) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存到相册" otherButtonTitles:nil, nil];
            sheet.backgroundColor = [UIColor whiteColor];
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
        }
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex==0) {
        [[UIApplication sharedApplication].keyWindow presentLoadingTips:@"保存中……"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        //        [MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        [[UIApplication sharedApplication].keyWindow presentMessageTips:@"保存成功"];
    }
}

@end
