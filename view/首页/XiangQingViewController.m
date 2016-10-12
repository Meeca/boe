//
//  XiangQingViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/7.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "XiangQingViewController.h"
#import "HomeModel.h"
#import "PushPhoto.h"
#import "BaseModel.h"
#import "FindCollectionViewCell.h"
#import "BuyCllowerViewController.h"
#import "BuyZViewController.h"
#import "ShangViewController.h"
#import "CommentCell.h"
#import "IWTextView.h"
#import "WeiXinPayManager.h"
#import "AliPayManager.h"
#import "UIViewController+MBShow.h"
#import "ArtGalleryViewController.h"
#import "DBHCommentCellTableViewCell.h"
#import "IntroViewController.h"
#import "TLChatViewController.h"
#import "YXScrollowActionSheet.h"
#import "ShareModel.h"
#import "UIImage+MJ.h"

static NSString * const kCommentCellTableViewCellIdentifier = @"kCommentCellTableViewCellIdentifier";

@interface XiangQingViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextViewDelegate,YXScrollowActionSheetDelegate> {
    UIImageView *picture;
    
    UIButton *backBtn;
    CGFloat contextHeight;
    
    CGFloat inset;
    
    HomeModel *homeModel;
    BaseModel *baseModel;
    DetailsInfo * detailsInfo;
    
    NSString *comment;
    
    UIView *imView;
    CGRect selRect;
    CGFloat currtOff;
    UIView *nav;
    
    BOOL isTop;
    
    UIImage * _shareImage;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, assign) BOOL isRecomment;
@property (nonatomic, strong) NSString *commentId;

@end

@implementation XiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    homeModel = [HomeModel modelWithObserver:self];
    baseModel = [BaseModel modelWithObserver:self];

    UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
    push.frame = CGRectMake(0, 0, KSCREENWIDTH, 44);
    push.backgroundColor = KAPPCOLOR;
    [push setTitle:@"推送到Gallery" forState:UIControlStateNormal];
    [push setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [push addTarget:self action:@selector(pushPhoto:) forControlEvents:UIControlEventTouchUpInside];
    push.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:push];
    push.bottom = KSCREENHEIGHT;
    
    nav = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KSCREENWIDTH, 44)];
    nav.backgroundColor = [UIColor whiteColor];
    nav.alpha = 0.f;
    [self.view addSubview:nav];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont systemFontOfSize:16];
    title.tag = 393;
    [nav addSubview:title];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nav.width, .5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [nav addSubview:line];
    line.bottom = nav.height;
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"A-sousuo-1"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0, 20, 44, 44);
    [share setImage:[UIImage imageNamed:@"A-fenxiang-1"] forState:UIControlStateNormal];
    [share setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    share.right=KSCREENWIDTH-5;
    
    [self.table registerClass:[DBHCommentCellTableViewCell class] forCellReuseIdentifier:kCommentCellTableViewCellIdentifier];
    
    [self.table setContentInset:UIEdgeInsetsMake(0, 0, push.height, 0)];
    [self.table setScrollIndicatorInsets:self.table.contentInset];
    
    [self picture];
    [self addHeader];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _dataArray = [NSMutableArray new];
  
}


- (void)addHeader {
    [homeModel app_php_Index_read:self.p_id];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [homeModel app_php_Index_read:self.p_id];
    }];
}

ON_SIGNAL3(HomeModel, INDEXREAD, signal) {
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
    detailsInfo = signal.object;
    
    
    [UIImage loadImageWithUrl:detailsInfo.image returnImage:^(UIImage *image) {
        _shareImage = image;
    }];
    
    
    [picture sd_setImageWithURL:[NSURL URLWithString:detailsInfo.image] placeholderImage:KZHANWEI];
    [self.table reloadData];
    
    UILabel *title = [nav viewWithTag:393];
    title.text = detailsInfo.title.length>0?detailsInfo.title:@"";
    [title sizeToFit];
    title.center = CGPointMake(nav.width/2, nav.height/2);
}



ON_SIGNAL3(BaseModel, EQUIPMENTLIST, signal) {
    [_dataArray removeAllObjects];
    NSArray *dataArr = signal.object;
    for (id obj in dataArr) {
        [_dataArray addObject:obj];
    }
    [baseModel app_php_Share_User_equipment_list];
}



ON_SIGNAL3(BaseModel, SHAREEQUIPMENTLIST, signal) {
    NSArray *dataArra = signal.object;
    
    for (id obj in dataArra) {
        [_dataArray addObject:obj];
    }

    if (_dataArray.count>1) {
        PushPhoto *view = [[PushPhoto alloc] initWithFrame:CGRectMake(0, 20, KSCREENWIDTH, KSCREENHEIGHT-20)];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
        view.x = KSCREENWIDTH;
        view.info = detailsInfo;
        view.dataArr = _dataArray;
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win addSubview:view];
        
        [UIView animateWithDuration:.3 animations:^{
            view.x = 0;
        }];
    } else {
        if (_dataArray.count==1) {
            EquipmentList *list = _dataArray[0];
            [baseModel app_php_Jpush_indexWithP_id:detailsInfo.p_id e_id:list.e_id type:@"1" pay_type:detailsInfo.pay_type];
        } else {
            [self presentMessageTips:@"请先绑定设备"];
        }
    }
}


ON_SIGNAL3(BaseModel, COMMENTADD, signal) {
    [homeModel app_php_Index_read:self.p_id];
}

- (void)picture {
    picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH*1080/1920)];
    picture.backgroundColor = [UIColor lightGrayColor];
    picture.contentMode = UIViewContentModeScaleAspectFit;
    picture.userInteractionEnabled = YES;
    [self.table addSubview:picture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [picture addGestureRecognizer:tap];
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.table) {
        if (scrollView.contentOffset.y <= 200) {
            nav.alpha = scrollView.contentOffset.y/200;
        } else {
            if (nav.alpha != 1) {
                nav.alpha = 1;
            }
        }
    }
}

- (void)tapAct {
    IntroViewController *vc = [[IntroViewController alloc] init];
    vc.u_id = detailsInfo.u_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat x = cell.separatorInset.left;
    UIFont *font = [UIFont systemFontOfSize:15];
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.section==1) {
        CGFloat heght;
        
        UILabel *pictureName = [[UILabel alloc] initWithFrame:CGRectMake(x, 8, 0, 0)];
        pictureName.text = detailsInfo.title;
        pictureName.font = [UIFont boldSystemFontOfSize:25];
        [pictureName sizeToFit];
        [cell.contentView addSubview:pictureName];
        
        NSString *count = detailsInfo.zambia_nums.length>0?detailsInfo.zambia_nums:@"0";
        
        UIButton *zan = [UIButton buttonWithType:UIButtonTypeCustom];
        zan.frame = CGRectMake(0, 0, 100, 40);
        
        [zan setImage:[UIImage imageNamed:@"B-12"] forState:UIControlStateNormal];
        [zan setImage:[UIImage imageNamed:@"B-13"] forState:UIControlStateSelected];
        zan.selected = [detailsInfo.zambia integerValue]!=0;
        [zan setTitle:count forState:UIControlStateNormal];
        zan.titleLabel.font = [UIFont systemFontOfSize:14];
        [zan setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:zan];
        [zan addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
        [zan sizeToFit];
        zan.width += 20;
        zan.height += 10;
        [zan setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 6)];
        [zan setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        zan.top = pictureName.top;
        zan.right = KSCREENWIDTH - x;
        
        NSArray *arr = @[detailsInfo.years?:@"", detailsInfo.classs?:@""];
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(x, pictureName.bottom + 8, 0, 0)];
        time.text = [arr componentsJoinedByString:@"  "];
        time.font = font;
        [time sizeToFit];
        [cell.contentView addSubview:time];
        
        NSString *text = detailsInfo.content;
        UILabel *context = [[UILabel alloc] initWithFrame:CGRectMake(x, time.bottom + 8, KSCREENWIDTH-x*2, 0)];
        context.numberOfLines = 0;
        context.text = text;
        context.textColor = [UIColor grayColor];
        context.font = font;
        [cell.contentView addSubview:context];
        CGSize size = [Tool getLabelSizeWithText:text AndWidth:context.width AndFont:font attribute:nil];
        context.height = size.height;
        
        heght = context.bottom + 15;

        NSArray *biaoQian = [detailsInfo.theme componentsSeparatedByString:@" "];
        CGFloat bQX = x;
        CGFloat bQY = context.bottom + 15;
        for (int i=0; i<biaoQian.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bQX, bQY, 0, 0)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.text = biaoQian[i];
            label.backgroundColor = RGB(234, 234, 234);
            [cell.contentView addSubview:label];
            [label sizeToFit];
            label.width+=28;
            label.height+=10;
            
            if (label.right>(KSCREENWIDTH-x)) {
                label.x = x;
                label.y = label.bottom + 13;
            }
            
            bQX = label.right+15;
            bQY = label.y;
            
            heght = label.bottom + 15;
        }
        
        if (contextHeight != heght) {
            contextHeight = heght;
            [tableView reloadData];
        }
        
        if (pictureName.right > zan.left) {
            pictureName.width = zan.left - 5 - pictureName.left;
        }
    } else if (indexPath.section==2) {
        cell.clipsToBounds = YES;
        CGFloat iconWidth = 40;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(x, (60-iconWidth)/2, iconWidth, iconWidth)];
        icon.layer.cornerRadius = iconWidth/2;
        icon.layer.masksToBounds = YES;
        icon.backgroundColor = KAPPCOLOR;
        [icon sd_setImageWithURL:[NSURL URLWithString:detailsInfo.u_image] placeholderImage:KZHANWEI];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:icon];
        icon.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];
        [icon addGestureRecognizer:tap];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = font;
        name.text = detailsInfo.u_name;
        [cell.contentView addSubview:name];
        [name sizeToFit];
        name.top = icon.top;
        name.x = icon.right + 15;
        
        UILabel *zuoPin = [[UILabel alloc] initWithFrame:CGRectZero];
        zuoPin.font = [UIFont systemFontOfSize:13];
        zuoPin.text = [NSString stringWithFormat:@"作品 %@",detailsInfo.works_nums ];
        zuoPin.textColor = [UIColor grayColor];
        [cell.contentView addSubview:zuoPin];
        [zuoPin sizeToFit];
        zuoPin.x = icon.right + 15;
        zuoPin.top = name.bottom + 5;
        
        UILabel *fans = [[UILabel alloc] initWithFrame:CGRectZero];
        fans.font = [UIFont systemFontOfSize:13];
        fans.text = [NSString stringWithFormat:@"粉丝 %@",detailsInfo.coll_nums ];
        fans.textColor = [UIColor grayColor];
        [cell.contentView addSubview:fans];
        [fans sizeToFit];
        fans.x = zuoPin.right + 15;
        fans.top = name.bottom + 5;
        
        UIButton *guanzhu = [UIButton buttonWithType:UIButtonTypeCustom];
        guanzhu.frame = CGRectMake(0, -0.5, 61, 61);
        guanzhu.layer.borderWidth = .5;
        guanzhu.titleLabel.font = [UIFont systemFontOfSize:12];
        guanzhu.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5].CGColor;
//        if ([info.collection integerValue]==0) {
            [guanzhu setTitle:@"加关注" forState:UIControlStateNormal];
//        } else if ([info.collection integerValue]==1) {
            [guanzhu setTitle:@"已关注" forState:UIControlStateSelected];
//        }
//        if ([info.collection integerValue] == 0) {
//            
//        }
//        self.praiseButton.selected = ctcrModel.c_zam_type == 2;
        guanzhu.selected = [detailsInfo.collection integerValue]!=0;
        [guanzhu setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
        [guanzhu setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [guanzhu setTitleEdgeInsets:UIEdgeInsetsMake(13, 0, -13, 0)];
        [guanzhu addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:guanzhu];
        guanzhu.right = KSCREENWIDTH+0.5;
        UIImageView *guanzhuImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        guanzhuImage.contentMode = UIViewContentModeScaleAspectFit;
        
        if ([detailsInfo.collection integerValue]==0) {
            guanzhuImage.image = [UIImage imageNamed:@"B-9-3"];
        } else if ([detailsInfo.collection integerValue]==1) {
            guanzhuImage.image = [UIImage imageNamed:@"B-10-3"];
        }
        
        
        [cell.contentView addSubview:guanzhuImage];
        guanzhuImage.center = guanzhu.center;
        guanzhuImage.centerY = guanzhu.centerY - 8;
        
        UIButton *shixin = [UIButton buttonWithType:UIButtonTypeCustom];
        shixin.frame = CGRectMake(0, -0.5, 61, 61);
        shixin.layer.borderWidth = .5;
        shixin.titleLabel.font = [UIFont systemFontOfSize:12];
        shixin.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5].CGColor;
        [shixin setTitle:@"私信" forState:UIControlStateNormal];
        [shixin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [shixin setTitleEdgeInsets:UIEdgeInsetsMake(13, 0, -13, 0)];
        [shixin addTarget:self action:@selector(sixinClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:shixin];
        shixin.right = guanzhu.left+0.5;
        UIImageView *shixinImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        shixinImage.contentMode = UIViewContentModeScaleAspectFit;
        shixinImage.image = [UIImage imageNamed:@"B-11"];
        [cell.contentView addSubview:shixinImage];
        shixinImage.center = shixin.center;
        shixinImage.centerY = shixin.centerY - 8;
        
        if (name.right > shixin.left) {
            name.width = shixin.left - 5 - name.left;
        }
    } else if (indexPath.section==3) {
        if (indexPath.row==0) {
            cell.textLabel.textColor = KAPPCOLOR;
            cell.textLabel.text = [@"￥" stringByAppendingString:detailsInfo.electronic_price.length>0?detailsInfo.electronic_price:@"0"];
            cell.textLabel.hidden = [detailsInfo.price_open isEqualToString:@"2"];
            
            UIButton *xianliang = [UIButton buttonWithType:UIButtonTypeCustom];
            xianliang.frame = CGRectMake(0, 10, 90, 30);
            xianliang.backgroundColor = KAPPCOLOR;
            xianliang.titleLabel.font = [UIFont systemFontOfSize:13];
            [xianliang setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (detailsInfo.pay_type.integerValue == 1)
            {
                [xianliang setTitle:@"已购买" forState:UIControlStateNormal];
                xianliang.userInteractionEnabled = NO;
            }
            else
            {
                [xianliang setTitle:@"限量收藏" forState:UIControlStateNormal];
                xianliang.userInteractionEnabled = YES;
            }
            
            [xianliang addTarget:self action:@selector(xianliangAction:) forControlEvents:UIControlEventTouchUpInside];
            xianliang.layer.masksToBounds = YES;
            xianliang.layer.cornerRadius = 3;
            [cell.contentView addSubview:xianliang];
            xianliang.right = KSCREENWIDTH - x;
            
            UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
            msg.font = [UIFont systemFontOfSize:13];
            msg.textColor = [UIColor grayColor];
            msg.text = [NSString stringWithFormat:@"%@人收藏/%@", detailsInfo.electronics_nume.length>0?detailsInfo.electronics_nume:@"0", detailsInfo.electronic_nums.length>0?detailsInfo.electronic_nums:@"0"];
            if (detailsInfo.electronics_nume >= detailsInfo.electronic_nums )
            {
                xianliang.backgroundColor = [UIColor grayColor];
                xianliang.enabled = NO;
                [xianliang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }
     
            [cell.contentView addSubview:msg];
            [msg sizeToFit];
            msg.center = xianliang.center;
            msg.right = xianliang.left - 10;
        } else if (indexPath.row==1) {
            cell.textLabel.textColor = KAPPCOLOR;
            cell.textLabel.text = [@"￥" stringByAppendingString:detailsInfo.material_price.length>0?detailsInfo.material_price:@"0"];
            cell.textLabel.hidden = [detailsInfo.price_open isEqualToString:@"2"];
            
            UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
            buy.frame = CGRectMake(0, 10, 90, 30);
            buy.titleLabel.font = [UIFont systemFontOfSize:13];
            [buy setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [buy setTitle:@"真品购买" forState:UIControlStateNormal];
            [buy addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
            buy.layer.masksToBounds = YES;
            buy.layer.cornerRadius = 3;
            buy.layer.borderColor = [UIColor grayColor].CGColor;
            buy.layer.borderWidth = 1;
            [cell.contentView addSubview:buy];
            buy.right = KSCREENWIDTH - x;
            
            UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
            msg.font = [UIFont systemFontOfSize:13];
            msg.textColor = [UIColor grayColor];
            msg.text = [NSString stringWithFormat:@"%@件", detailsInfo.material_nums.length>0?detailsInfo.material_nums:@"0"];
            [cell.contentView addSubview:msg];
            [msg sizeToFit];
            msg.center = buy.center;
            msg.right = buy.left - 10;
        } else if (indexPath.row==2) {
            UIButton *shang = [UIButton buttonWithType:UIButtonTypeCustom];
            shang.frame = CGRectMake(0, 10, 90, 30);
            shang.titleLabel.font = [UIFont systemFontOfSize:13];
            [shang setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [shang setTitle:@"打赏" forState:UIControlStateNormal];
            [shang addTarget:self action:@selector(shangAction:) forControlEvents:UIControlEventTouchUpInside];
            shang.layer.masksToBounds = YES;
            shang.layer.cornerRadius = 3;
            shang.layer.borderColor = [UIColor grayColor].CGColor;
            shang.layer.borderWidth = 1;
            [cell.contentView addSubview:shang];
            shang.right = KSCREENWIDTH - x;
            
            UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
            msg.font = [UIFont systemFontOfSize:13];
            msg.textColor = [UIColor grayColor];
            msg.text = [NSString stringWithFormat:@"已有%@人打赏", detailsInfo.reward_nums.length>0?detailsInfo.reward_nums:@"0"];
            [cell.contentView addSubview:msg];
            [msg sizeToFit];
            msg.center = shang.center;
            msg.right = shang.left - 10;
        }
    } else if (indexPath.section==4) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.text = @"猜您喜欢";
        title.font = font;
        [cell.contentView addSubview:title];
        [title sizeToFit];
        title.x = x;
        title.y = 15;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((KSCREENWIDTH-40)/4, (KSCREENWIDTH-40)/4);
        layout.minimumLineSpacing = 2;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, title.bottom, KSCREENWIDTH, (KSCREENWIDTH-40)/4+20) collectionViewLayout:layout];
        collect.delegate = self;
        collect.dataSource = self;
        collect.backgroundColor = [UIColor whiteColor];
        [collect registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"collect"];
        [cell.contentView addSubview:collect];
        
        inset = x;
        [collect reloadData];
    } else if (indexPath.section==5) {
        UIImageView *msg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
        msg.image = [UIImage imageNamed:@"B-14"];
        msg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:msg];
        msg.centerY = h/2;
        
        UILabel *place = [[UILabel alloc] initWithFrame:CGRectZero];
        place.text = @"我来说两句...";
        place.textColor = [UIColor lightGrayColor];
        place.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:place];
        [place sizeToFit];
        place.x = msg.right+5;
        place.height = h;
        
        UIImageView *send = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 50, 50)];
        send.image = [UIImage imageNamed:@"B-15"];
        send.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:send];
        send.right = KSCREENWIDTH;
        send.centerY = h/2;
    } else if (indexPath.section >= 6) {
        if (indexPath.row == 0) {
            CommentCell *comCell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell.h"];
            if (comCell==nil) {
                comCell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CommentCell.h"];
                comCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            comCell.data = detailsInfo.comment_list[indexPath.section - 6];
            [comCell setIconAction:^(CommentInfo *model) {
                IntroViewController *vc = [[IntroViewController alloc] init];
                vc.u_id = model.u_id;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }];

            [comCell setNeedsLayout];
            return comCell;
        } else {
            DBHCommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCellTableViewCellIdentifier forIndexPath:indexPath];
            
            CommentInfo *commen = detailsInfo.comment_list[indexPath.section - 6];
            ReCommentInfo *reCommen = commen.r_comment_list[indexPath.row - 1];
            CommentInfo *model = [[CommentInfo alloc] init];
            model.c_id = [reCommen valueForKey:@"r_id"];
            model.content = [reCommen valueForKey:@"title"];
            model.image = [reCommen valueForKey:@"u_image"];
            model.nike = [reCommen valueForKey:@"u_name"];
            model.u_id = [reCommen valueForKey:@"u_id"];
            
            [cell setIconAction:^(CommentInfo *model) {
                IntroViewController *vc = [[IntroViewController alloc] init];
                vc.u_id = model.u_id;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            cell.model = model;
            
            return cell;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 5) {
        if (indexPath.row != 0) {
            return;
        }
        _isRecomment = indexPath.section != 5;
        if (indexPath.section > 5) {
            CommentInfo *commentModel = detailsInfo.comment_list[indexPath.section - 6];
            _commentId = commentModel.c_id;
        }
        
        NSString *placeholder;
        currtOff = tableView.contentOffset.y;
        selRect = [tableView rectForRowAtIndexPath:indexPath];
        if (indexPath.section==5) {
            isTop = YES;
        } else {
            isTop = NO;
            
            CommentInfo *commentInfo = detailsInfo.comment_list[indexPath.row];
            placeholder = [NSString stringWithFormat:@"@%@:",commentInfo.nike];
        }
        NSLog(@"我来说两句 rect:%@", NSStringFromCGRect(selRect));
        if (!imView) {
            imView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, 50)];
            [self.view addSubview:imView];
            imView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *msg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
            msg.image = [UIImage imageNamed:@"B-14"];
            msg.contentMode = UIViewContentModeScaleAspectFit;
            [imView addSubview:msg];
            msg.centerY = imView.height/2;
            
            UIImageView *send = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 50, 50)];
            send.image = [UIImage imageNamed:@"B-15"];
            send.contentMode = UIViewContentModeScaleAspectFit;
            send.userInteractionEnabled = YES;
            [imView addSubview:send];
            send.right = KSCREENWIDTH;
            send.centerY = imView.height/2;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendAcion:)];
            [send addGestureRecognizer:tap];
            
            IWTextView *imText = [[IWTextView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
            imText.width = imView.width-msg.right-5-send.width;
            imText.placeholder = @"我来说两句...";
            imText.contentInset = UIEdgeInsetsMake(7, 0, 7, 0);
            imText.font = [UIFont systemFontOfSize:15];
            imText.delegate = self;
            imText.returnKeyType = UIReturnKeySend;
            imText.tag = 80;
            imText.x = msg.right+5;
            [imView addSubview:imText];
        }
        
        IWTextView *imText = [imView viewWithTag:80];
        if (imText.isFirstResponder) {
            [self check:selRect];
        }
        [imText becomeFirstResponder];
        
        imText.text = placeholder;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6 + detailsInfo.comment_list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else if (section==1) {
        return 1;
    } else if (section==2) {
        return 1;
    } else if (section==3) {
        return 3;
    } else if (section==4) {
        return 1;
    } else if (section==5) {
        return 1;
    } else {
        CommentInfo *model = detailsInfo.comment_list[section - 6];
        return model.r_comment_list.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return KSCREENWIDTH*1080/1920;
    } else if (indexPath.section==1) {
        return contextHeight;
    } else if (indexPath.section==2) {
        return 60;
    } else if (indexPath.section==4) {
        CGFloat h;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.text = @"猜您喜欢";
        title.font = [UIFont systemFontOfSize:15];
        [title sizeToFit];
        h=title.height+15;
        
        h += ((KSCREENWIDTH-40)/4+20);
        
        return h;
    } else if (indexPath.section >= 6) {
        if (indexPath.row == 0) {
            CommentInfo *commen = detailsInfo.comment_list[indexPath.section - 6];
            return [Tool getCommentHeight:commen];
        } else {
            CommentInfo *commen = detailsInfo.comment_list[indexPath.section - 6];
            ReCommentInfo *reCommen = commen.r_comment_list[indexPath.row - 1];
            CommentInfo *model = [[CommentInfo alloc] init];
            model.c_id = [reCommen valueForKey:@"r_id"];
            model.content = [reCommen valueForKey:@"title"];
            model.image = [reCommen valueForKey:@"u_image"];
            model.nike = [reCommen valueForKey:@"u_name"];
            model.u_id = [reCommen valueForKey:@"u_id"];
            return [Tool getCommentHeight:model];
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==2) {
        return 12;
    } else if (section==3) {
        return 12;
    } else if (section==4) {
        return 12;
    } else if (section==5) {
        return 12;
    } else if (section==6) {
        return 1;
    }
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView==self.table) {
        [self.view endEditing:YES];        
    }
}

#pragma mark — UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return detailsInfo.guess_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
    GuessInfo *r = detailsInfo.guess_list[indexPath.item];
    cell.imgUrl = r.image;
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];

    GuessInfo *r = detailsInfo.guess_list[indexPath.item];
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
    vc.p_id = r.p_id;
    vc.isRoot = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, inset, 0, inset);
}

- (void)back {
    [self.view endEditing:YES];

    if (self.isRoot) {
        if ([self.navigationController.viewControllers[1] isKindOfClass:[ArtGalleryViewController class]]) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pushPhoto:(UIButton *)btn {
    [baseModel app_php_User_equipment_list];
}
#pragma  mark ---------分享到qq,微信/..........
- (void)share {
    [self.view endEditing:YES];
    YXScrollowActionSheet *cusSheet = [[YXScrollowActionSheet alloc] init];
    cusSheet.delegate = self;
    NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"}];
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];

    NSLog(@"你点击了分享分享");
    
    
    
    
    
    
    
}
#pragma mark ------分享代理
#pragma mark - YXScrollowActionSheetDelegate
- (void) scrollowActionSheetButtonClick:(YXActionSheetButton *) btn
{
    NSLog(@"第%li个按钮被点击了",(long)btn.tag);
    
    NSInteger index = btn.tag;
    
    [ShareModel shareUMengWithVC:self withPlatform:index withTitle:detailsInfo.title
                    withShareTxt:detailsInfo.content
                       withImage:_shareImage
                          withID:detailsInfo.p_id
                        withType:1 withUrl:nil success:^(NSDictionary *requestDic) {
        
        
        
    } failure:^(NSString *error) {
        
    }];
    
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    [self.view endEditing:YES];

    UIControl *ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 20, KSCREENWIDTH, KSCREENHEIGHT-20)];
    ctrl.backgroundColor = RGB(66, 66, 66);
    [ctrl addTarget:self action:@selector(hiddenCtrl:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:picture.image];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    imgView.layer.borderWidth = 15;
    imgView.layer.masksToBounds = YES;
    [ctrl addSubview:imgView];
    
    if ([detailsInfo.plates integerValue]==1) { // 横屏
        imgView.frame = CGRectMake(0, 0, (KSCREENWIDTH-80)*1920/1080, KSCREENWIDTH-80);
        imgView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    } else {  //竖屏
        imgView.frame = CGRectMake(0, 0, KSCREENWIDTH-80, (KSCREENWIDTH-80)*1920/1080);
    }
    imgView.center = CGPointMake(ctrl.width/2, ctrl.height/2);
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:ctrl];
    ctrl.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        ctrl.alpha = 1;
    }];
}

- (void)hiddenCtrl:(UIControl *)ctrl {
    [UIView animateWithDuration:.3 animations:^{
        ctrl.alpha = 0;
    } completion:^(BOOL finished) {
        [ctrl removeFromSuperview];
    }];
}

- (void)xianliangAction:(UIButton *)btn {
    [self.view endEditing:YES];

    if (detailsInfo.pay_type.integerValue == 1)
    {
        return;
    }
    
    BuyCllowerViewController *vc = [[BuyCllowerViewController alloc] init];
    vc.info = detailsInfo;
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buyAction:(UIButton *)btn {
    [self.view endEditing:YES];

    if(detailsInfo.material_nums.integerValue <= 0)
    {
        [self presentMessageTips:@"库存不足"];
        return;
    }
    
    BuyZViewController *vc = [[BuyZViewController alloc] init];
    vc.info = detailsInfo;
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shangAction:(UIButton *)btn {
    [self.view endEditing:YES];

    ShangViewController *vc = [[ShangViewController alloc] init];
    vc.info = detailsInfo;
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)keyboardChangeFrame:(NSNotification *)not {
    NSLog(@"keyboardChangeFrame:    %@", not.userInfo);
    IWTextView *imText = [imView viewWithTag:80];
    imView.hidden = NO;
    CGRect beg = [not.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect end = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    imView.bottom = beg.origin.y;
    BOOL hid = NO;
    if (end.origin.y==KSCREENHEIGHT) {
        hid = YES;
    }
    [UIView animateWithDuration:[not.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        if (hid) {
            imView.top = end.origin.y;
        } else {
            imView.bottom = end.origin.y;
        }
    } completion:^(BOOL finished) {
        if (!imText.isFirstResponder) {
            imView.hidden = YES;
        }
    }];
}

- (void)keyboardShow:(NSNotification *)not {
    CGRect end = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = end.origin.y-50;
    
    CGFloat value = selRect.origin.y-currtOff;
    
    CGFloat of = h-value;
    [UIView animateWithDuration:.2 animations:^{
        if (isTop) {
            [self.table setContentOffset:CGPointMake(0, currtOff-of)];
        } else {
            [self.table setContentOffset:CGPointMake(0, currtOff-of+selRect.size.height)];
        }
    }];
}

- (void)check:(CGRect)rect {
    CGFloat h = imView.y;
    
    CGFloat value = rect.origin.y-currtOff;
    CGFloat of = h-value;
    [UIView animateWithDuration:.2 animations:^{
        if (isTop) {
            [self.table setContentOffset:CGPointMake(0, currtOff-of)];
        } else {
            [self.table setContentOffset:CGPointMake(0, currtOff-of+selRect.size.height)];
        }
    }];
}

- (void)keyboardHide:(NSNotification *)not {
    [self.table setContentOffset:CGPointMake(0, currtOff)];
}

- (void)sendAcion:(UIGestureRecognizer *)tap {
    
    IWTextView *imText = [imView viewWithTag:80];
    
    if (imText.text.length==0) {
        [self presentMessageTips:@"请输入评论"];
        return;
    }
    
    if (_isRecomment) {
        [baseModel app_php_Index_r_comm_add:self.p_id comm_id:_commentId title:imText.text];
    } else {
        [baseModel app_php_Index_comment_add:self.p_id content:imText.text];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [homeModel app_php_Index_read:self.p_id];
    });
    
    imText.text = nil;
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        
        if (textView.text.length==0) {
            [self presentMessageTips:@"请输入评论"];
            return NO;
        }
        
        [baseModel app_php_Index_comment_add:self.p_id content:textView.text];
        
        textView.text = nil;
        
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zanClick:(UIButton *)button
{
    
    button.selected = !button.isSelected;
    
    DetailsInfo *f = detailsInfo;
    
    if (button.isSelected)
    {
        f.zambia_nums = [NSString stringWithFormat:@"%@", @(f.zambia_nums.integerValue + 1)];
        
    }
    else
    {
        f.zambia_nums = [NSString stringWithFormat:@"%@", @(f.zambia_nums.integerValue - 1)];
    }
    
    [button setTitle:f.zambia_nums forState:UIControlStateNormal];
    
    
    
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

- (void)guanzhu:(UIButton *)button
{
    button.selected = !button.isSelected;
    
    DetailsInfo *f = detailsInfo;
    
    if (button.isSelected)
    {
        detailsInfo.collection = @"1";
        f.coll_nums = [NSString stringWithFormat:@"%ld", f.coll_nums.integerValue + 1];
        
    }
    else
    {
        detailsInfo.collection = @"0";
        f.coll_nums = [NSString stringWithFormat:@"%ld", f.coll_nums.integerValue - 1];
    }
    
    
    [self.table reloadData];
    
     NSString *path;
    if (button.isSelected)
    {
        path = @"/app.php/Index/collection_add";
    }
    else
    {
        path = @"/app.php/Index/collection_del";
    }
    
    NSDictionary *params = @{
                             @"uid":kUserId,
                             @"u_id":f.u_id,
//                             @"type" : @"1"
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         [self showToastWithMessage:msg];
         
         
     } fail:^(NSString *error) {
         [self showToastWithMessage:@"您已经关注关注了"];
     }];
}

// 点击私信按钮跳转聊天界面
- (void)sixinClick:(NSString *)userId {
    TLChatViewController *vc = [TLChatViewController new];
    vc.userId = detailsInfo.u_id;
    vc.navigationItem.title = detailsInfo.u_name;
    [self.navigationController pushViewController:vc animated:YES];
//    [[TLRCManager shareManager] initEnv];
}

@end
