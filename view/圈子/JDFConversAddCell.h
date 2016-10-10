//
//  JDFConversAddCell.h
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/27.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JDFConversAddCellBlock)(UIButton *button);

@interface JDFConversAddCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, copy) JDFConversAddCellBlock block;

@end
