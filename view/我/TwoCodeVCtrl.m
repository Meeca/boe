//
//  TwoCodeVCtrl.m
//  xingxiupro
//
//  Created by feng on 15/4/27.
//  Copyright (c) 2015年 XuDong Jin. All rights reserved.
//

#import "TwoCodeVCtrl.h"
#import <AVFoundation/AVFoundation.h>
#import "HandViewController.h"
#import "AddDvViewController.h"

@interface TwoCodeVCtrl () <AVCaptureMetadataOutputObjectsDelegate> {
    
    UIImageView *_line;
    BOOL upOrdown;
    int num;
}

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation TwoCodeVCtrl

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"手动添加" style:UIBarButtonItemStylePlain target:self action:@selector(addDv)];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    // 创建定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
    
    // 1.获取输入设备
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2.根据输入设备创建输入对象
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:inputDevice error:NULL];
    
    // 3.创建输出对象
    AVCaptureMetadataOutput *output =[[AVCaptureMetadataOutput alloc] init];
    [output setRectOfInterest:CGRectMake(100/KSCREENHEIGHT, ((KSCREENWIDTH-220)/2)/KSCREENWIDTH, 220/KSCREENHEIGHT, 220/KSCREENWIDTH)];
    // 4.设置输出对象的代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 5.创建会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    // 6.将输入和输出添加到会话中
#warning 由于输入和输入不能重复添加, 所以添加之前需要判断是否可以添加
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
#warning 注意: 设置数据类型一定要在输入对象添加到会话以后再设置, 否则会报错
    // 7.设置输出的数据类型(告诉输出对象能够解析什么类型的数据)
//    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code]];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 8.设置预览界面
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    // 8.开始采集数据
#warning 扫描二维码是一个很持久的操作, 也就是说需要花费很长的时间
    [session startRunning];
    
}

#pragma mark -  AVCaptureMetadataOutputObjectsDelegate
// 只要解析到了数据就会调用
// 注意: 该方法的调用频率非常高
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //    DDActionLog;
    // 1.判断是否解析到了数据
    if (metadataObjects.count > 0 ) {
        // 2.停止扫描
        [self.session stopRunning];
        
        // 3.移除预览界面
        [self.previewLayer removeFromSuperlayer];
        [self.view removeAllSubviews];
        
        // 4.取出数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
                
        NSString *str = obj.stringValue;
        
        if (str.length>0) {            
            AddDvViewController *vc = [[AddDvViewController alloc] init];
            vc.mac_id = str;
            vc.hidesBottomBarWhenPushed = YES;
            [Tool setBackButtonNoTitle:self];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        NSLog(@"%@", str);
        
        // 5.停止动画
//        [self.link invalidate];
//        self.link = nil;
        
        // 6.显示数据
//        UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
//        label.text = obj.stringValue;
//        [self.view addSubview:label];
    }
}
- (void)update {
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((KSCREENWIDTH-250)/2, 100+2*num, 250, 1);
        if (2*num == 220) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((KSCREENWIDTH-250)/2, 100+2*num, 250, 1);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addView];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];
}

- (void)addView {
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KSCREENWIDTH-220)/2, 100, 220, 220)];
    imageView.image = [UIImage imageNamed:@"扫描框.png"];
    [self.view addSubview:imageView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 100)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = .6;
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.bottom, KSCREENWIDTH, KSCREENHEIGHT-imageView.bottom)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = .6;
    [self.view addSubview:view2];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom, (KSCREENWIDTH-220)/2, view2.top-view1.bottom)];
    view3.backgroundColor = [UIColor blackColor];
    view3.alpha = .6;
    [self.view addSubview:view3];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(imageView.right, view1.bottom, (KSCREENWIDTH-220)/2, view2.top-view1.bottom)];
    view4.backgroundColor = [UIColor blackColor];
    view4.alpha = .6;
    [self.view addSubview:view4];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, 340, KSCREENWIDTH, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text = @"请扫描Gallery的二维码";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labIntroudction];
    
    upOrdown = NO;
    num = 0;
    if (!_line) {
        _line = [[UIImageView alloc] initWithFrame:CGRectMake((KSCREENWIDTH-250)/2, 100, 250, 1)];
        _line.contentMode = UIViewContentModeScaleAspectFill;
        _line.image = [UIImage imageNamed:@"扫面线.png"];
    }
    [self.view addSubview:_line];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addDv {
    [self.previewLayer removeFromSuperlayer];
    [self.view removeAllSubviews];

    HandViewController *vc = [[HandViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
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
