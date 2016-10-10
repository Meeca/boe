//
//  JHCell.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCell.h"
#import "JDFClassificationModel.h"

@implementation JHCell

- (void)setSearchHotModel:(JDFClassificationModel *)searchHotModel
{
    _searchHotModel = searchHotModel;
    self.textLabel.text = [NSString stringWithFormat:@"%@",searchHotModel.title];

}
@end
