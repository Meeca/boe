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
    if (_images.count >= 9) {
        [self showToastWithMessage:@"最多可选9张"];
        return;
    }
    UpDataViewController *vc = [[UpDataViewController alloc] init];
    [vc currentCount:_imageUrls.count block:^(NSArray *arr) {
        for (UIImage * image in arr) {
//            UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
            [_images addObject:image];
        }
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
        
        [_images enumerateObjectsUsingBlock:^(UIImage * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self uploadImageDataWith:obj];
        }];
    }
}





// 上传话题图片
-(void)uploadImageDataWith:(UIImage *)image{
    
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    NSDictionary *parameters = @{@"type" : @"1",@"plates":@"2"};
    //
    [MCHttp uploadDataWithURLStr:@"/app.php/Index/image_add" withDic:parameters imageKey:@"image" withData:data uploadProgress:^(float progress) {
        
    } success:^(NSDictionary *requestDic, NSString *msg) {
        
        urlContent ++;
        
        [_imageUrls addObject:requestDic[@"image_url"]];
        
        if (_imageUrls.count == _images.count) {
            [self upQuanziDataWithImages:_imageUrls];
        }
        
        
        
        
    } failure:^(NSString *error) {
        
        urlContent ++;
        if (urlContent == _images.count) {
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
//         
         
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
        
        UIImage *image = self.images[indexPath.item];
        cell.photoImage = image;
        
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
                [_images removeObjectAtIndex:indexPath.item];
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
    
    
    //        for (UIImage * img in _images) {
    //
    //
    //        }
    //
    //
    //        for (NSInteger i  = 0; i < _images.count; i ++) {
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
