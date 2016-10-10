//
//  CreatCircleTableViewController.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreatCircleTableViewController : UITableViewController

//- (void)addToucheEvent:(UITapGestureRecognizer *)tap;
//@property (nonatomic, strong) JDFCircleModel *circle;


@property (nonatomic, assign) NSInteger type;// 1 新建  2  修改

@property (nonatomic, copy) NSString * c_id;// 圈子id

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *attribute;// 是否公开
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *againPassword;
@property (nonatomic, strong)NSString *product;
//@property (nonatomic, assign)NSInteger attribute;

@end
