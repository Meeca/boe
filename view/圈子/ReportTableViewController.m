//
//  ReportTableViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/25.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "ReportTableViewController.h"
#import "UIViewController+MBShow.h"

@interface ReportTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet IWTextView *moreTextField;
@property (copy, nonatomic) NSString *jubaoContent;
@property (strong, nonatomic) NSArray *titles;

@end

@implementation ReportTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self choosebtnClick];
    self.title =@"举报";
    _jubaoContent = @"";
    _titles = @[@"色情",@"欺诈",@"谣言",@"政治敏感",@"隐私犯罪",@"侵权(抄袭，盗用)"];
    _moreTextField.placeholder = @"多行输入";
    
    self.navigationItem.rightBarButtonItem.tintColor = KAPPCOLOR;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if (section == 0) {
        return @"请选择举报原因";
    }
    else
    {
        
        return @"举证";
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return 6;
    }
    else
    {
        
        return 1;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    view.backgroundColor = [UIColor clearColor];
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, view.bounds.size.width, view.bounds.size.height)];
    label.text = title;
    label.textColor = [UIColor blackColor];
    
    [view addSubview:label];
    
    
    
    return view;
}


//点击确认提交

- (IBAction)confirmButtonClick:(id)sender
{
    NSLog(@"你点击了确定按钮");
    [self loadCircleJuBaoData];
    
}
//请求网络
- (void)loadCircleJuBaoData
{
    if (self.moreTextField.text.length == 0) {
        [self showToastWithMessage:@"请输入举报内容"];
        return;
    }
    if (_jubaoContent.length == 0) {
        [self showToastWithMessage:@"请选择举报类型"];
        return;
    }
NSString *path = @"/app.php/Circles/report";
    NSDictionary *params = @{
                             @"co_id" : self.cID,
                             
                              @"u_id" : kUserId,
                              @"type" : _jubaoContent,
                              @"content" : self.moreTextField.text,
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
    {
        [self showToastWithMessage:msg];
        [self.navigationController popViewControllerAnimated:YES ];
    }
                      fail:^(NSString *error) {
        [self showToastWithMessage:@"您已经举报过了"];
                      }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
    }
    
    else if(indexPath.row == 1)
        
    {
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        
    }
    else if(indexPath.row == 2)
        
    {
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        
    }
    else if(indexPath.row == 3)
        
    {
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        
    }
    else if(indexPath.row == 4)
        
    {
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        
    }
    else if(indexPath.row == 5)
        
    {
        self.btn6.backgroundImage = [UIImage imageNamed:@"未标题-1-2"];
        self.btn2.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn3.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn4.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn5.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        self.btn1.backgroundImage = [UIImage imageNamed:@"未标题-1-1"];
        
    }
    _jubaoContent = _titles[indexPath.row];
    
    
}


@end
