//
//  CircleSearchViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/22.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleSearchViewController.h"
#import "CircleViewController.h"
#import "MCNetTool.h"
#import "DataModel.h"
#import "circleSearchTableViewCell.h"
#import "UIViewController+MBShow.h"
#import "CircleConversViewController.h"
#import "JDFCircleCell.h"
#import "JDFCircleModel.h"
#import "CYAlertView.h"
CircleSearch *circleSearch;
@interface CircleSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CYAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *searchCircle;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSMutableArray *searchCicles;

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (nonatomic, strong) CircleSearch *circle;


@end

@implementation CircleSearchViewController

- (void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden = YES;
    [_searchCircle becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeKeyBoard];
    
    [self.view addSubview:self.emptyView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
//    [self.view addGestureRecognizer:tap];
    
}

- (void)endEditing
{
    [self.view endEditing:YES];
}
- (void)changeKeyBoard
{
    //设置键盘的return按键
    self.searchCircle.returnKeyType = UIReturnKeySearch;
    self.searchCircle.delegate = self;
    
}




-(NSMutableArray *)searchCicles
{
    if (_searchCicles == nil)
    {
        _searchCicles = [NSMutableArray array];
        
        CircleSearch *circle = [[CircleSearch alloc]init];
        
        [_searchCicles addObject:circle];
    }
    return _searchCicles;
}

- (void)refreshViews
{
    self.emptyView.hidden = self.searchCicles.count > 0;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender

{
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
//点击搜索相应事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了搜索");
    [self loadCircleDataWithFirstPage:YES hud:NO];
    [self.view endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud

{
    if (firstPage) {
        _page = 1;
    }
    NSString *path = @"/app.php/Circles/search";
    NSDictionary *parameters = @{
                                 @"u_id":kUserId,
                                 @"search" : self.searchCircle.text,
                                 @"page" : @(_page),
                                 @"pagecount" : @"20"
                                 };
    [MCNetTool postWithUrl:path params:parameters hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         _page ++;
         NSArray *result;
         
         if ([requestDic isKindOfClass:[NSDictionary class]])
         {
             result = requestDic[@"all_list"];
         }
         
         
         
         
         //         if ([requestDic[@"all_list"] isKindOfClass:[NSArray class]])
         //         {
         //             result = (NSArray *)requestDic[@"all_list"];
         //         }
         
         
         
         NSArray * myList = [NSArray yy_modelArrayWithClass:[CircleSearch class] json:result];
         
         firstPage?[_searchCicles setArray:myList]:[_searchCicles addObjectsFromArray:myList];
         if (msg.length == 0) {
             [self showToastWithMessage:@"加载成功"];
         }
         else if(msg.length > 0)
         {
             [self showToastWithMessage:msg];
             
         }
         [self refreshViews];
     }
                      fail:^(NSString *error)
     {
         
     }];
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    return @"搜索结果";
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchCicles.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"circleSearchTableViewCell";
    circleSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[circleSearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CircleSearch *search = self.searchCicles[indexPath.row];
    
    cell.circleSearchModel = search;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    JDFCircleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    circleSearchTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    JDFCircleModel *circle = cell.circle;
    circleSearch = cell.circleSearchModel;
#pragma mark ----------1,公开2密码    types 1加入,2未加入
    if ([circleSearch.types integerValue] ==1 && circleSearch.attributes == 2) {
        //已经加入圈子有密码
        //不显示弹窗
        CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
        
        JDFCircleModel *circle = [[JDFCircleModel alloc]init];
        circle.ID = circleSearch.cId;
        circle.title = circleSearch.title;
        conversVC.circle = circle;
        
        [self.navigationController pushViewController:conversVC animated:YES];
        
    }
    else if ([circleSearch.types integerValue] == 1  && circleSearch.attributes == 1)
    {
    //已经加入圈子没有密码
        //不显示弹窗
        CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
        
        JDFCircleModel *circle = [[JDFCircleModel alloc]init];
        circle.ID = circleSearch.cId;
        circle.title = circleSearch.title;
        conversVC.circle = circle;
        
        [self.navigationController pushViewController:conversVC animated:YES];
    
    }
    else if ([circleSearch.types integerValue]==2 && circleSearch.attributes == 2)
    {
    //未加入的圈子有密码
        //显示弹窗
        
        self.circle = circleSearch;
        CYAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CYAlertView" owner:nil options:nil] firstObject];
        
        alert.delegate = self;
        
        [alert show];

    
    }
    else if ([circleSearch.types integerValue]==2   && circleSearch.attributes == 1)
    {
    //未加入的圈子没有密码
        //不显示弹窗
        {
        
            CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
            
            JDFCircleModel *circle = [[JDFCircleModel alloc]init];
            circle.ID = circleSearch.cId;
            circle.title = circleSearch.title;
            conversVC.circle = circle;
            
            [self.navigationController pushViewController:conversVC animated:YES];
        
        }
    
    }
    

    /*
    //显示弹窗
    
    if (circleSearch.attributes == 2)
    {
        self.circle = circleSearch;
        CYAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CYAlertView" owner:nil options:nil] firstObject];
        
        alert.delegate = self;
        
        [alert show];
    }
    else
    {
        //不显示弹窗
        CircleConversViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleConversViewController"];
        
        JDFCircleModel *circle = [[JDFCircleModel alloc]init];
        circle.ID = circleSearch.cId;
        circle.title = circleSearch.title;
        conversVC.circle = circle;
        
        [self.navigationController pushViewController:conversVC animated:YES];
    }
    */

    
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
                             @"c_id" : _circle.cId,
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
             JDFCircleModel *circle = [[JDFCircleModel alloc]init];
             
             circle.ID = circleSearch.cId;
             circle.title = circleSearch.title;
             conversVC.circle = circle;

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
