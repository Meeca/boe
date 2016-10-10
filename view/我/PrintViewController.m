//
//  PrintViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/30.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PrintViewController.h"
#import "UpViewController.h"

@interface PrintViewController ()  <UIScrollViewDelegate> {
    UIView *nav;
    
    UIView *printscreen;
    UIScrollView *operationScr;
    UIView *trans;
    UIView *cutView;
    UIImageView *imageView;
    UIImageView *seeImage;
    
    NSInteger pixel;
    
    BOOL isH;
    
    UIButton *save;
    UIButton *back;
    
    UIButton *v;
    UIButton *h;
}

@end

#define kScreenWidth   ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   ([[UIScreen mainScreen] bounds].size.height)

@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    NSLog(@" UIScreen mainScreen:%@", NSStringFromCGRect(rect));
    if (rect.size.height==568 || rect.size.height== 667) {
        pixel = 2;
    } else if (rect.size.height==736) {
        pixel = 3;
    } else {
        pixel = 1;
    }
    
    nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 44)];
    nav.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:nav];
    
    save = [UIButton buttonWithType:UIButtonTypeCustom];
    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(KSCREENWIDTH - 44, 0, 44, 44);
    [save setImage:[UIImage imageNamed:@"B-23-2"] forState:UIControlStateNormal];
    [[[UIApplication sharedApplication] keyWindow] addSubview:save];
    
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(0, 0, 44, 44);
    [back setImage:[UIImage imageNamed:@"B-22-2"] forState:UIControlStateNormal];
    [[[UIApplication sharedApplication] keyWindow] addSubview:back];
    
    v = [UIButton buttonWithType:UIButtonTypeCustom];
    v.frame = CGRectMake(0, 64, 100, 60);
    [v setTitle:@"坚屏" forState:UIControlStateNormal];
    [v addTarget:self action:@selector(vOrh:) forControlEvents:UIControlEventTouchUpInside];
    [v setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    [[[UIApplication sharedApplication] keyWindow] addSubview:v];
    
    h = [UIButton buttonWithType:UIButtonTypeCustom];
    h.frame = CGRectMake(0, 64, 100, 60);
    [h setTitle:@"横屏" forState:UIControlStateNormal];
    [h addTarget:self action:@selector(vOrh:) forControlEvents:UIControlEventTouchUpInside];
    [h setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[[UIApplication sharedApplication] keyWindow] addSubview:h];
    
    v.x = (KSCREENWIDTH - 210)/2;
    h.x = v.right + 10;
}

- (void)setImage:(UIImage *)image {
    if (image != _image) {
        _image = image;
    }
    [self layoutview];
}

- (void)layoutview {
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    // 被截图的  父视图
    if (printscreen==nil) {
        printscreen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1920, 1080)];
        printscreen.backgroundColor = [UIColor blackColor];
        //    [self.view addSubview:printscreen];
    }
    if (isH) {
        printscreen.frame = CGRectMake(0, 0, 1920, 1080);
    } else {
        printscreen.frame = CGRectMake(0, 0, 1080, 1920);
    }
    if (operationScr==nil) {
        // 可视的背景面
        operationScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, rect.size.width, rect.size.height)];
        operationScr.alwaysBounceVertical = YES;
        operationScr.alwaysBounceHorizontal = YES;
        operationScr.showsVerticalScrollIndicator = NO;
        operationScr.showsHorizontalScrollIndicator = NO;
        
        operationScr.delegate = self;
        
        operationScr.backgroundColor = [UIColor grayColor];
        [self.view addSubview:operationScr];
    }
    
    CGFloat width;
    CGFloat height;
    if (isH) {
        width = kScreenWidth - 60;
        height = width*1080/1920;
    } else {
        width = kScreenWidth - 120;
        height = width*1920/1080;
    }
    CGFloat x = (kScreenWidth-width)/2;
    CGFloat y = (kScreenHeight-height)/2;
    
    if (trans==nil) {
        trans = [[UIView alloc] initWithFrame:rect];
        trans.backgroundColor = [UIColor clearColor];
        [[[UIApplication sharedApplication] keyWindow] addSubview:trans];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
        view1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        view1.tag = 101;
        [trans addSubview:view1];
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
        view2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        view2.tag = 102;
        [trans addSubview:view2];
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectZero];
        view3.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        view3.tag = 103;
        [trans addSubview:view3];
        UIView *view4 = [[UIView alloc] initWithFrame:CGRectZero];
        view4.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        view4.tag = 104;
        [trans addSubview:view4];
    }
    if (cutView==nil) {
        cutView = [[UIView alloc] initWithFrame:CGRectZero];
        cutView.backgroundColor = [UIColor clearColor];
        cutView.layer.borderColor = [UIColor whiteColor].CGColor;
        cutView.layer.borderWidth = 1;
        trans.userInteractionEnabled = NO;
        [trans addSubview:cutView];
    }
    cutView.frame = CGRectMake(x, y+44, width, height);
    if (trans) {
        UIView *view1 = [trans viewWithTag:101];
        UIView *view2 = [trans viewWithTag:102];
        UIView *view3 = [trans viewWithTag:103];
        UIView *view4 = [trans viewWithTag:104];
        
        view1.frame = CGRectMake(0, 0, KSCREENWIDTH, cutView.top);
        view2.frame = CGRectMake(0, cutView.top, cutView.left, cutView.height);
        view3.frame = CGRectMake(cutView.right, cutView.top, cutView.left, cutView.height);
        view4.frame = CGRectMake(0, cutView.bottom, KSCREENWIDTH, cutView.top);
    }
    
    UIImage *image = self.image;
    // 操作的幅本
    if (seeImage==nil) {
        seeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [operationScr addSubview:seeImage];
    }
    seeImage.image = self.image;
    
    CGFloat imgWid = width;
    
    CGFloat imgHei = image.size.height*width/image.size.width;
    operationScr.minimumZoomScale = 1;
    operationScr.maximumZoomScale = image.size.width/imgWid>1?image.size.width/imgWid:1;
    
    if (imgHei >= height) {
        seeImage.frame = CGRectMake(0, 0, imgWid, imgHei);
        operationScr.contentSize = seeImage.frame.size;
        operationScr.contentOffset = CGPointMake(-x, -(kScreenHeight-imgHei)/2);
    } else {
        imgHei = height;
        imgWid = image.size.width*height/image.size.height;
        
        seeImage.frame = CGRectMake(0, 0, imgWid, imgHei);
        operationScr.contentSize = seeImage.frame.size;
        operationScr.contentOffset = CGPointMake(-(kScreenWidth-imgWid)/2, -y);
    }
    
    // 原图片
    if (imageView==nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [printscreen addSubview:imageView];
    }
    
    imageView.image = image;
    NSLog(@" imageView.frame:%@", NSStringFromCGRect(imageView.frame));
    operationScr.contentInset = UIEdgeInsetsMake((kScreenHeight-height)/2, (kScreenWidth-width)/2, (kScreenHeight-height)/2, (kScreenWidth-width)/2);
    
    [v.superview bringSubviewToFront:v];
    [h.superview bringSubviewToFront:h];
    [save.superview bringSubviewToFront:save];
    [back.superview bringSubviewToFront:back];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return seeImage;
}

- (void)save {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win presentLoadingTips:@"正在载取..."];
    
    UpViewController *vc = [[UpViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.isH = isH;
    [self.navigationController pushViewController:vc animated:YES];
    
    CGFloat width;
    CGFloat height;
    CGFloat H;
    CGFloat V;
    if (isH) {
        width = kScreenWidth - 60;
        height = width*1080/1920;
        H = 1920;
        V = 1080;
    } else {
        width = kScreenWidth - 120;
        height = width*1920/1080;
        H = 1080;
        V = 1920;
    }
    
    CGRect ect = [seeImage.superview convertRect:seeImage.frame toView:cutView];
    NSLog(@" ect:%@", NSStringFromCGRect(ect));
    CGFloat wid = ect.size.width*H/width;
    CGFloat hei = ect.size.height*V/height;
    CGFloat xx;
    CGFloat yy;
    if (ect.origin.x == 0) {
        xx = 0;
    } else {
        xx = ect.origin.x*H/width;
    }
    if (ect.origin.y == 0) {
        yy = 0;
    }else {
        yy = ect.origin.y*V/height;
    }
    imageView.frame = CGRectMake(xx/pixel, yy/pixel, wid/pixel, hei/pixel);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 图的大小  截出来的是  像素 X 像素  注意 @2x 和 @3x
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(H/pixel, V/pixel), YES, 0);
        [printscreen.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog(@"\npixel%@", @(pixel));
        NSLog(@"\viewImage%@", viewImage);

        dispatch_async(dispatch_get_main_queue(), ^{
            vc.image = viewImage;
        });
    });

    
    
    
    
//    UpViewController *vc = [[UpViewController alloc] init];
//    [Tool setBackButtonNoTitle:self];
//    vc.image = viewImage;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    NSData *imageViewData = UIImagePNGRepresentation(viewImage);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName = [NSString stringWithFormat:@"screenShow_yuan.png"];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    NSLog(@"\n截屏路径打印: \n%@", savedImagePath);
//    NSLog(@"\npixel%@", @(pixel));
//    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
}

- (void)vOrh:(UIButton *)btn {
    if (btn == v && isH != NO) {
        isH = NO;
        [h setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [v setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
        [self layoutview];
    }
    if (btn == h && isH != YES) {
        isH = YES;
        [v setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [h setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
        [self layoutview];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (trans) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:trans];
    }
    if (h) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:h];
    }
    if (v) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:v];
    }
    if (save) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:save];
    }
    if (back) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:back];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [trans removeFromSuperview];
    [h removeFromSuperview];
    [v removeFromSuperview];
    [save removeFromSuperview];
    [back removeFromSuperview];
    [super viewWillDisappear:animated];
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
