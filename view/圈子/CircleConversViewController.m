//
//  CircleConversViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleConversViewController.h"
#import "JDFCircleModel.h"
#import "UITableView+MJRefresh.h"
#import "Convers.h"
#import "JDFCircleConversCell.h"
#import "FTPopOverMenu.h"

#import "CirclePropertyTableViewController.h"
#import "CircleMembersTableViewController.h"
#import "CircleConversDetailViewController.h"
#import "CreatTopicTableViewController.h"
#import "MCHttp.h"
#import "CirclesRead.h"
#import "UIViewController+MBShow.h"
#import "CircleMemberGroupsViewController.h"
#import "JoinCircleOrNot.h"
#import "EmptyViewFactory.h"

#import "MBProgressHUD.h"

JoinCircleOrNot *circleOrNot;

@interface CircleConversViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger _page;
    
    NSArray * _btnTitles;
    
    JoinCircleOrNot *circleOrNot;
  
    NSString * u_id;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *subTags;

@property (nonatomic, strong) NSMutableArray *converses; //话题数组


@property (nonatomic, assign) BOOL isType;


@end

@implementation CircleConversViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initCircleUI];
    
    [self loadConversWithFirstPage:YES hud:NO];
    [self addTableViewRefreshView];

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}

#pragma mark ----- 判断是否加入圈子


-(void)JoinCircleIsOrNot
{
    
    NSString *path = @"/app.php/Circles/join_see";
    NSDictionary *params = @{
                             @"c_id":self.circle.ID,
                             @"u_id":kUserId,
                             };
        [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         circleOrNot = [JoinCircleOrNot yy_modelWithJSON:requestDic];
         
     } failure:^(NSString *error) {
         [self showToastWithMessage:error];
     }];
    
}

- (void)viewWillAppear:(BOOL)animated
{    [self addTableViewRefreshView];
    self.navigationController.navigationBarHidden = NO;
    
    [self loadConversWithFirstPage:YES hud:NO];
    [self JoinCircleIsOrNot];
    
}
-(NSMutableArray *)converses
{
    if (_converses == nil)
    {
        _converses = [NSMutableArray array];
    }
    return _converses;
}

- (void)initCircleUI
{
    self.title = self.circle.title;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 188;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [right setImage:[UIImage imageNamed:@"quanMore"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    
}

- (void)addTableViewRefreshView{
    
    [_tableView headerAddMJRefresh:^{
        
        [self loadConversWithFirstPage:YES hud:NO];
        
        
    }];
    [_tableView headerBeginRefresh];
    
    [_tableView footerAddMJRefresh:^{
        
        [self loadConversWithFirstPage:NO hud:NO];
        
        
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Convers *convers = self.converses[indexPath.row];
    CircleConversDetailViewController *circleConversDetailVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CircleConversDetailViewController"];
    
    circleConversDetailVC.c_id = convers.coID;
    [self.navigationController pushViewController:circleConversDetailVC animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.converses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"JDFCircleConversCell";
    JDFCircleConversCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[JDFCircleConversCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Convers *convers = self.converses[indexPath.row];
    cell.convers = convers;
     u_id = convers.u_id;
    return cell;
}

- (void)changeBtndStateWithIsType:(BOOL )type{
    
    
    _btnTitles =  type? @[@"圈儿属性",@"圈儿成员", @"加入圈儿"]: @[@"圈儿属性",@"圈儿成员", @"退出圈儿"];
}

- (void)moreAction:(UIButton *)button
{
    [FTPopOverMenu showForSender:button
                        withMenu: _btnTitles /*@[@"圈儿属性",@"圈儿成员", @"加入圈儿"]*/
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           if (selectedIndex == 0)
                           {
                               [self loadCircleAttribute];
                           }
                           else if (selectedIndex == 1)
                           {
                               
                               CircleMemberGroupsViewController *circleMembersVC = [[CircleMemberGroupsViewController alloc]init];
                               circleMembersVC.cID = self.circle.ID;
                               
                               circleMembersVC.userId = _circle.u_id;
                               
                               [self.navigationController pushViewController:circleMembersVC animated:YES];
                               
                           }
                           else if (selectedIndex == 2)
                           {
                               //
                               
                               if ([circleOrNot.types integerValue] == 2) {
                                   
                                   NSLog(@"你点击了加入圈");
                                   NSString *path = @"/app.php/Circles/join_add";
                                   NSDictionary *params = @{
                                                            @"c_id" : self.circle.ID,
                                                            @"u_id" : kUserId
                                                            
                                                            };
                                   [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
                                    {
                                        _isType =([circleOrNot.types integerValue] == 2?YES:NO);
                                        [self showToastWithMessage:@"加入圈儿成功"];
                                        _isType =!_isType;
                                        
                                        [self changeBtndStateWithIsType:_isType];
                                        [self JoinCircleIsOrNot];
                                        [self changeBtndStateWithIsType:_isType];
                                        [self addTableViewRefreshView];
                                        
                                    } fail:^(NSString *error) {
                                        
                                        
                                    }];
                                   
                               }
                               else{
                                   if ([self.circle.u_id isEqualToString:kUserId]) {
                                       [self showToastWithMessage:@"圈主不能退出圈子"];
                                       return ;
                                   }
                                   
                                   
                                   NSString *parth = @"/app.php/Circles/join_del";
                                   NSDictionary *params = @{
                                                            @"c_id":self.circle.ID,
                                                            @"u_id":kUserId,
                                                            
                                                            };
                                   [MCHttp postRequestURLStr:parth withDic:params success:^(NSDictionary *requestDic, NSString *msg) {
                                       [self.navigationController popViewControllerAnimated:YES];
                                       [self showToastWithMessage:@"退出成功"];
                                   } failure:^(NSString *error) {
                                       
                                   }];
                                   
                                   
                               }
                               
                           }
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
#pragma mark -------加载圈儿属性
- (void)loadCircleAttribute
{
    
    NSString *path = @"/app.php/Circles/read";
    NSDictionary *params = @{
                             @"c_id" : self.circle.ID,
                             };
    [MCHttp postRequestURLStr:path withDic:params success:^(NSDictionary *requestDic, NSString *msg)
     {
         CirclesRead *read = [CirclesRead yy_modelWithJSON:requestDic];
         
         CirclePropertyTableViewController *circlePropertyVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CirclePropertyTableViewController"];
         
         circlePropertyVC.circlesRead = read;
         
         [self.navigationController pushViewController:circlePropertyVC animated:YES];
         
     }
                      failure:^(NSString *error)
     {
         
     }];
    
    
    
    
    
}

- (IBAction)newConversAction:(UIButton *)sender
{
    //跳到新建话题页面
    if ([circleOrNot.types integerValue] == 2) {
        [self showToastWithMessage:@"请先加入圈儿"];
    }
    else{
    
        CreatTopicTableViewController *createTopicVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"CreatTopicTableViewController"];
        
        
        createTopicVC.cID = _circle.ID ;
        
        [self.navigationController pushViewController:createTopicVC animated:YES];
    }
    
    
}
#pragma mark ---- 加载话题详情
- (void)loadConversWithFirstPage:(BOOL)firstPage hud:(BOOL)hud{
    
    if (firstPage) {
        _page = 1;
    }
    
    NSString *path = @"/app.php/Circles/co_index";
    NSDictionary *parameters = @{
                                 @"c_id" : [NSString stringWithFormat:@"%@",self.circle.ID],
                                 @"page" : @(_page),
                                 @"pagecount" : @"20"
                                 };
    
    [MCNetTool postWithCacheUrl:path params:parameters hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        _page ++;
        
        NSArray *result;
        
        
        if ([requestDic isKindOfClass:[NSArray class]])
        {
            result = (NSArray *)requestDic;
        }
        
        NSArray * myList = [NSArray yy_modelArrayWithClass:[Convers class] json:result];
        
        firstPage?[self.converses setArray:myList]:[self.converses addObjectsFromArray:myList];
        
        _isType =([circleOrNot.types integerValue] == 2?YES:NO);
        
        [self changeBtndStateWithIsType:_isType];
        [_tableView reloadData];
        
        if (myList.count < 20) {
            [_tableView hidenFooter];
        }
        
        [EmptyViewFactory emptyDataAnalyseWithDataSouce:self.converses emptyContent:@"此圈子还没有任何话题" withScrollView:_tableView];
        
        
        firstPage?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
        
        
        
    } fail:^(NSString *error) {
        
        firstPage?[_tableView headerEndRefresh]:[_tableView footerEndRefresh];
        
        [EmptyViewFactory emptyDataAnalyseWithDataSouce:self.converses emptyContent:@"此圈子还没有任何话题" withScrollView:_tableView];

    }];
    
    
    
}




@end
