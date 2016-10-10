//
//  MingRenSlider.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/2.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "MingRenSlider.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin = 30.0f;
static const CGFloat kFontSizeOfTabButton = 15.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation MingRenSlider

#pragma mark - 初始化参数

- (void)initValues
{
    //创建顶部可滑动的tab
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    self.topScrollView.delegate = self;
    self.topScrollView.backgroundColor = [UIColor whiteColor];
    self.topScrollView.pagingEnabled = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.topScrollView];
    self.userSelectedChannelID = 100;
    
    //创建主滚动视图
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    self.rootScrollView.delegate = self;
    self.rootScrollView.pagingEnabled = YES;
    self.rootScrollView.userInteractionEnabled = YES;
    self.rootScrollView.bounces = NO;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    self.rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.userContentOffsetX = 0;
    [self.rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:self.rootScrollView];
    [self bringSubviewToFront:self.topScrollView];
    self.viewArray = [[NSMutableArray alloc] init];
    
    self.isBuildUI = NO;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    self.rigthSideButton = rigthSideButton;
    [self addSubview:self.rigthSideButton];
    
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (self.isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            self.rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                    self.rigthSideButton.bounds.size.width, self.topScrollView.bounds.size.height);
            
            self.topScrollView.frame = CGRectMake(0, 0,
                                                  self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        self.rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [self.viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [self.viewArray count]; i++) {
            UIViewController *listVC = self.viewArray[i];
            listVC.view.frame = CGRectMake(0+self.rootScrollView.bounds.size.width*i, 0,
                                           self.rootScrollView.bounds.size.width, self.rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [self.rootScrollView setContentOffset:CGPointMake((self.userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
//        UIButton *button = (UIButton *)[self.topScrollView viewWithTag:self.userSelectedChannelID];
//        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [self.viewArray addObject:vc];
        [self.rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:self.userSelectedChannelID - 100];
    }
    
    self.isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    
    self.shadowImageView = [[UIImageView alloc] init];
    [self.shadowImageView setImage:self.shadowImage];
    self.shadowImageView.backgroundColor = self.tabItemSelectedColor;
    [self.topScrollView addSubview:self.shadowImageView];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = 0;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    for (int i = 0; i < [self.viewArray count]; i++) {
        UIViewController *vc = self.viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(self.topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        //累计每个tab文字的长度
        topScrollViewContentWidth += kWidthOfButtonMargin+textSize.width;
        //设置按钮尺寸
//        [button setFrame:CGRectMake(xOffset, 0, textSize.width, kHeightOfTopScrollView)];
        [button setFrame:CGRectMake(KSCREENWIDTH/4*i, 0, KSCREENWIDTH/4, kHeightOfTopScrollView)];
        //        button.backgroundColor = [UIColor grayColor];
        //计算下一个tab的x偏移量
        xOffset += textSize.width + kWidthOfButtonMargin;
        [button setTag:i+100];
        if (i == 0) {
            self.shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, button.height-2, button.width-10, 2);
            //            self.shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, 0, textSize.width, self.shadowImage.size.height);
            self.shadowImageView.centerX = button.centerX;
            button.selected = YES;
        }
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:button];
    }
    
    //设置顶部滚动视图的内容总尺寸
//    self.topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth+kWidthOfButtonMargin, kHeightOfTopScrollView);
    
    //加条线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView-0.5, KSCREENWIDTH, 0.5)];
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView-0.5, topScrollViewContentWidth+kWidthOfButtonMargin, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.topScrollView addSubview:line];
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
//    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != self.userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self.topScrollView viewWithTag:self.userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        self.userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
//            [self.shadowImageView setFrame:CGRectMake(sender.frame.origin.x, sender.height-2, sender.frame.size.width+20, 2)];
            //            [self.shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, self.shadowImage.size.height)];
            self.shadowImageView.centerX = sender.centerX;
        } completion:^(BOOL finished) {
            
            //设置新页出现
            if (!self.isRootScroll) {
                [self.rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
            }
            self.isRootScroll = NO;
            
            if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:self.userSelectedChannelID - 100];
            }
            
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

// 设置选中  页面
- (void)selectIndex:(NSInteger)index {
    
    index += 100;
    //要选中的按钮
    UIButton *currentButton = (UIButton *)[self.topScrollView viewWithTag:index];
    
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
//    [self adjustScrollViewContentX:currentButton];
    
    //如果更换按钮
    if (index != self.userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self.topScrollView viewWithTag:self.userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        self.userSelectedChannelID = index;
    }
    
    //按钮选中状态
    if (!currentButton.selected) {
        currentButton.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
//            [self.shadowImageView setFrame:CGRectMake(currentButton.frame.origin.x, currentButton.height-2, currentButton.frame.size.width+20, 2)];
            
            //            [self.shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, self.shadowImage.size.height)];
            self.shadowImageView.centerX = currentButton.centerX;
        } completion:^(BOOL finished) {
            //设置新页出现
            if (!self.isRootScroll) {
                [self.rootScrollView setContentOffset:CGPointMake((currentButton.tag - 100)*self.bounds.size.width, 0) animated:YES];
            }
            self.isRootScroll = NO;
            
            if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:self.userSelectedChannelID - 100];
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - self.topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [self.topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (self.topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - self.topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [self.topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        self.userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (self.userContentOffsetX < scrollView.contentOffset.x) {
            self.isLeftScroll = YES;
        }
        else {
            self.isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        self.isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width + 100;
        UIButton *button = (UIButton *)[self.topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(self.rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(self.rootScrollView.contentOffset.x >= self.rootScrollView.contentSize.width - self.rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
