//
//  CircleConversDetailViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/8/24.
//  Copyright © 2016年 ZhiYu Hao. All rights reserved.
//

#import "CircleConversDetailViewController.h"
#import "FTPopOverMenu.h"
#import "ReportTableViewController.h"
#import "MCNetTool.h"
#import "JDFTopicHeaderView.h"
#import "Convers.h"
#import "CircleTopicConverseRead.h"
#import "circleTopicCommentTableViewCell.h"
#import "JDFTopicHeaderView.h"
#import "UITableView+MJRefresh.h"
#import "UIViewController+MBShow.h"
#import "CircleCommentTableViewController.h"
#import "YXScrollowActionSheet.h"

#import "ShareModel.h"
#import "UIImage+MJ.h"

#import "DBHCommentCellTableViewCell.h"

#import "AgainTooicViewController.h"

#import "DBHTopicDataModels.h"

static NSString * const kCommentCellTableViewCellIdentifier = @"kCommentCellTableViewCellIdentifier";


@interface CircleConversDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,YXScrollowActionSheetDelegate>
{
    
    JDFTopicHeaderView *topicView;
    
    NSArray * _btnTitles;
    
    UIImage * _shareImage;
    CircleTopicConverseRead *circleRead;

    
}
@property (nonatomic ,weak) UIButton *btn;
@property (nonatomic, strong) UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentsLists;
@property (nonatomic, strong) NSString *commID;
@property (nonatomic, strong) NSMutableArray *reCommentsLists;

@property (nonatomic, strong) DBHTopicModelInfo *model;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *reCommentArray;

@property (nonatomic, strong) UIMenuController *menuController;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *com_id;
@property (nonatomic, assign) BOOL isType;

@end

@implementation CircleConversDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 400;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.title =@"话题";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    [right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [right setImage:[UIImage imageNamed:@"quanMore"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.automaticallyAdjustsScrollViewInsets= NO;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    [self.tableView registerClass:[DBHCommentCellTableViewCell class] forCellReuseIdentifier:kCommentCellTableViewCellIdentifier];
    
    self.tableView.tableHeaderView  = self.headerView;
    [self loadCircleTopicDetailData:NO hud:NO];
    [self addTableViewRefreshView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadCircleTopicDetailData:YES hud:NO];
    [self addTableViewRefreshView];
}
- (void)addTableViewRefreshView{
    
    [self.tableView headerAddMJRefresh:^{
        
        [self loadCircleTopicDetailData:YES hud:NO];
        
    }];
 
 
}

- (NSMutableArray *)commentsLists
{
    if (_commentsLists == nil) {
        _commentsLists = [NSMutableArray array];
    }
    return _commentsLists;
}

- (NSMutableArray *)reCommentsLists
{

    if (_reCommentsLists == nil) {
        _reCommentsLists = [NSMutableArray array];
    }
    return _reCommentsLists;
}


- (void)changeBtndStateWithIsType:(BOOL )type{
    
    
    _btnTitles =  type? @[@"分享",@"删除话题", @"开启评论",@"举报"]: @[@"分享",@"删除话题", @"禁止评论",@"举报"];
}



- (void)loadCircleTopicDetailData:(BOOL)firstPage hud:(BOOL)hud
{
    
    NSString *path = @"/app.php/Circles/conv_read";
    NSDictionary *params = @{
                             @"co_id":_c_id,
                             @"u_id":kUserId
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         self.model = [DBHTopicModelInfo modelObjectWithDictionary:requestDic];
         
         circleRead = [CircleTopicConverseRead yy_modelWithJSON:requestDic];
         
         topicView.ctcrModel = circleRead;
         
         
         NSArray *images = [circleRead.image componentsSeparatedByString:@"-"];
         if (images.count > 0)
         {
             [UIImage loadImageWithUrl:images[0] returnImage:^(UIImage *image) {
                 
                    _shareImage = image;
                 
             }];
                 
         }
         if (circleRead.image.length > 0)
         {
             CGRect frame = self.headerView.frame;
             frame.size.height = 385;
             self.headerView.frame = frame;
         }
         else
         {
             CGRect frame = self.headerView.frame;
             frame.size.height = 185;
             self.headerView.frame = frame;
         }
         
         
         _isType =([circleRead.gag_it integerValue] == 1?YES:NO);
         
         [self changeBtndStateWithIsType:_isType];
//
//         
//         
//         
//         NSArray * array  = [NSArray yy_modelArrayWithClass:[Comms_List class] json:circleRead.comms_list];
//         _commentsLists =[NSMutableArray arrayWithArray:array];
//         
//         
//         [self.tableView reloadData];
         [self.tableView headerEndRefresh];
         [self.tableView footerEndRefresh];
         
         
         
     }
                      fail:^(NSString *error) {
                          [self.tableView headerEndRefresh];
                          [self.tableView footerEndRefresh];
                          
                      }];
    
    
}

- (UIView *)headerView
{
    
    if (_headerView == nil) {
        CGRect frame = self.view.bounds;
        frame.size.height = 375;
        UIView *headerVeiw = [[UIView alloc] initWithFrame:frame];
        topicView = [[[UINib nibWithNibName:@"JDFTopicHeaderView" bundle:nil]instantiateWithOwner:nil options:nil] lastObject];
        topicView.frame = frame;
        [headerVeiw addSubview:topicView];
        _headerView = headerVeiw;
        
    }
    
    return _headerView;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return @"我的圈子";
//    }
//    
//    return @"热门圈子";
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
// 
//    static NSString *CellIdentiferId = @"circleTopicCommentTableViewCell";
//    circleTopicCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
//    if (cell == nil){
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"circleTopicCommentTableViewCell" owner:nil options:nil]lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//     return cell;
//
//
//
//}

#pragma mark ------ 数据源方法和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.commentArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DBHTopicModelCommsList *model = self.commentArray[section];
    
    return model.rCommentList.count + 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 162;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DBHTopicModelCommsList *model = self.commentArray[indexPath.section];
        circleTopicCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        _com_id = model.commId;
        _commID = model.commId;
        _name = model.uName;
        
        //初始化menu
        UIMenuController * menu = [UIMenuController sharedMenuController];
        
        NSMutableArray *menuItems = [NSMutableArray array];
        UIMenuItem *leftMenuItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(respondsLeftMenuItem)];
        [menuItems addObject:leftMenuItem];
        
        if ([model.uId isEqualToString:kUserId]) {
            UIMenuItem *rightMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(respondsRightMenuItem)];
            [menuItems addObject:rightMenuItem];
        }
        
        menu.menuItems = menuItems;
        
        //设置menu的显示位置
        CGRect rect = cell.bounds;
        rect.origin.y += 60;
        [menu setTargetRect:rect inView:cell.contentView];
        //让menu显示并且伴有动画
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - event responds
- (void)respondsLeftMenuItem {
    // 回复
    AgainTooicViewController *Again = [[UIStoryboard storyboardWithName:@"Again" bundle:nil] instantiateViewControllerWithIdentifier:@"AgainTooicViewController"];
    
    Again.comm_id = _com_id;
    Again.cid = _model.coId;
    Again.name = _name;
    Again.isOther = YES;
    
    [self.navigationController pushViewController:Again animated:YES];
}
- (void)respondsRightMenuItem {
    // 删除
    [self deletecopyItemClicked];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentiferId = @"circleTopicCommentTableViewCell";
        circleTopicCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
        if (cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"circleTopicCommentTableViewCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        DBHTopicModelCommsList *model = self.commentArray[indexPath.section];
        cell.model = model;
        
//        Comms_List *comms = _commentsLists[indexPath.row];
//        self.commID = comms.comm_id;
//        cell.commsList = comms;
        //    [cell.contentLabel addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
        
//        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
//        [cell.contentLabel addGestureRecognizer:longPress];
        return cell;
    } else {
        DBHTopicModelCommsList *model = self.commentArray[indexPath.section];
        DBHTopicModelRCommentList *otherModel = model.rCommentList[indexPath.row - 1];
        
        DBHCommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCellTableViewCellIdentifier forIndexPath:indexPath];
//        cell.object = model.uName;
        cell.otherModel = otherModel;
        
        [cell hideSeparation];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        CommentInfo *commen = [[CommentInfo alloc] init];
        DBHTopicModelCommsList *model = self.commentArray[indexPath.section];
        DBHTopicModelRCommentList *otherModel = model.rCommentList[indexPath.row - 1];
        commen.content = [NSString stringWithFormat:@"@@%@:%@", model.uName, otherModel.title];
        return [Tool getCommentHeight:commen];
    }
    return UITableViewAutomaticDimension;
}

-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer
{
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        UILabel *label = (UILabel *)longRecognizer.view;
        [label becomeFirstResponder];
        UIMenuController *menu=[UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(copyItemClicked:)];
        
        
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(resendItemClicked:)];
        UIMenuItem *resendItem1 = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(jubao:)];
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,resendItem1,nil]];
        [menu setTargetRect:label.frame inView:label.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}
#pragma mark 处理action事件
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action ==@selector(copyItemClicked:)){
        return YES;
    }else if (action==@selector(resendItemClicked:)){
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}
#pragma mark  实现成为第一响应者方法
-(BOOL)canBecomeFirstResponder{
    return YES;
}
#pragma mark method
-(void)resendItemClicked:(id)sender{
    if ([circleRead.u_id isEqualToString:kUserId]) {
        [self deletecopyItemClicked];
    }
    else
    {
     
            [self showToastWithMessage:@"你没有管理权限"];
      
    }

    NSLog(@"删除");
    //通知代理
    
    
    [self addTableViewRefreshView];
}

#pragma mark -------删除评论请求接口
- (void)deletecopyItemClicked
{
    NSString *path = @"/app.php/Circles/comment_del";
    NSDictionary *params  = @{ @"comm_id": self.commID};
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
//        [self showToastWithMessage:msg];
        
            [self loadCircleTopicDetailData:YES hud:NO];
            [self.tableView reloadData];
//        }
        
        
    } fail:^(NSString *error) {
        
    }];
    
}
-(void)copyItemClicked:(id)sender{
    NSLog(@"回复");
//    CircleCommentTableViewController *conversVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleCommentTableViewController"];
//    conversVC.coId = _c_id;
//    
//    [self.navigationController pushViewController:conversVC animated:YES];
    AgainTooicViewController *Again = [[UIStoryboard storyboardWithName:@"Again" bundle:nil] instantiateViewControllerWithIdentifier:@"AgainTooicViewController"];
    Again.coId = _c_id;
    Again.cooId = _commID;
    
    [self.navigationController pushViewController:Again animated:YES];
}
-(void)jubao:(id)sender{
    NSLog(@"举bao;");
    // 通知代理
    ReportTableViewController *reportTableViewlVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"ReportTableViewController"];
    reportTableViewlVC.cID = _c_id;
    [self.navigationController pushViewController:reportTableViewlVC animated:YES];
}


- (void)moreAction:(UIButton *)button
{
    _btn = button;
    [FTPopOverMenu showForSender:button
                        withMenu:_btnTitles /*@[@"分享",@"删除话题", @"禁止评论",@"举报"]*/
     //                  imageNameArray:@[@"setting_icon",@"setting_icon",@"setting_icon"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           if (selectedIndex == 0)
                           {
                               NSLog(@"你点击了分享");
                               
                               
                        #pragma mark ---------分享
                               YXScrollowActionSheet *cusSheet = [[YXScrollowActionSheet alloc] init];
                               cusSheet.delegate = self;
                               NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                                                         @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                                                         @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
                                                         @{@"name":@"微信",@"icon":@"sns_icon_7"},
                                                         @{@"name":@"朋友圈",@"icon":@"sns_icon_8"}];
                               
                               [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];
                               
                           }
                           else if (selectedIndex == 1)
                           {
                               //删除话题"
                               if ([circleRead.u_id isEqualToString:kUserId]) {
                                   
                                   [self deleteTopic];
                               }
                               
                               else
                               {
                                   
                                   [self showToastWithMessage:@"你没有管理权限"];
                               }
                           }
                           else if (selectedIndex == 2)
                           {
                               //禁止评论
                               [self prohibitComments];
                               
                           }
                           else if (selectedIndex == 3)
                           {
                               //举报
                               ReportTableViewController *reportTableViewlVC = [[UIStoryboard storyboardWithName:@"CircleContentView" bundle:nil]instantiateViewControllerWithIdentifier:@"ReportTableViewController"];
                               reportTableViewlVC.cID = _c_id;
                               [self.navigationController pushViewController:reportTableViewlVC animated:YES];
                               
                           }
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}

#pragma mark ------分享代理
#pragma mark - YXScrollowActionSheetDelegate
- (void) scrollowActionSheetButtonClick:(YXActionSheetButton *) btn
{
    NSLog(@"第%li个按钮被点击了",(long)btn.tag);
    
 
    /*!
     *  @author fhj, 15-07-30 21:07:39
     *
     *  @brief  友盟默认分享页面
     *
     *  @param vc        控制器
     *  @param image     分享的图片
     *  @param detaileId 分享的 id
     *  @param title     分享的标题
     *  @param desc      分享的内容
     *  @param type      分享的类型（鸟网论坛：1  鸟网电商：2）
     */
    if (_shareImage  == nil) {
        [ShareModel shareUMengWithVC:self withPlatform:btn.tag withTitle:circleRead.title
                        withShareTxt:circleRead.content
                           withImage:nil
                              withID:circleRead.co_id
                            withType:2 withUrl:nil
                             success:^(NSDictionary *requestDic) {
                                 
                                 
                                 
                                 
                             } failure:^(NSString *error) {
                                 
                             }];

    }
    else
    {
        
        [ShareModel shareUMengWithVC:self withPlatform:btn.tag withTitle:circleRead.title
                        withShareTxt:circleRead.content
                           withImage:_shareImage
                              withID:circleRead.co_id
                            withType:2 withUrl:nil
                             success:^(NSDictionary *requestDic) {
                                 
                                 
                                 
                                 
                             } failure:^(NSString *error) {
                                 
                             }];
        

    
    }
    
    
}


- (void)deleteTopic
{
    [self showAlertWithTitle:@"确认删除" message:@"删除后此话题及所有的评论将无法恢复，确认删除？"];
}
#define TagLogoutAlert   20

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
    alert.tag = TagLogoutAlert;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    
    if(buttonIndex == 0)
    {
        //点击取消按钮不做什么操作
        NSLog(@"点击取消按钮不做什么操作");
    }
    else
    {
        NSLog(@"你点击了确定按钮" );
        //删除评论时走这个接口
        [self deleteCircleTopicData];
        
    }
}

//删除话题请求数据
- (void)deleteCircleTopicData
{
    
    NSString *path = @"/app.php/Circles/comm_del";
    
    NSDictionary *params = @{@"co_id" :_c_id};
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
     {
         NSLog(@"你的已经删除了");
         [self.navigationController popViewControllerAnimated:YES];
         
     }fail:^(NSString *error) {
         
         
     }];
    
    
    
    
    [self showToastWithMessage:@"你没有管理权限"];
    
    
}



#pragma mark -----禁止评论
- (void)prohibitComments
{
    
    if ([circleRead.u_id isEqualToString:kUserId])
    {
        NSString *path = @"/app.php/Circles/gag_it";
        NSDictionary *params = @{
                                 @"co_id" : _c_id,
                                 
                                 @"type" : _isType ? @"2":@"1",
                                 
                                 };
        [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg)
         {
             [self showToastWithMessage:msg];
             
             _isType =!_isType;
             
             [self changeBtndStateWithIsType:_isType];
             [self addTableViewRefreshView];
             
             topicView.isHideComent = _isType;
             
         }fail:^(NSString *error) {
             
             
         }];
        
    }
    else
        
    {
        [self showToastWithMessage:@"你没有管理权限"];
    }
    
}


#pragma mark - getters and setters
- (void)setModel:(DBHTopicModelInfo *)model {
    _model = model;
    
    [self.commentArray removeAllObjects];
    
    for (DBHTopicModelCommsList *commsListModel in _model.commsList) {
//        DBHTopicModelCommsList *commsListModel = dic;
        
        [self.commentArray addObject:commsListModel];
    }
    
    [self.tableView reloadData];
}

- (UIMenuController *)menuController {
    if (!_menuController) {
        _menuController = [UIMenuController sharedMenuController];
        [_menuController setMenuVisible:YES animated:YES];
    }
    return _menuController;
}

- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

@end
