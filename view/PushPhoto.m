//
//  PushPhoto.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/10.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "PushPhoto.h"
#import "BaseModel.h"
#import "PushTableViewCell.h"

@interface PushPhoto () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *table;
    
    BaseModel *baseModel;
    NSMutableArray *selArr;
    
    BOOL isAll;
}

@end

@implementation PushPhoto
@synthesize dataArr;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 44, 44);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"B-22-2"] forState:UIControlStateNormal];
    [view addSubview:back];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"选择推送设备";
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    [title sizeToFit];
    title.center = CGPointMake(view.width/2, view.height/2);
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
    push.titleLabel.font = [UIFont systemFontOfSize:13];
    [push setTitle:@"推送" forState:UIControlStateNormal];
    [push setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [push addTarget:self action:@selector(pushPhoto:) forControlEvents:UIControlEventTouchUpInside];
    push.layer.cornerRadius = 3;
    push.layer.masksToBounds = YES;
    [push setBackgroundColor:KAPPCOLOR];
    [view addSubview:push];
    [push sizeToFit];
    push.width += 20;
    push.centerY = view.height/2;
    push.right = self.width - 10;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    line.bottom = view.height;
    
    [self addSubview:view];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-44) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:table];
    
    baseModel = [BaseModel modelWithObserver:self];
    
}

- (void)setDataArr:(NSArray *)dataA {
    dataArr = dataA;
    
    selArr = [NSMutableArray array];
    for (int i=0; i<dataArr.count; i++) {
        [selArr addObject:@(NO)];
    }
    [table reloadData];
}

ON_SIGNAL3(BaseModel, JPUSHINDEX, signal) {
    [Tool performBlock:^{
        [self back];
    } afterDelay:.3];
}

- (void)setImgArr:(NSMutableArray *)imgArr {
    if (_imgArr != imgArr) {
        _imgArr = imgArr;
    }
    CGFloat width = (self.width-71)/4;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, (self.width-71)/4*2+50)];
    
    for (int i=0; i<imgArr.count; i++) {
        int row = i/4;
        int col = i%4;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20+(width+10)*col, 20+(width+10)*row, width, width)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgArr[i]] placeholderImage:KZHANWEI];
        [header addSubview:imgView];
    }
    
    table.tableHeaderView = header;
}

- (void)setInfo:(DetailsInfo *)info {
    if (_info != info) {
        _info = info;
    }
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, (self.width-71)/4*2+40)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, (self.width-71)/4, (self.width-71)/4)];
    imgView.centerY = header.height/2;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [imgView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    [header addSubview:imgView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.text = info.title?:@"";
    name.font = [UIFont boldSystemFontOfSize:20];
    name.textColor = [UIColor whiteColor];
    [header addSubview:name];
    [name sizeToFit];
    name.x = imgView.right + 15;
    name.top = imgView.top;
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectZero];
    author.text = [@"作者 " stringByAppendingString:info.u_name?:@""];
    author.font = [UIFont systemFontOfSize:16];
    author.textColor = [UIColor whiteColor];
    [header addSubview:author];
    [author sizeToFit];
    author.x = imgView.right + 15;
    author.top = name.bottom + 10;
    
    table.tableHeaderView = header;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pushCell"];
    if (cell==nil) {
        cell = [[PushTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pushCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.data = dataArr[indexPath.row];
    cell.iSsel = [selArr[indexPath.row] boolValue];
    [cell setNeedsLayout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL sel = [selArr[indexPath.row] boolValue];
    [selArr removeObjectAtIndex:indexPath.row];
    [selArr insertObject:@(!sel) atIndex:indexPath.row];
    [tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    view.clipsToBounds = YES;
    UILabel *all = [[UILabel alloc] initWithFrame:CGRectZero];
    all.textColor = [UIColor blackColor];
    all.font = [UIFont systemFontOfSize:15];
    [view addSubview:all];
    all.text = @"全选";
    [all sizeToFit];
    all.x = 20;
    all.centerY = 20;
    
    UIImageView *selImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    selImg.contentMode = UIViewContentModeScaleAspectFit;
    selImg.clipsToBounds = YES;
    selImg.userInteractionEnabled = YES;
    [view addSubview:selImg];
    selImg.centerY = view.height/2;
    selImg.right = view.width - 5;
    
    isAll = YES;
    for (NSNumber *sel in selArr) {
        if (![sel boolValue]) {
            isAll = NO;
            break;
        }
    }
    if (isAll) {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-12"];
    } else {
        selImg.image = [UIImage imageNamed:@"切图 QH 20160704-13"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allSel:)];
    [selImg addGestureRecognizer:tap];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-.5, tableView.width, .5)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (void)pushPhoto:(UIButton *)btn {
    NSMutableArray *selIndexArr = [NSMutableArray array];
    for (int i=0; i<selArr.count; i++) {
        NSNumber *sel = selArr[i];
        if ([sel boolValue]) {
            [selIndexArr addObject:@(i)];
        }
    }
    if (selIndexArr.count==0) {
        [self presentMessageTips:@"请选择要推送的设备"];
        return;
    }
    NSMutableArray *dvs = [NSMutableArray array];
    for (NSNumber *index in selIndexArr) {
        EquipmentList *list = dataArr[[index integerValue]];
        [dvs addObject:list.e_id];
    }
    NSString *e_id = [dvs componentsJoinedByString:@"-"];
    if (self.info) {
        [baseModel app_php_Jpush_indexWithP_id:self.info.p_id e_id:e_id type:@"1" pay_type:_info.pay_type u_id:kUserId];
    } else {
        [baseModel app_php_Jpush_indexWithP_id:self.p_idsStr e_id:e_id type:@"2" pay_type:self.pay_type u_id:kUserId];
    }
}

- (void)allSel:(UIGestureRecognizer *)tap {
    NSInteger count = selArr.count;
    [selArr removeAllObjects];
    if (isAll) {
        for (int i=0; i<count; i++) {
            [selArr addObject:@(NO)];
        }
    } else {
        for (int i=0; i<count; i++) {
            [selArr addObject:@(YES)];
        }
    }
    [table reloadData];
}

- (void)back {
    [UIView animateWithDuration:.3 animations:^{
        self.x = KSCREENWIDTH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
