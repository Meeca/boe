//
//  HomeCellView.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/9.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "HomeCellView.h"

@interface HomeCellView () {
    UIImageView *imgView;
    UIImageView *tras;
    UILabel *name;
    UIView *header;
    UIImageView *icon;
    UILabel *user;
    UILabel *year;
    UILabel *cla;
    UIButton *zan;
}

@end

@implementation HomeCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self _initView];
    }
    return self;
}

- (void)_initView {
    imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self.contentView addSubview:imgView];
    
    tras = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *image = [UIImage imageNamed:@"B-16-2"];
    [image stretchableImageWithLeftCapWidth:4 topCapHeight:2];
    tras.image = image;
    [self.contentView addSubview:tras];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont boldSystemFontOfSize:18];
    [tras addSubview:name];
    
    header = [[UIView alloc] initWithFrame:CGRectZero];
    header.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:header];
    
    CGFloat iconWidth = 40;
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-iconWidth)/2, iconWidth, iconWidth)];
    icon.layer.cornerRadius = iconWidth/2;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.backgroundColor = KAPPCOLOR;
    [header addSubview:icon];
    
    user = [[UILabel alloc] initWithFrame:CGRectZero];
    user.font = [UIFont systemFontOfSize:15];
    [header addSubview:user];
    
    year = [[UILabel alloc] initWithFrame:CGRectZero];
    year.font = [UIFont systemFontOfSize:13];
    year.textColor = [UIColor grayColor];
    [header addSubview:year];
    
    cla = [[UILabel alloc] initWithFrame:CGRectZero];
    cla.font = [UIFont systemFontOfSize:13];
    cla.textColor = [UIColor grayColor];
    [header addSubview:cla];
    
    zan = [UIButton buttonWithType:UIButtonTypeCustom];
    zan.frame = CGRectMake(0, 0, 100, 40);
    zan.titleLabel.font = [UIFont systemFontOfSize:14];
    [zan setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [zan addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:zan];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    HomeIndex *f = self.data;
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:f.image] placeholderImage:KZHANWEI];
    imgView.frame = CGRectMake(0, 0, self.width, self.height-60);
    
    tras.frame = CGRectMake(0, 0, self.width, 44);
    tras.bottom = imgView.bottom;
    
    name.text = f.title.length>0?f.title:@"未知";
    name.frame = CGRectMake(15, 0, self.width-30, 44);
    
    header.frame = CGRectMake(0, 0, self.width, 60);
    header.top = imgView.bottom;
    
    [icon sd_setImageWithURL:[NSURL URLWithString:f.u_image] placeholderImage:KZHANWEI];
    
    user.text = f.u_name;
    [user sizeToFit];
    user.top = icon.top;
    user.x = icon.right + 15;
    
    [zan setImage:[UIImage imageNamed:@"B-12"] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"B-13"] forState:UIControlStateSelected];
    [zan setTitle:f.coll_nums forState:UIControlStateNormal];
    zan.selected = f.collection.integerValue == 1;
    [zan sizeToFit];
    zan.width += 20;
    zan.height += 5;
    [zan setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 6)];
    [zan setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    zan.centerY = user.centerY;
    zan.right = self.width - 10;

    year.text = f.years;
    [year sizeToFit];
    year.x = icon.right + 15;
    year.top = user.bottom + 5;
    
    cla.text = f.theme;
    [cla sizeToFit];
    cla.x = year.right + 10;
    cla.top = user.bottom + 5;
}

- (void)zanClick:(UIButton *)button
{
    
    button.selected = !button.isSelected;
    
    HomeIndex *f = self.data;
    
    if (button.isSelected)
    {
        f.coll_nums = [NSString stringWithFormat:@"%ld", f.coll_nums.integerValue + 1];

    }
    else
    {
        f.coll_nums = [NSString stringWithFormat:@"%ld", f.coll_nums.integerValue - 1];
    }
    
    [zan setTitle:f.coll_nums forState:UIControlStateNormal];
    
    
    
    NSString *path;
    
    if (button.isSelected)
    {
        path = @"/app.php/Index/zambia_add";
    }
    else
    {
        path = @"/app.php/Index/zambia_del";
    }
    
    NSDictionary *params = @{
                             @"uid":kUserId,
                             @"p_id":f.p_id,
                             @"type" : @"1"
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         
         
         
     } fail:^(NSString *error) {
         
     }];

}

@end
