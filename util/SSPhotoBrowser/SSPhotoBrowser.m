//
//  SSPhotoBrowser.m
//  test
//
//  Created by sskh on 14-9-23.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import "SSPhotoBrowser.h"
#import "SSPhotoViewController.h"

@interface SSPhotoBrowser ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    UILabel *indexLabel;
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@end

@implementation SSPhotoBrowser

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//} 

#pragma mark - Init

- (id)init
{
    if ((self = [super init])) {
        [self _initialisation];
    }
    return self;
}

- (id)initWithDelegate:(id <SSPhotoBrowserDelegate>)delegate
{
    self = [self init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super initWithCoder:decoder])) {
        [self _initialisation];
    }
    return self;
}

- (void)_initialisation
{

//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    _currentPhotoIndex = 0;
    
    // Listen for MWPhoto notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleMWPhotoLoadingDidEndNotification:)
//                                                 name:MWPHOTO_LOADING_DID_END_NOTIFICATION
//                                               object:nil];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)createPageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey: @(20)}];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    _currentPhotoIndex = MAX(_currentPhotoIndex, 0);
    _currentPhotoIndex = MIN(_currentPhotoIndex, self.numberOfPhotos - 1);
    
    SSPhotoViewController *startingViewController = [SSPhotoViewController photoViewControllerForPageIndex:self.currentPhotoIndex photoBrowser:self];
    SSPhoto *photo = (SSPhoto *)[self.delegate ss_photoBrowser:self photoAtIndex:self.currentPhotoIndex];
    startingViewController.photo = photo;
    [self.pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    //    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    //    }
    
    self.pageViewController.view.frame = pageViewRect;
    
    indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, KSCREENWIDTH, 30)];
    indexLabel.font = [UIFont systemFontOfSize:18];
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.text = [NSString stringWithFormat:@"%ld / %ld", (unsigned long)_currentPhotoIndex+1, (unsigned long)_numberOfPhotos];
//    [self.view addSubview:indexLabel];
    
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];

    [self createPageViewController];
}

#pragma mark - 
- (void)showInViewController:(UIViewController *)viewController
{
    NSAssert([viewController isKindOfClass:[UIViewController class]], @"viewController must a viewController");
    
    SSPhotoViewController *photoVC = nil;
    
    BOOL shouldAnimationImageScrollView = NO;
    CGRect rect = CGRectNull;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ss_photoBrowser:photoRectAtIndex:)]) {
         rect = [self.delegate ss_photoBrowser:self photoRectAtIndex:self.currentPhotoIndex];
        
        if (!CGRectEqualToRect(rect, CGRectNull)) {
            shouldAnimationImageScrollView = YES;
            
            //这一句可以触发viewDidLoad方法，从而可以得到photoVC
            self.view.backgroundColor = [UIColor blackColor];
            photoVC = [self.pageViewController.viewControllers lastObject];
            photoVC.imageScrollView.frame = rect;
        }
    }
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:self animated:YES completion:^{
        if (shouldAnimationImageScrollView) {
            
            [UIView animateWithDuration:0.3f animations:^{
                photoVC.imageScrollView.frame = [[UIScreen mainScreen] bounds];
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
    
    
}

- (void)dismissSSPhotoBrowserWithIndex:(NSNumber *)indexNumber
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ss_photoBrowser:photoRectAtIndex:)]) {
        
        //当展示photoBrowser后，这个方法返回的rect缩小了一半，???
        CGRect rect = [self.delegate ss_photoBrowser:self photoRectAtIndex:[indexNumber unsignedIntegerValue]];
        //NSLog(@"rect:%@", NSStringFromCGRect(rect));
        
        if (!CGRectEqualToRect(rect, CGRectNull)) {
            
            
            [UIView animateWithDuration:0.3f animations:^{
                SSPhotoViewController *photoVC = [self.pageViewController.viewControllers lastObject];
                [photoVC resetImageScrollView];
                photoVC.imageScrollView.frame = CGRectMake(CGRectGetMinX(rect) * 2.f, CGRectGetMinY(rect) * 2.f + 20, CGRectGetWidth(rect) * 2.f, CGRectGetHeight(rect) * 2.f);
            } completion:^(BOOL finished) {
                
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            });
            
            return;
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(SSPhotoViewController *)viewController pageIndex];
    indexLabel.text = [NSString stringWithFormat:@"%ld / %ld", (unsigned long)index+1, (unsigned long)_numberOfPhotos];
    NSLog(@"Before   %ld",(unsigned long)index);
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    SSPhotoViewController *pvc = [SSPhotoViewController photoViewControllerForPageIndex:index photoBrowser:self];
    SSPhoto *photo = (SSPhoto *)[self.delegate ss_photoBrowser:self photoAtIndex:index];
    pvc.photo = photo;
    return pvc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(SSPhotoViewController *)viewController pageIndex];
    indexLabel.text = [NSString stringWithFormat:@"%ld / %ld", (unsigned long)index+1, (unsigned long)_numberOfPhotos];
    NSLog(@"After   %ld",(unsigned long)index);
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == self.numberOfPhotos) {
        return nil;
    }
    SSPhotoViewController *pvc = [SSPhotoViewController photoViewControllerForPageIndex:index photoBrowser:self];
    SSPhoto *photo = (SSPhoto *)[self.delegate ss_photoBrowser:self photoAtIndex:index];
    pvc.photo = photo;
    return pvc;
}


//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return self.numberOfPhotos;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return self.currentPhotoIndex;
//}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    for (SSPhotoViewController *pvc in pendingViewControllers) {
        [pvc resetImageScrollView];
    }
}

//- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
//    NSLog(@"finished:%@, completed:%@, previousViewControllers:%@", finished ? @"YES" : @"NO", completed ? @"YES" : @"NO", previousViewControllers);
//    for (SSPhotoViewController *pvc in previousViewControllers) {
//        NSLog(@"pvc:%@, pageIndex:%d", pvc, pvc.pageIndex);
//    }
//}

#pragma mark - 设置当前要显示的photo
// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index
{
    _currentPhotoIndex = index;
}

#pragma mark  Custom accessors

- (NSUInteger)numberOfPhotos
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ss_numberOfPhotosInPhotoBrowser:)]) {
        return [self.delegate ss_numberOfPhotosInPhotoBrowser:self];
    }
    else {
        return _numberOfPhotos;
    }
}


- (UIImage *)imageForPhoto:(id<SSPhoto>)photo {
    if (photo) {
        // Get image or obtain in background
        if ([photo underlyingImage]) {
            return [photo underlyingImage];
        } else {
            [photo loadUnderlyingImageAndNotify];
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
