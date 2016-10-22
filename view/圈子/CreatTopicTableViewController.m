//
//  CreatTopicTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/23.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CreatTopicTableViewController.h"
#import "JDFConversCreateCell.h"
#import "JDFConversAddCell.h"
#import "UzysAssetsPickerController.h"
#import <AVFoundation/AVFoundation.h>
#import "MCHttp.h"
#import "UIViewController+MBShow.h"
#import "CircleConversViewController.h"
#import "UpDataViewController.h"


@interface CreatTopicTableViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UzysAssetsPickerControllerDelegate>{
    
    
    NSInteger  urlContent;
    UICollectionView *ticaiView;
    NSMutableArray *ticaiSelArr;  //  多选
    UICollectionView *imgsCollectView;
    
    NSInteger photoIndex;
    
}
@property (weak, nonatomic) IBOutlet UITextField *topicContentTextField;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imageUrls;


@end

@implementation CreatTopicTableViewController

-(NSMutableArray *)images
{
    if (_images == nil)
    {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建一个话题";
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
    
    _imageUrls = [NSMutableArray new];
    
    
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    
    
    
}
- (IBAction)addPicture:(id)sender{
    if (self.images.count >= 9) {
        [self showToastWithMessage:@"最多可选9张"];
        return;
    }
    UpDataViewController *vc = [[UpDataViewController alloc] init];
    [vc currentCount:_imageUrls.count block:^(NSArray *arr) {
        [self.images addObjectsFromArray:arr];
        
        [self.collectionView reloadData];
        NSLog(@"photo - %@",arr);
    }];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    vc.title = @"选择图片";
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)endEditing

{
    [self.view endEditing:YES];
}

#pragma mark - Table view data source
- (IBAction)Publish:(id)sender
{
    [self.view endEditing:YES];
    NSLog(@"你点击了发布按钮");
    if (self.topicContentTextField.text.length == 0) {
        
        NSLog(@"内容不能为空");
        [self  showToastWithMessage:@"内容不能为空"];
        
        return;
        
    }
    else if (self.topicContentTextField.text.length< 12) {
        [self showToastWithMessage:@"话题内容不能少于20字符"];
        return;
    }
    
    
    if(self.images.count == 0){
        
        //        1》 没有图片
        //
        //        提交数据
        
        
        [self upQuanziDataWithImages:nil];
        
    }else{
        
        photoIndex = 0;
        
        [self upData];
//        [self.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            __block UIImage *img = nil;
//            
//            if ([obj isKindOfClass:[PHAsset class]]) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    PHAsset *phAsset = obj;
//                    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
//                    phImageRequestOptions.synchronous = YES;
//                    PHImageManager *imageManager = [[PHImageManager alloc] init];
//                    [imageManager requestImageForAsset:phAsset targetSize:CGSizeMake(KSCREENWIDTH/3, KSCREENWIDTH/3) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            NSLog(@"img size %@  dic %@",NSStringFromCGSize(result.size), info);
//                            img = result;
//                            
//                            [self uploadImageDataWith:img];
//                        });
//                    }];
//                });
//                
//            } else {
//                img = (UIImage *)obj;
//            }
//            
//            [self uploadImageDataWith:img];
//        }];
    }
}


- (void)upData {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win presentLoadingTips:@"图片上传中..."];

    if ([self.images[photoIndex] isKindOfClass:[PHAsset class]]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHAsset *phAsset = self.images[photoIndex];
            PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
            phImageRequestOptions.synchronous = YES;
            phImageRequestOptions.networkAccessAllowed = YES;
            phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:phAsset targetSize:CGSizeMake(KSCREENWIDTH, KSCREENWIDTH) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"img size %@  dic %@",NSStringFromCGSize(result.size), info);
                    if (!result) {
                        [win presentMessageTips:@"上传失败"];
                        return;
                    }
                    [self uploadImageDataWith:result];
                    
                });
            }];
        });
    } else {
        [self uploadImageDataWith:self.images[photoIndex]];
    }
    
}


// 上传话题图片
-(void)uploadImageDataWith:(UIImage *)image{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    NSDictionary *parameters = @{@"type" : @"1",@"plates":@"2"};
    //
    NSString *msg = [NSString stringWithFormat:@"图片上传中(%@/%@)...", @(photoIndex+1), @(self.images.count)];
    [win presentLoadingTips:msg];

    [MCHttp uploadDataWithURLStr:@"/app.php/Index/image_add" withDic:parameters imageKey:@"image" withData:data uploadProgress:^(float progress) {
        
    } success:^(NSDictionary *requestDic, NSString *msg) {
        urlContent ++;

        photoIndex++;
        [_imageUrls addObject:requestDic[@"image_url"]];
        if (photoIndex<self.images.count) {
            [self upData];
            return;
        }
        
//        [_imageUrls addObject:requestDic[@"image_url"]];
        
        if (_imageUrls.count == self.images.count) {
            [self upQuanziDataWithImages:_imageUrls];
        }
        
        
        
        
    } failure:^(NSString *error) {
        [win presentMessageTips:@"上传失败"];

        urlContent ++;
        if (urlContent == self.images.count) {
            [self upQuanziDataWithImages:_imageUrls];
        }
        
    }];
    
}


//  发布话题
- (void)upQuanziDataWithImages:(NSArray *)images{
    
    NSString * title = self.topicContentTextField.text;
    NSString * imagesStr = [self array2string:images];// images    -- ba shu zu zhuang hua cheng  zi fu chuan
    NSString * content = @"";
    
    NSString *path = @"/app.php/Circles/conv_add";
    
    NSDictionary *params = @{@"co_id" :@"",
                             @"u_id" :kUserId,
                             @"title" :title,
                             @"c_id" : _cID,
                             @"image" :imagesStr,
                             @"content" :content};
    [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         
         
//         CircleConversViewController *circleMembersVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
//         
//         [self.navigationController pushViewController:circleMembersVC animated:YES];
//         BOOL flag = NO;
//         
//         NSMutableArray *array = [NSMutableArray array];
//         for (int i = 0; i < self.navigationController.viewControllers.count - 1; i ++)
//         {
//             UIViewController *vc = self.navigationController.viewControllers[i];
//             if (flag == NO && [vc isKindOfClass:[CircleConversViewController class]])
//             {
//                 flag = YES;
//             }
//             
//             if (flag)
//             {
//                 [array addObject:vc];
//             }
//             
//         }
//         
//         NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//         [viewControllers removeObjectsInArray:array];
//         
//         self.navigationController.viewControllers = viewControllers;
         UIWindow *win = [UIApplication sharedApplication].keyWindow;
         
         [win dismissTips];

         
         [self.navigationController popViewControllerAnimated:YES];
     }failure:^(NSString *error) {
         
         
         
     }];
    
}



- (NSString *)array2string:(NSArray *)array{
    if (array.count == 0) {
        return @"";
    }
    NSString *ns=[array componentsJoinedByString:@"-"];
    return ns;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item >= self.images.count)
    {
        JDFConversAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDFConversAddCell" forIndexPath:indexPath];
        
        cell.block = ^(UIButton *button)
        {
            [self addPicture:button];
        };
        
        return cell;
    }
    else
    {
        JDFConversCreateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDFConversCreateCell" forIndexPath:indexPath];
        
//        UIImage *image = self.images[indexPath.item];
//        cell.photoImage = image;
//        
        
        if ([self.images[indexPath.item] isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = self.images[indexPath.item];
            PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
            phImageRequestOptions.synchronous = YES;
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:phAsset targetSize:CGSizeMake(KSCREENWIDTH/3, KSCREENWIDTH/3) contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                NSLog(@"img size %@  dic %@",NSStringFromCGSize(result.size), info);
                cell.photoImage = result;
                [cell setNeedsLayout];
            }];
        } else {
            cell.photoImage = self.images[indexPath.item];
            [cell setNeedsLayout];
        }
        
        return cell;
    }
    
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    for (ALAsset *representation in assets)
    {
        UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                           scale:representation.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
        [self.images addObject:img];
    }
    
    [self.collectionView reloadData];
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedStringFromTable(@"Exceed Maximum Number Of Selection", @"UzysAssetsPickerController", nil)
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==ticaiView) {
        BOOL sel = [ticaiSelArr[indexPath.item] boolValue];
        [ticaiSelArr removeObjectAtIndex:indexPath.item];
        [ticaiSelArr insertObject:@(!sel) atIndex:indexPath.item];
        [collectionView reloadData];
    } else if (collectionView==imgsCollectView) {
        BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"" message:@"您确定移除这张图片" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
            if (index==1) {
                [self.images removeObjectAtIndex:indexPath.item];
                [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                [Tool performBlock:^{
                    [self.collectionView reloadData];
                } afterDelay:.3];
            }
        } otherButtonTitles:@"确定"];
        [alert show];
    }
}

- (void) a

{
    
    
    //        for (UIImage * img in self.images) {
    //
    //
    //        }
    //
    //
    //        for (NSInteger i  = 0; i < self.images.count; i ++) {
    //
    //        }
    //
    //
    //        NSDictionary * dict ;
    //
    //        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    //
    //        }];
    //
    
    
}
@end
