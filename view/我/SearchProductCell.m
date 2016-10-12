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
    self.productImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    [self.productImageView addGestureRecognizer:tap];
}

- (void)tap {
    if (self.tapAction) {
        self.tapAction(_product);
    }
}

-(void)setProduct:(JDFProduct *)product
{
    _product = product;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.image]];
    
}

@end
