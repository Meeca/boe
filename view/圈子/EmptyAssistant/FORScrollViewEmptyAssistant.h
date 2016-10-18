//
//  FOREmptyView.h
//  51offer
//
//  Created by XcodeYang on 12/2/15.
//  Copyright © 2015 51offer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FOREmptyAssistantConfiger.h"

@interface FORScrollViewEmptyAssistant : NSObject

@property (nonatomic, strong)   FOREmptyAssistantConfiger *emptyConfiger;
@property (nonatomic, copy)     NSString *emptyBtnTitle;
@property (nonatomic, copy)     void(^emptyBtnActionBlock)();

#pragma mark - ModelConfig

+ (FORScrollViewEmptyAssistant *)emptyWithContentView:(UIScrollView *)contentView
                                        emptyConfiger:(FOREmptyAssistantConfiger *)configer;

+ (FORScrollViewEmptyAssistant *)emptyWithContentView:(UIScrollView *)contentView
                                        emptyConfiger:(FOREmptyAssistantConfiger *)configer
                                        emptyBtnTitle:(NSString *)btnTitle
                                  emptyBtnActionBlock:(void(^)())btnActionBlock;

#pragma mark - BlockConfig

+ (FORScrollViewEmptyAssistant *)emptyWithContentView:(UIScrollView *)contentView
                                        configerBlock:(void (^)(FOREmptyAssistantConfiger *configer))configerBlock;

+ (FORScrollViewEmptyAssistant *)emptyWithContentView:(UIScrollView *)contentView
                                        configerBlock:(void (^)(FOREmptyAssistantConfiger *configer))configerBlock
                                        emptyBtnTitle:(NSString *)btnTitle
                                  emptyBtnActionBlock:(void(^)())btnActionBlock;

@end
