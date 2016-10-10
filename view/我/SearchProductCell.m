//
//  SearchArtCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "SearchProductCell.h"
#import "JDFProduct.h"

@interface SearchProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end

@implementation SearchProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setProduct:(JDFProduct *)product
{
    _product = product;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.image]];
    
}

@end
