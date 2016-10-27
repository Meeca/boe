//
//  PrivateMTableViewCell.m
//  jingdongfang
//
//  Created by yons on 16/10/18.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PrivateMTableViewCell.h"

@interface PrivateMTableViewCell ()

@property (strong, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *contentLab;
@property (strong, nonatomic) UILabel *timeLab;
@property (strong, nonatomic) UILabel *numlab;

@end

@implementation PrivateMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 这三句代码可以代替- (void)setSelected:(BOOL)selected animated:(BOOL)animated
        UIView *view = [[UIView alloc] initWithFrame:self.multipleSelectionBackgroundView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = view;
        // 这个属性是编辑的时候最右边的accessory样式
        //    self.editingAccessoryType = UITableViewCellAccessoryCheckmark;
        
        [self _initView];
    }
    return self;
}

- (void)_initView {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_iconImageView];
    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLab];
    
    _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_contentLab];
    
    _timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLab];
    
    _numlab = [[UILabel alloc] initWithFrame:CGRectZero];
    _numlab.textColor = [UIColor whiteColor];
    _numlab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_numlab];
    
}

- (void)setSiXinModel:(SiXinModel *)siXinModel{
    
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:siXinModel.image] placeholderImage:nil];
    _iconImageView.backgroundColor = [UIColor orangeColor];
    _nameLab.text = siXinModel.name;
    _contentLab.text = siXinModel.title;
    _timeLab.text = [Tool timestampToString:siXinModel.times Format:@"MM月dd日 HH:mm"];
    
    
 
    
    if(siXinModel.count != 0){
        _numlab.text = [NSString stringWithFormat:@"%ld",siXinModel.count];;
        _numlab.hidden = NO;
    }else{
        _numlab.hidden = YES;
    }
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        if (selected) {
            // 取消多选时cell成蓝色
            //            self.contentView.backgroundColor = [UIColor whiteColor];
            //            self.backgroundView.backgroundColor = [UIColor whiteColor];
            
        }else{
            
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (editing) {
        for (UIControl *control in self.subviews){
            if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
                for (UIView *v in control.subviews)
                {
                    if ([v isKindOfClass: [UIImageView class]]) {
                        UIImageView *img=(UIImageView *)v;
                        
                        img.image = [UIImage imageNamed:@"choose_n"];
                    }
                }
            }
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //    self.selected = NO;
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"choose_s"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"choose_n"];
                    }
                }
            }
        }
    }
    
    _iconImageView.frame = CGRectMake(10, 10, 40, 40);
    _iconImageView.centerY = self.height/2;
    
    [_nameLab sizeToFit];
    _nameLab.left = _iconImageView.right + 10;
    _nameLab.top = _iconImageView.top;
    
    [_contentLab sizeToFit];
    _contentLab.bottom = _iconImageView.bottom;
    _contentLab.right = KSCREENWIDTH-10;
    _contentLab.left = _iconImageView.right + 10;
    _contentLab.width = KSCREENWIDTH -10 - _iconImageView.right - 10;
    [_timeLab sizeToFit];
    _timeLab.centerY = _nameLab.centerY;
    _timeLab.right = self.width - 10;
    
    
    _numlab.frame = CGRectMake(0, 0, 16, 16);
    _numlab.top = _iconImageView.top;
    
    
    
    _numlab.right = _iconImageView.right + 8;
    
    _numlab.backgroundColor = [UIColor redColor];
    _numlab.layer.cornerRadius = _numlab.width/2;
    _numlab.layer.masksToBounds = YES;
    _numlab.textAlignment = NSTextAlignmentCenter;
    
    
    _iconImageView.layer.cornerRadius = _iconImageView.width/2;
    _iconImageView.layer.masksToBounds = YES;
    [_nameLab sizeToFit];
    if (_nameLab.right > _timeLab.left-10) {
        _nameLab.width = _timeLab.left-10-_nameLab.left;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
