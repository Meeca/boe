//
//  CircleViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/6/22.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "CircleViewController.h"
#import "ManageViewController.h"
#import "SeachViewController.h"
#import "JDFSearchView.h"
#import "JDFCircleCell.h"
#import "APIClient.h"
#import "Response.h"
#import "JDFCircleModel.h"
#import "FTPopOverMenu.h"
#import "CircleSearchViewController.h"
#import "CreatCircleTableViewController.h"
#import "MCNetTool.h"
#import "UITableView+MJRefresh.h"
#import "CircleConversViewController.h"
#import "CYAlertView.h"
#import "MBProgressHUD+Add.h"
#import "UIViewController+MBShow.h"
#import "TPKeyboardAvoidingTableView.h"

@interface CircleViewController ()<UITableViewDelegate,UITableViewDataSource,CYAlertViewDelegate>


@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSString *password;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) NSMutableArray *myCicles;

@property (nonatomic, strong) NSMutableArray *allCircles;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) JDFCircleModel *circle;



@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    
    self.navigationItem.title = @"圈儿";
    [self addTableViewRefreshView];
    [self initUI];
    
    _tableView.sectionFooterHeight = 0;
    _tableView.tableFooterView = [UIView new];
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadCircleDataWithFirstPage:YES hud:NO];
    
}


- (void)addTableViewRefreshView{
    
    [_tableView headerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:YES hud:NO];
        
        
    }];
    [_tableView headerBeginRefresh];
    
    [_tableView footerAddMJRefresh:^{
        
        [self loadCircleDataWithFirstPage:NO hud:NO];
        
        
    }];
    
    
    
    
}



-(NSMutableArray *)myCicles
{
    if (_myCicles == nil)
    {
        _myCicles = [NSMutableArray array];
    }
    return _myCicles;
}

-(NSMutableArray *)allCircles
{
    if (_allCircles == nil)
    {
        _allCircles = [NSMutableArray array];
    }
    return _allCircles;
}

- (UIView *)headerView
{
    if (_headerView == nil)
    {
        CGRect frame = self.view.bounds;
        frame.size.height = 44;
        
        UIView *headerView = [[UIView alloc]initWithFrame:frame];
        
        JDFSearchView *searchView = [[[UINib nibWithNibName:@"JDFSearchView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        searchView.frame = frame;
        
        [headerView addSubview:searchView];
        
        _headerView = headerView;
        
        
    }
    return _headerView;
}

- (void)initUI

{
    
    self.tableView.tableHeaderView = self.headerView;
    
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 50, 50);
    [left setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [left setImage:[UIImage imageNamed:@"A-set"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(manage:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [right setImage:[UIImage imageNamed:@"C-11-3"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(addCircle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
- (void)manage:(UIBarButtonItem *)item {
    ManageViewController *vc = [[ManageViewController alloc] init];
    [Tool setBackButtonNoTitle:self];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addCircle:(UIView *)item {
    
    [FTPopOverMenu showForSender:item
                        withMenu:@[@"加入圈儿",@"新建一个圈儿"]
     //                  imageNameArray:@[@"setting_icon",@"setting_icon",@"setting_icon"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           if (selectedIndex == 0)
                           {
                               CircleSearchViewController *circleSearchVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleSearchViewController"];
                               UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:circleSearchVC];
                               [naviVC setNavigationBarHidden:YES animated:YES];
                               [self.navigationController presentViewController:naviVC animated:NO completion:^{
                                   
                               }];
                           }
                           else if (selectedIndex == 1)
                           {
                               
                               CreatCircleTableViewController *creatCircleTableVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatCircleTableViewController"];
                               creatCircleTableVC.type = 1;
                               [self.navigationController pushViewController:creatCircleTableVC animated:YES];
                               
                           }
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectZero];
    msg.text = @"正在研发中。。。";
    msg.font = [UIFont boldSystemFontOfSize:25];
    //    [self.view addSubview:msg];
    [msg sizeToFit];
    msg.center = CGPointMake(self.view.width/2, self.view.height/2);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return self.myCicles.count > 0 ? self.myCicles.count : 1;
    }
    
    return self.allCircles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"我的圈子";
    }
    
    return @"热门圈子";
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    view.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:235.0/255 alpha:1];
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, view.bounds.size.width, view.bounds.size.height)];
    label.text = title;
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont systemFontOfSize:14];
    
    [view addSubview:label];
    
    
    
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.myCicles.count < 1& indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
        cell.textLabel.text = @"您还没有加入任何圈儿";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *cellIdentifier = @"JDFCircleCell";
    JDFCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[JDFCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    JDFCircleModel *circle;
    
    if (indexPath.section == 0)
    {
        circle = self.myCicles[indexPath.row];
    }
    else
    {
        circle = self.allCircles[indexPath.row];
    }
    
    cell.circle = circle;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}


- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud{
    
    if (firstPage) {
        _page = 1;
    }
    
    NSString *path = @"/app.php/Circles/index";
    NSDictionary *parameters = @{
                                 @"u_id" : kUserId,
                                 @"page" : @(_page),
                                 @"pagecount" : @"20"
                                 };
    
    [MCNetTool postWithCacheUrl:path params:parameters hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
//        if ([requestDic isKindOfClass:[NSDictionary class]])
//        {
//            return ;
//        }
if ([requestDic isKindOfClass:[NSString class]] && ((NSString *)requestDic).length <= 0)
{

//    return ;
    [_tableView headerEndRefresh];
    [_tableView footerEndRefresh];
    return ;

}
        _page ++;
        
        NSArray * myList = [NSArray yy_modelArrayWithClass:[JDFCircleModel class] json:requestDic[@"my_list"]];
        NSArray * allList= [NSArray yy_modelArrayWithClass:[JDFCircleModel class] json:requestDic[@"all_list"]];
        
        firstPage?[_myCicles setArray:myList]:[_myCicles addObjectsFromArray:myList];
        firstPage?[_allCircles setArray:allList]:[_myCicles addObjectsFromArray:allList];
        
        
        [_tableView reloadData];
        
        if (myList.count < 20) {
            [_tableView hidenFooter];
        }
        
        firstPage?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
        
        
    } fail:^(NSString *error) {
        
        firstPage?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
        
    }];
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (self.myCicles.count < 1 && indexPath.section == 0)
    {
        CircleSearchViewController *circleSearchVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleSearchViewController"];
        UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:circleSearchVC];
        [naviVC setNavigationBarHidden:YES animated:YES];
        [self.navigationController presentViewController:naviVC animated:NO completion:^{
            
        }];
        return ;
    }
    
#pragma mark ---------进入界面提示框
    JDFCircleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    JDFCircleModel *circle = cell.circle;
    
    if (indexPath.section == 1 && circle.attributes == 2)
    {
        self.circle = circle;
        CYAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CYAlertView" owner:nil options:nil] firstObject];
        
        alert.delegate = self;
        //    [self addTableViewRefreshView];
        //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
        //    [self.view addGestureRecognizer:tap];
        //- (void)endEditing
        //{
        //    [self.view endEditing:YES];
        //}
        
        [alert show];
    }
    else
    {
        CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
        conversVC.circle = circle;
        
        [self.navigationController pushViewController:conversVC animated:YES];
    }
    
    
}


- (void)alertView:(CYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex password:(NSString *)pass
{
    if (buttonIndex == 1) {
        NSLog(@"点击确定了哦");
        self.password = pass;
        [self loadPasswordCheckingData];
    }
    
}
- (void)loadPasswordCheckingData
{
    
    NSString *path = @"/app.php/Circles/pass";
    NSDictionary *params = @{
                             @"c_id" : self.circle.ID,
                             @"pass":self.password,
                             
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         //         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
         //                        {
         //                           [MBProgressHUD showMessag:msg toView:self.view];
         //                        });
         //
         
         if ([msg isKindOfClass:[NSString class]] && ((NSString *)msg).length <= 0)
         {
             
             CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
             conversVC.circle = self.circle;
             [self.navigationController pushViewController:conversVC animated:YES];
             [self showToastWithMessage:@"验证成功"];
         }
//         else if(((NSString *)msg).length > 0)
//         {
//             [self showToastWithMessage:@"密码错误"];
//         }
         
         
         
     }
                      fail:^(NSString *error)
     {
         [self showToastWithMessage:@"密码错误"];
     }];
}
@end
