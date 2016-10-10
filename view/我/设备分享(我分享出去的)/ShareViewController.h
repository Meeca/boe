//
//  ShareViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/4.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

// 设备id
@property (nonatomic, strong) NSString *eId;
@property (nonatomic, strong) NSString *macId;

@property (nonatomic, strong) ShareToEquipObj *equip;

@end
