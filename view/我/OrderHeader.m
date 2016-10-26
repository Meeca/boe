//
//  OrderHeader.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "OrderHeader.h"

@interface OrderHeader () {
    UIImageView *image;
    UILabel *name;
    UILabel *state;
}

@end

@implementation OrderHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    image = [[UIImageView alloc] initWithFrame:CGRectZero];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:@"切图 20160719-3"];
    [self.contentView addSubview:image];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:name];
    
    state = [[UILabel alloc] initWithFrame:CGRectZero];
    state.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:state];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    OrderInfo *info = self.data;
    
    image.frame = CGRectMake(15, 0, 25, 25);
    image.centerY = self.height/2;
    
    name.text = info.nike.length>0?info.nike:@" ";
    [name sizeToFit];
    name.x = image.right+8;
    name.centerY = self.height/2;
    
    state.textColor = KAPPCOLOR;
    
//    if([info.types integerValue] == 2){
//        
//        if ([info.state integerValue]==0) {  //未支付
//            state.text = @"等待付款";
//        } else if ([info.state integerValue]==1) {  //已支付
//            state.text = @"等待发货";
//        } else if ([info.state integerValue]==2) {  //未发货
//            state.text = @"等待发货";
//        } else if ([info.state integerValue]==3) {  //已发货
//            state.text = @"待确认收货";
//        } else if ([info.state integerValue]==4) {  //确认收货
//            state.text = @"已完成";
//            state.textColor = [UIColor blackColor];
//        }
//    
//    }else{
//    
//
//    
//        
//        
//        
//        if ([info.state integerValue]==0) {  //未支付
//            state.text = @"等待付款";
//        }
//        //        else if ([info.state integerValue]==1) {  //已支付
//        //            state.text = @"等待发货";
//        //        } else if ([info.state integerValue]==2) {  //未发货
//        //            state.text = @"等待发货";
//        //        } else if ([info.state integerValue]==3) {  //已发货
//        //            state.text = @"待确认收货";
//        //        }
//        else{
//            
//            //            if ([info.state integerValue]==4) {  //确认收货
//            state.text = @"已完成";
//            state.textColor = [UIColor blackColor];
//        }
//
//    }
    
    CGFloat  nowTime = [NSDate  timeStamp];

    
    if ([info.types integerValue] == 1) {
        
        if ([info.state integerValue]==0) {  //未支付
            
             if (nowTime  -  [info.created_at floatValue] > (60*30) ) {
                state.text = @"订单失败";
            }else{
                state.text = @"等待付款";
                
            }

        }
        else if ([info.state integerValue]==1) {  //已支付
            state.text = @"已支付";
        } else if ([info.state integerValue]==2) {  //未发货
            state.text = @"已完成";
        }
        
    }else{
        
        if ([info.state integerValue]==0) {  //未支付

            if (nowTime  -  [info.created_at floatValue] > (60*30) ) {
                state.text = @"订单失败";
            }else{
                state.text = @"等待付款";
                
            }

        
        } else if ([info.state integerValue]==1) {  //已支付
            state.text = @"等待发货";
        } else if ([info.state integerValue]==2) {  //未发货
            state.text = @"等待发货";
        } else if ([info.state integerValue]==3) {  //已发货
            state.text = @"待确认收货";
        } else if ([info.state integerValue]==4) {  //确认收货
            state.text = @"已完成";
            state.textColor = [UIColor blackColor];
        }
        
        
    }
    
    [state sizeToFit];
    state.right = self.width-15;
    state.centerY = self.height/2;
    
    name.width = XMGScreenW - name.left - state.width - 8 - 5;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
