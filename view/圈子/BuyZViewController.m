//
//  BuyZViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/10.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BuyZViewController.h"
#import "QueRenViewController.h"
#import "TLChatViewController.h"

@interface BuyZViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    UIView *header;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
//@property (copy,nonatomic)NSString *detailInfo;
@end

@implementation BuyZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"真品购买";
    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 44)];
    [self.view addSubview:bar];
    bar.backgroundColor = [UIColor whiteColor];
    bar.bottom = KSCREENHEIGHT;
    
    UIButton *shixin = [UIButton buttonWithType:UIButtonTypeCustom];
    shixin.frame = CGRectMake(0, 0, KSCREENWIDTH/3, 44);
    shixin.titleLabel.font = [UIFont systemFontOfSize:12];
    [shixin setTitle:@"联系卖家" forState:UIControlStateNormal];
    [shixin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shixin setTitleEdgeInsets:UIEdgeInsetsMake(9, 0, -9, 0)];
    [shixin addTarget:self action:@selector(sixinAction:) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:shixin];
    
    UIImageView *shixinImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    shixinImage.contentMode = UIViewContentModeScaleAspectFit;
    shixinImage.image = [UIImage imageNamed:@"B-11"];
    [bar addSubview:shixinImage];
    shixinImage.center = shixin.center;
    shixinImage.centerY = shixin.centerY - 8;

    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(KSCREENWIDTH/3, 0, KSCREENWIDTH/3*2, 44);
    buy.backgroundColor = KAPPCOLOR;
    [buy setTitle:@"立即购买" forState:UIControlStateNormal];
    [buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    buy.titleLabel.font = [UIFont systemFontOfSize:16];
    [bar addSubview:buy];
    
    self.table.backgroundColor = RGB(234, 234, 234);
    self.table.tableHeaderView = header;
    
    self.table.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 44, 0);
}

- (void)sixin
{


    

}
- (void)setInfo:(DetailsInfo *)info {
    if (_info != info) {
        _info = info;
    }
    
    CGFloat wid = 80;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, wid+40)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, wid, wid)];
    imgView.centerY = header.height/2;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [imgView sd_setImageWithURL:[NSURL URLWithString:info.image] placeholderImage:KZHANWEI];
    [header addSubview:imgView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.text = info.title?:@" ";
    name.font = [UIFont boldSystemFontOfSize:19];
    name.textColor = [UIColor blackColor];
    [header addSubview:name];
    [name sizeToFit];
    name.x = imgView.right + 10;
    name.top = imgView.top+2;
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectZero];
//    author.text = [@"作者 " stringByAppendingString:info.u_name?:@" "];
    author.text = info.u_name;
    author.font = [UIFont systemFontOfSize:15];
    author.textColor = [UIColor blackColor];
    [header addSubview:author];
    [author sizeToFit];
    author.x = imgView.right + 10;
    author.top = name.bottom + 8;
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectZero];
    num.text = [NSString stringWithFormat:@"库存：%@件", info.material_nums.length>0?info.material_nums:@"0"];
    num.font = [UIFont systemFontOfSize:15];
    num.textColor = [UIColor blackColor];
    [header addSubview:num];
    [num sizeToFit];
    num.x = imgView.right + 10;
    num.top = author.bottom + 8;
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectZero];
    price.text = [@"￥" stringByAppendingString:info.material_price.length>0?info.material_price:@"0"];
    price.font = [UIFont boldSystemFontOfSize:15];
    price.textColor = KAPPCOLOR;
    [header addSubview:price];
    [price sizeToFit];
    price.right = KSCREENWIDTH - 20;
    price.centerY = header.height/2;
    
    self.table.tableHeaderView = header;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.textLabel.text = @"材料：布面油画\n尺寸：135cmx150cm\n细节图：";
        cell.textLabel.numberOfLines = 0;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;
        [str addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, str.length)];
        
        cell.textLabel.attributedText = str;
    } else {
        CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, h)];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [cell.contentView addSubview:image];
        
        [image sd_setImageWithURL:[NSURL URLWithString:self.info.image] placeholderImage:KZHANWEI];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 100;
    }
    return KSCREENWIDTH*1080/1920;
}

- (void)sixinAction:(UIButton *)btn
{
    NSLog(@"你点击了私信");
        TLChatViewController *vc = [TLChatViewController new];
        vc.userId = _info.u_id;
        [self.navigationController pushViewController:vc animated:YES];
}
- (void)buyAction:(UIButton *)btn {
    
//    if (self.info.material_price.integerValue <= 0 || self.info.material_price.length <= 0)
//    {
//        return;
//    }
    
    QueRenViewController *vc = [[QueRenViewController alloc] init];
    vc.info = self.info;
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
