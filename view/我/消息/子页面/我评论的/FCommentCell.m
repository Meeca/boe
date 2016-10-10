//
//  FCommentCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/12.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "FCommentCell.h"

@interface FCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;


@end


@implementation FCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = _iconImageView.width/2;
    _iconImageView.clipsToBounds = YES;

}



//            "c_id": "1",                    //消息id
//            "content": "评论评论",         //评论内容
//            "created_at": "138569875",         //评论时间
//            "type": "1",         //评论分类（1评论作品，2评论话题）
//            "u_id": "1",         //被评论者id
//            "u_name": "boe_152365",         //昵称
//            "image": ".JPG",         //头像
//            "p_id": "作品/话题",         //作品/话题(当type=1时连接到作品详情，为2是连接到话题详情)
//            "title": "作品、话题名称",         //作品/话题名称
//


- (void)setFCommentModel:(FCommentModel *)fCommentModel{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:fCommentModel.image] placeholderImage:nil];
    _nameLab.text = fCommentModel.u_name;
    _timeLab.text = [Tool timestampToString:fCommentModel.created_at Format:@"MM-dd HH:mm"];
    _contentLab.text = fCommentModel.content;
    [_titleBtn setTitle:fCommentModel.title forState:0];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
