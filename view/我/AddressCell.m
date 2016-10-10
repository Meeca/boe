//
//  AddressCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/9.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "AddressCell.h"

#define  SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define AUTOLAYOUTSIZE(size) ((size) * (SCREENWIDTH / 375))

#import "Masonry.h"

@interface AddressCell () {
    UILabel *name;
    UILabel *number;
    UILabel *address;
    UILabel *line;
    UIButton *home;
    UIButton *edit;
    UIButton *del;
    
    void(^homeBlock)(AddressInfo *info);
    void(^delBlock)(AddressInfo *info);
    void(^editBlock)(AddressInfo *info);
}

@end

@implementation AddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont boldSystemFontOfSize:AUTOLAYOUTSIZE(18)];
    name.textColor = [UIColor blackColor];
    [self.contentView addSubview:name];
    
    number = [[UILabel alloc] initWithFrame:CGRectZero];
    number.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    number.textColor = [UIColor blackColor];
    [self.contentView addSubview:number];
    
    address = [[UILabel alloc] initWithFrame:CGRectZero];
    address.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    address.textColor = [UIColor grayColor];
//    address.numberOfLines = 0;
    [self.contentView addSubview:address];
    
    line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    home = [UIButton buttonWithType:UIButtonTypeCustom];
    home.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    [home setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [home addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:home];
    
    edit = [UIButton buttonWithType:UIButtonTypeCustom];
    edit.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    [edit setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(editModelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:edit];
    
    del = [UIButton buttonWithType:UIButtonTypeCustom];
    del.titleLabel.font = [UIFont systemFontOfSize:AUTOLAYOUTSIZE(15)];
    [del setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [del addTarget:self action:@selector(delModeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:del];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    AddressInfo *info = self.data;
    
    name.text = info.name.length>0?info.name:@"无昵称";
    [name sizeToFit];
    name.x = 15;
    name.y = 15;
    
    number.text = info.tel.length>0?info.tel:@"  ";
    [number sizeToFit];
    number.right = self.width - name.x;
    number.centerY = name.centerY;
    
    address.text = info.address.length>0?info.address:@"  ";
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(15);
        make.left.offset(name.x);
        make.right.offset(- name.x);
    }];
//    address.top = name.bottom+15;
//    address.right = self.right + 50;
//    address.x = name.x;
//    [address sizeToFit];
    
    line.frame = CGRectMake(15, address.bottom+15, self.width, .5);
    
    [home setTitle:@"默认地址" forState:UIControlStateNormal];
    if ([info.home integerValue]==1) {
        [home setImage:[UIImage imageNamed:@"未标题-1-2"] forState:UIControlStateNormal];
    } else {
        [home setImage:[UIImage imageNamed:@"未标题-1-1"] forState:UIControlStateNormal];
    }
    [home.titleLabel sizeToFit];
    home.frame = CGRectMake(name.x, line.bottom, home.titleLabel.width+25, 40);
    [home setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    
    [del setTitle:@"删除" forState:UIControlStateNormal];
    [del setImage:[UIImage imageNamed:@"APP20160727-10"] forState:UIControlStateNormal];
    [del.titleLabel sizeToFit];
    del.frame = CGRectMake(0, line.bottom, del.titleLabel.width+35, home.height);
    del.right = self.width-name.x;

    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit setImage:[UIImage imageNamed:@"APP20160727-9"] forState:UIControlStateNormal];
    [edit.titleLabel sizeToFit];
    edit.frame = CGRectMake(0, line.bottom, edit.titleLabel.width+35, home.height);
    edit.right = del.left-15;
    
    self.height = edit.bottom;
    
}

- (void)homeAction:(UIButton *)btn {
    AddressInfo *info = self.data;
    if ([info.home integerValue]==1) {
        return;
    }
    if (homeBlock) {
        homeBlock(info);
    }
}

- (void)editModelAction:(UIButton *)btn {
    AddressInfo *info = self.data;
    
    if (editBlock) {
        editBlock(info);
    }
}

- (void)delModeAction:(UIButton *)btn {
    AddressInfo *info = self.data;
    
    BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:@"提示" message:@"您确定删除地址" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
        if (index == 1) {
            if (delBlock) {
                delBlock(info);
            }
        }
    } otherButtonTitles:@"确定"];

    [alert show];
}

- (void)deftAction:(void(^)(AddressInfo *info))homeb {
    homeBlock = [homeb copy];
}

- (void)editAction:(void(^)(AddressInfo *info))edib {
    editBlock = [edib copy];
}

- (void)delAction:(void(^)(AddressInfo *info))delb {
    delBlock = [delb copy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
