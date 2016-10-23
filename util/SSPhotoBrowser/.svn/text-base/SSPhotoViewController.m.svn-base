//
//  SSPhotoViewController.m
//  test
//
//  Created by sskh on 14-9-23.
//  Copyright (c) 2014年 sskh. All rights reserved.
//

#import "SSPhotoViewController.h"

@interface SSPhotoViewController ()
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic ,weak) SSPhotoBrowser *photoBrowser;
@property (nonatomic, strong) SSImageScrollView *imageScrollView;

@end

@implementation SSPhotoViewController

- (id)initWithPageIndex:(NSInteger)pageIndex photoBrowser:(SSPhotoBrowser *)photoBrowser
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _pageIndex = pageIndex;
        _photoBrowser = photoBrowser;
    }
    return self;
}

+ (SSPhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex photoBrowser:(SSPhotoBrowser *)photoBrowser
{
    return [[self alloc] initWithPageIndex:pageIndex photoBrowser:photoBrowser];
}

- (void)loadView
{
    [super loadView];
    
    _imageScrollView = [[SSImageScrollView alloc] initWithPhotoBrowser:self.photoBrowser];
    _imageScrollView.index = _pageIndex;
    _imageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [_imageScrollView displayImage:[UIImage imageNamed:@"CuriousFrog.jpg"]];
    
    self.view = _imageScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageScrollView.photo = self.photo;
}

- (void)resetImageScrollView {
    [self.imageScrollView setMaxMinZoomScalesForCurrentBounds];
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
