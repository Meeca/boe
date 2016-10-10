//
//  SearchHotKeyCell.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/9/4.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "SearchHotKeyCell.h"
#import "JDFSearchHotKeyModel.h"

@implementation SearchHotKeyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSearchHotModel:(JDFSearchHotKeyModel *)searchHotModel
{
    _searchHotModel = searchHotModel;
    
    self.searchLabel.text = [NSString stringWithFormat:@"%@",searchHotModel.title];


}
- (IBAction)SearchBtnClick:(id)sender
{
    if (self.block)
    {
        self.block(self.searchHotModel);
    }
}

@end
