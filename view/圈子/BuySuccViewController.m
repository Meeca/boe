//
//  BuySuccViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/11.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "BuySuccViewController.h"
#import "OrderXQViewController.h"

@interface BuySuccViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation BuySuccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!self.isPushFromDaShang) {
        self.isPushFromDaShang = NO;
    }
    self.title = @"支付订单";
    self.table.backgroundColor = RGB(234, 234, 234);
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 300)];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    image.image = [UIImage imageNamed:@"APP buy 切图 20160727-8"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [footer addSubview:image];
    
    UILabel *msgL = [[UILabel alloc] initWithFrame:CGRectMake(image.right+3, 10, KSCREENWIDTH-image.right-20, 50)];
    msgL.text = @"安全提醒：我们不会以任何理由要求您提供银行卡信息或支付额外费用，请谨防钓鱼链接或诈骗电话。";
    msgL.numberOfLines = 0;
    msgL.textColor = [UIColor grayColor];
    msgL.font = [UIFont systemFontOfSize:13];
    [footer addSubview:msgL];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:msgL.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    msgL.attributedText = str;
    msgL.height = [Tool getLabelSizeWithText:msgL.text AndWidth:msgL.width AndFont:msgL.font attribute:@{NSParagraphStyleAttributeName:paragraphStyle}].height;
    
    self.table.tableFooterView = footer;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    CGFloat h = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row==0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"APP buy 切图 20160727-7"];
        [cell.contentView addSubview:imageView];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:name];
        name.text = @"支付成功";
        [name sizeToFit];
        
        imageView.center = CGPointMake(tableView.width/2, h/2);
        imageView.centerY -= name.height/3*2;
        
        name.centerX = imageView.centerX;
        name.top = imageView.bottom + 15;
    } else if (indexPath.row==1) {
        UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KSCREENWIDTH-30, h)];
        msg.text = @"我们将尽快安排发货，您可以在“我购买的”查看订单状态及快递单号。";
        msg.numberOfLines = 0;
        msg.textColor = [UIColor grayColor];
        msg.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:msg];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:msg.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        msg.attributedText = str;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KSCREENWIDTH-30, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    } else if (indexPath.row==2) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(15, 5, (KSCREENWIDTH-60)/2, 40);
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        btn1.layer.cornerRadius = 5;
        btn1.layer.borderColor = KAPPCOLOR.CGColor;
        btn1.layer.borderWidth = 1;
        [btn1 setTitle:@"返回首页" forState:UIControlStateNormal];
        [btn1 setTitleColor:KAPPCOLOR forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(btn1.right+30, 5, (KSCREENWIDTH-60)/2, 40);
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        btn2.layer.cornerRadius = 5;
        btn2.layer.borderColor = [UIColor grayColor].CGColor;
        btn2.layer.borderWidth = 1;
        [btn2 setTitle:@"查看订单" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(xiangQing:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:btn2];
        
        if (self.isPushFromDaShang) {
            btn1.frame = CGRectMake(15, 5, KSCREENWIDTH - 30, 40);
            btn2.hidden = YES;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 140;
    } else if (indexPath.row==1) {
        return 80;
    } else if (indexPath.row==2) {
        return 80;
    }
    return 0;
}

- (void)xiangQing:(UIButton *)btn {
    OrderXQViewController *vc = [[OrderXQViewController alloc] init];
    if (self.info.o_id.length) {
        vc.o_id = self.info.o_id;
    } else if (self.orderId.length) {
        vc.o_id = self.orderId;
    }
    
    vc.isMyBuy = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [Tool setBackButtonNoTitle:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
