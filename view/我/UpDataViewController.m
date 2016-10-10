//
//  UpDataViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/24.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "UpDataViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
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

static ALAssetsLibrary *_library = nil;

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _library = [[ALAssetsLibrary alloc] init];
    });
    return _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(back:)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    [self _initView];
    //1.创建相册
    _library = [UpDataViewController defaultAssetsLibrary];
    _dataImages = [NSMutableArray array];
    
    //通过相册取得文件夹
    /*
     通过相册枚举遍历所有的文件夹ALAssetsGroup
     注意：usingBlock会多次调用，有多少个文件夹就调用多少次
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [_library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            if(group != nil) {
                
                //2.通过文件夹遍历所有的资源文件Asset
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    
                    if (result != nil) {
                        [_dataImages addObject:result];
                    }
                }];
                [self performSelectorOnMainThread:@selector(loacUI) withObject:nil waitUntilDone:YES];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"文件读取失败：error:%@",error);
        }];
    });
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
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ALAsset *result = _dataImages[indexPath.item - 1];
                CGImageRef imageRef = [result aspectRatioThumbnail];  //  缩略图
                //            ALAssetRepresentation *representation = [result defaultRepresentation];
                //            CGImageRef imageRef = [representation fullResolutionImage];  //  全尺寸图
                UIImage *image = [UIImage imageWithCGImage:imageRef];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",NSStringFromCGSize(image.size));
                    cell.image = image;
                    [cell setNeedsLayout];
                });
            });
        }
    } else {
        cell.isHidSel = YES;
        if (indexPath.item == 0) {
            cell.image = [UIImage imageNamed:@"cheam"];
            [cell setNeedsLayout];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ALAsset *result = _dataImages[indexPath.item - 1];
                CGImageRef imageRef = [result aspectRatioThumbnail];  //  缩略图
                //            ALAssetRepresentation *representation = [result defaultRepresentation];
                //            CGImageRef imageRef = [representation fullResolutionImage];  //  全尺寸图
                UIImage *image = [UIImage imageWithCGImage:imageRef];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",NSStringFromCGSize(image.size));
                    cell.image = image;
                    [cell setNeedsLayout];
                });
            });
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
            
            PrintViewController *vc = [[PrintViewController alloc] init];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ALAsset *result = _dataImages[indexPath.item - 1];
                ALAssetRepresentation *representation = [result defaultRepresentation];
                CGImageRef imageRef = [representation fullResolutionImage];  //  全尺寸图
                UIImage *image = [UIImage imageWithCGImage:imageRef scale:[representation scale] orientation:(UIImageOrientation)[representation orientation]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",NSStringFromCGSize(image.size));
                    vc.image = image;
                    [self.navigationController pushViewController:vc animated:YES];
                });
            });
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark — UINavigationControllerDelegate, UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (isAdd) {
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        if (_block) {
            _block(@[image]);
            
            [picker dismissViewControllerAnimated:YES completion:NULL];
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
            
        }
    } else {
        NSLog(@"%@", info);
        
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        NSLog(@"image.size  %@", NSStringFromCGSize(image.size));
        
        PrintViewController *vc = [[PrintViewController alloc] init];
        vc.image = image;
        
        [self.navigationController pushViewController:vc animated:YES];
        [picker dismissViewControllerAnimated:YES completion:NULL];
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
        ALAsset *result = _dataImages[[index integerValue]];
//        ALAssetRepresentation *representation = [result defaultRepresentation];
//        CGImageRef imageRef = [representation fullResolutionImage];  //  全尺寸图
//        UIImage *image = [UIImage imageWithCGImage:imageRef];

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
