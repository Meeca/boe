//
//  UpDataViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "UpDataViewController.h"
#import "PhotoCollecCell.h"
#import "PrintViewController.h"

@interface UpDataViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    NSMutableArray *_dataImages;
    UICollectionView *collection;
    
    UIButton *rightTitle;
    
    NSMutableArray *selArr;
    NSInteger current;
    void(^ _block)(NSArray *arr);
    BOOL isAdd;
}

@end

@implementation UpDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back:)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: {
                    //  相册
                    [self loadImages];
                    break;
                }
                    
                case PHAuthorizationStatusDenied: {
                    if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                    
                    BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"请前往->设置->隐私->相片，打开授权" cancelButtonTitle:@"确定" clickButton:^(NSInteger index) {
                        
                    } otherButtonTitles:nil];
                    
                    [alert show];
                    break;
                }
                    
                case PHAuthorizationStatusRestricted: {
                    [self presentMessageTips:@"因系统原因，无法访问相册！"];
                    break;
                }
                    
                default:
                    break;
            }
        });
    }];
    
    [self _initView];
    
}

- (void)loadImages {
    _dataImages = [NSMutableArray array];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    //    Results 中包含的，应该就是各个资源（PHAsset）
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        [_dataImages addObject:asset];
    }];
    [self performSelectorOnMainThread:@selector(loacUI) withObject:nil waitUntilDone:YES];

}

- (void)loacUI {
    if (isAdd) {
        selArr = [NSMutableArray array];
        for (int i=0; i<_dataImages.count; i++) {
            [selArr addObject:@(NO)];
        }
    }
    [collection reloadData];
}

- (void)_initView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KSCREENWIDTH-21)/3, (KSCREENWIDTH-21)/3);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = RGB(234, 234, 234);
    collection.alwaysBounceVertical = YES;
    
    [collection registerClass:[PhotoCollecCell class] forCellWithReuseIdentifier:@"photo"];
    [self.view addSubview:collection];
}

- (void)currentCount:(NSInteger)count block:(void(^)(NSArray *arr))block {
    current = count;
    _block = [block copy];
    
    NSString *title = [NSString stringWithFormat:@"(%@/9)完成", @(count)];
    
    rightTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTitle addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [rightTitle setTitle:title forState:UIControlStateNormal];
    [rightTitle setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
    rightTitle.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightTitle sizeToFit];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightTitle];
    self.navigationItem.rightBarButtonItem = right;
    isAdd = YES;
}

- (void)loadTitle {
    
    NSMutableArray *selIndexArr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        NSNumber *s = selArr[i];
        if ([s boolValue]) {
            [selIndexArr addObject:@(i)];
        }
    }
    
    NSString *title = [NSString stringWithFormat:@"(%@/9)完成", @(current+selIndexArr.count)];

    [rightTitle setTitle:title forState:UIControlStateNormal];
    [rightTitle sizeToFit];
}

#pragma mark - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataImages.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    if (isAdd) {
        if (indexPath.item == 0) {
            cell.isHidSel = YES;
            cell.image = [UIImage imageNamed:@"cheam"];
            [cell setNeedsLayout];
        } else {
            cell.isHidSel = NO;
            cell.isSel = [selArr[indexPath.item-1] boolValue];
            PHAsset *phAsset = _dataImages[indexPath.item - 1];
            PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
            phImageRequestOptions.synchronous = YES;
            // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:phAsset targetSize:CGSizeMake((KSCREENWIDTH-21)/3, (KSCREENWIDTH-21)/3) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                NSLog(@"%@",NSStringFromCGSize(result.size));
                cell.image = result;
                [cell setNeedsLayout];
            }];
        }
    } else {
        cell.isHidSel = YES;
        if (indexPath.item == 0) {
            cell.image = [UIImage imageNamed:@"cheam"];
            [cell setNeedsLayout];
        } else {
            PHAsset *phAsset = _dataImages[indexPath.item - 1];
            PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
            phImageRequestOptions.synchronous = YES;
            // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:phAsset targetSize:CGSizeMake((KSCREENWIDTH-21)/3, (KSCREENWIDTH-21)/3) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                NSLog(@"%@",NSStringFromCGSize(result.size));
                cell.image = result;
                [cell setNeedsLayout];
            }];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isAdd) {
        if (indexPath.item==0) {
            [self presentMessageTips:@"加载中..."];

            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor orangeColor];
            UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
            picker.sourceType = sourcheType;
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:NULL];
        } else {
            
            NSMutableArray *selIndexArr = [NSMutableArray array];
            for (int i=0; i<selArr.count; i++) {
                NSNumber *s = selArr[i];
                if ([s boolValue]) {
                    [selIndexArr addObject:@(i)];
                }
            }
            
            if (selIndexArr.count >= (9-current)) {
                
                BOOL canel = NO;
                for (NSNumber *index in selIndexArr) {
                    if ((indexPath.item-1)==[index integerValue]) {
                        canel = YES;
                        break;
                    }
                }
                
                if (!canel) {
                    [self presentMessageTips:@"最多可选9张"];
                    return;
                }
            }
            
            BOOL sel = [selArr[indexPath.item-1] boolValue];
            [selArr removeObjectAtIndex:indexPath.item-1];
            [selArr insertObject:@(!sel) atIndex:indexPath.item-1];
            PhotoCollecCell *cell = (PhotoCollecCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.isSel = !sel;
            
            [self loadTitle];
        }
    } else {
        [self presentMessageTips:@"加载中..."];
        
        if (indexPath.item==0) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor orangeColor];
            UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
            picker.sourceType = sourcheType;
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:NULL];
        } else {
            
            BlockUIAlertView *alact = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"如果您开启了 iCloud 照片库，并且选择了“优化 iPhone/iPad 储存空间，可能需要等待图片下载完成，是否继续" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
                if (index) {
                    PrintViewController *vc = [[PrintViewController alloc] init];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            PHAsset *phAsset = _dataImages[indexPath.item - 1];
                            PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
                            phImageRequestOptions.synchronous = YES;
                            phImageRequestOptions.networkAccessAllowed = YES;
                            phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
                            [phImageRequestOptions setProgressHandler:^(double progress, NSError *__nullable error, BOOL *stop, NSDictionary *__nullable info){
                                NSLog(@"%@",@(progress));
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSString *str = [NSString stringWithFormat:@"%d %%...", (int)(progress*100)];
                                    [self presentLoadingTips:str];
                                });
                            }];
                            // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
                            PHImageManager *imageManager = [[PHImageManager alloc] init];
                            [imageManager requestImageForAsset:phAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"%@",NSStringFromCGSize(result.size));
                                    [self dismissTips];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        if (!result) {
                                            [self presentMessageTips:@"下载失败"];
                                            return;
                                        }
                                        vc.image = result;
                                        [self.navigationController pushViewController:vc animated:YES];
                                    });
                                });
                            }];
                            NSLog(@"卡这里了。。。。");
                        });
                    });
                }
            } otherButtonTitles:@"确定"];
            [alact show];
            
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark — UINavigationControllerDelegate, UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation = image.imageOrientation;
        
        if(imageOrientation != UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    
    
        if (isAdd) {
            
            if (_block) {
                _block(@[image]);
                
                [picker dismissViewControllerAnimated:YES completion:NULL];
                [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
                
            }
        } else {
            NSLog(@"%@", info);
            
            NSLog(@"image.size  %@", NSStringFromCGSize(image.size));
            
            PrintViewController *vc = [[PrintViewController alloc] init];
            vc.image = image;
            
            [self.navigationController pushViewController:vc animated:YES];
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
        
    }
}

- (void)finish:(UIBarButtonItem *)btn {
    NSMutableArray *selIndexArr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        NSNumber *s = selArr[i];
        if ([s boolValue]) {
            [selIndexArr addObject:@(i)];
        }
    }
    
    if (selIndexArr.count==0) {
        [self presentMessageTips:@"请选择图片"];
        return;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSNumber *index in selIndexArr) {
        PHAsset *result = _dataImages[[index integerValue]];

        [arr addObject:result];
    }
    
    if (_block) {
        _block(arr);
        
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)back:(UIBarButtonItem *)btn {
    [self dismissViewControllerAnimated:YES completion:NULL];
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
