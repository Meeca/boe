//
//  PrivateMessageCell.m
//  jingdongfang
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "PrivateMessageCell.h"

@interface PrivateMessageCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *numlab;


@end


@implementation PrivateMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 这三句代码可以代替- (void)setSelected:(BOOL)selected animated:(BOOL)animated
    UIView *view = [[UIView alloc] initWithFrame:self.multipleSelectionBackgroundView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = view;
    // 这个属性是编辑的时候最右边的accessory样式
    //    self.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    
    
    _numlab.backgroundColor = [UIColor redColor];
    _numlab.layer.cornerRadius = _numlab.width/2;
    _numlab.clipsToBounds = YES;
    
    _iconImageView.layer.cornerRadius = _iconImageView.width/2;
    _iconImageView.clipsToBounds = YES;
    
    // Initialization code
}


- (void)setSiXinModel:(SiXinModel *)siXinModel{


    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:siXinModel.image] placeholderImage:nil];
    _nameLab.text = siXinModel.name;
//    _nameLab.text = @"这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试";
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
    
    
    [_nameLab sizeToFit];
    if (_nameLab.right > _timeLab.left-10) {
        _nameLab.width = _timeLab.left-10-_nameLab.left;
    }
}

@end
