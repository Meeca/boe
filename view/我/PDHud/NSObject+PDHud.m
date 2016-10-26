//
//  NSObject+PDHud.m
//  QiXiaoFuProject
//
//  Created by mac on 16/9/11.
//  Copyright © 2016年 fhj. All rights reserved.
//

#import "NSObject+PDHud.h"
#import "SVProgressHUD.h"
#import "PDHud.h"


@implementation NSObject (PDHud)


- (void)showText:(NSString *)aText
{
    [PDHud showWithStatus:aText];
}

- (void)showErrorText:(NSString *)aText
{
    if(aText.length != 0){

        [PDHud showErrorWithStatus:aText];
    }
}

- (void)showSuccessText:(NSString *)aText
{
    if(aText.length != 0){
    
        [PDHud showSuccessWithStatus:aText];
    }
}

- (void)showLoading
{
    [PDHud show];
}


- (void)dismissLoading
{
    [PDHud dismiss];
}

- (void)showProgress:(NSInteger)progress
{
    if (progress == 100) {
        [self dismissLoading];
    }else{
        [PDHud showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
    }
    
}

- (void)showImage:(UIImage*)image text:(NSString*)aText
{
    [PDHud showImage:image status:aText];
}

- (void)showBottomText:(NSString *)aText{
    [self hidenImage];
    
//    CGFloat height = kScreenHeight/2-49 - 50;
    
    [PDHud setOffsetFromCenter:UIOffsetMake(0, 200)];
    [PDHud showWithStatus:aText];
}

- (void)showTopText:(NSString *)aText{
    [self hidenImage];
    [PDHud setOffsetFromCenter:UIOffsetMake(0, -200)];
    [PDHud showWithStatus:aText];
}


- (void)hidenImage{

    [PDHud setSuccessImage:nil];
    [PDHud setInfoImage:nil];
    [PDHud setErrorImage:nil];

}


@end
