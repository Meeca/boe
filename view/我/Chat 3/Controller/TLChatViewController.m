//
//  TLChatViewController.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "TLChatViewController.h"
#import "TLProjectMacro.h"
#import "TLTextMessageCell.h"
#import "TLPhotoMessageCell.h"
#import "TLChatInputView.h"


#import "MessageModel.h"


@interface TLChatViewController ()
<UITableViewDelegate,
UITableViewDataSource>{



}

@property(nonatomic,strong)TLChatInputView *inputView;
@property(nonatomic,strong)NSMutableArray *messages;
@property (nonatomic, assign) NSInteger page;

@end

@implementation TLChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_offset(@45);
    }];
    
    [self.view addSubview:self.chatTableView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(0);
        make.bottom.equalTo(self.inputView.mas_top).offset(0);
    }];
    
    weakifySelf;
    //发送消息回调
    self.inputView.sendMsgAction =  ^(NSString  * x){
        strongifySelf;
        [self sendSixinMessage:x withMessageType:1];
    };

    self.inputView.sendImageAction =  ^(UIImage  * image){
        strongifySelf;
        [self sendImageWithImage:image];
    };
//    
//    NSString *const MJRefreshBackFooterIdleText = @"上拉可以加载更多";
//    NSString *const MJRefreshBackFooterPullingText = @"松开立即加载更多";
//    NSString *const MJRefreshBackFooterRefreshingText = @"正在加载更多的数据...";
//    NSString *const MJRefreshBackFooterNoMoreDataText = @"已经全部加载完毕";
    
    
    
    /*
     
     
     ceshi fen zhi
     
     */
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewMessageList:) name:@"siMessageNotificationKey" object:nil];
    //
     [self loadCircleDataWithFirstPage:YES hud:NO];
    
   
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        [self loadCircleDataWithFirstPage:NO hud:NO];

    }];
//    [header setTitle:MJRefreshBackFooterIdleText forState:MJRefreshStateIdle];
//    [header setTitle:MJRefreshBackFooterPullingText forState:MJRefreshStatePulling];
//    [header setTitle:MJRefreshBackFooterRefreshingText forState:MJRefreshStateRefreshing];
//    [header setTitle:MJRefreshBackFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
    _chatTableView.mj_header = header;

//     [_chatTableView headerAddMJRefresh:^{
//         [self loadCircleDataWithFirstPage:NO hud:NO];
//     }];
 
    
}
// 当推送来消息的时候刷新到最新消息
- (void)refreshNewMessageList:(NSNotification *)notification {
    [self loadCircleDataWithFirstPage:YES hud:NO];
}


#pragma mark --------调用私信详情接口
- (void)loadCircleDataWithFirstPage:(BOOL)firstPage hud:(BOOL)hud
{
    if (firstPage) {
        _page = 1;
        [_messages removeAllObjects];
    }
    NSString *path = @"/app.php/User/my_n_read";
    NSDictionary *params = @{
                             @"uid" :kUserId,
                             @"u_id" :_userId,
                             @"page" :@(_page),
                             @"pagecount" :@"20",
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
        _page++;
        if (requestDic &&  [requestDic isKindOfClass:[NSArray class]]) {
            
            NSArray *info = (NSArray *)requestDic;
            
            for (NSDictionary *dict in info) {
               MessageModel * messageModel = [MessageModel yy_modelWithJSON:dict];
                if ([messageModel.u_id isEqualToString:kUserId]) {
                     messageModel.messageType = MessageType_SEND;
                } else {
                     messageModel.messageType = MessageType_RECEIVE;

                }
                
                [_messages insertObject:messageModel atIndex:0];

            }
            
            [self.chatTableView reloadData];
            
            firstPage?[self scrollToBottom]:nil;
            
            firstPage?nil:[_chatTableView headerEndRefresh];
            
         }
    } fail:^(NSString *error) {
           firstPage?nil:[_chatTableView headerEndRefresh];

    }];

}


-(void)scrollToBottom{
    if (self.messages.count) {
        [self.chatTableView scrollToRowAtIndexPath:[self lastMessageIndexPath] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

#pragma mark -----发送私信
- (void)postPersonalMessage:(NSString *)messageContent messageType:(NSString *)messageType
{
    NSString *path = @"/app.php/User/my_n_add";
    /*
     get:/app.php/User/my_n_add
     u_id#接受者id
     uid#发送者id
     title#私信内容
     type#类型（1文本，2图片）
     

     */
    NSDictionary *params = @{
                             @"uid" :kUserId,
                             @"u_id" :_userId,
                             @"title" :messageContent,
                             @"type" :messageType,
                             };
    
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
    } fail:^(NSString *error) {
        
    }];

}

#pragma - mark tableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
     MessageModel * messageModel = self.messages[indexPath.row];
    MessageModel *lastMessageModel = [self lasetMsgWithIndex:indexPath.row];
    
    NSString * cellIdentifier;
    if (messageModel.type == 1) {
        cellIdentifier = @"textcell";
    }else{
        cellIdentifier = @"photocell";
     }
    
    TLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
//    weakifySelf;
//    cell.reSendAction = ^(RCMessage *msg){
//        strongifySelf;
//        msg.sentStatus = SentStatus_SENDING;
//        [self retrySendMessage:msg];
//    };
//    
//    cell.clickAvatar = ^(RCMessageDirection msgDirection){
//        
//    };
//    
    [cell updateMessage:messageModel showDate:(messageModel.created_at - messageModel.created_at > 60 * 5 * 1000)];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel * messageModel = self.messages[indexPath.row];
    MessageModel *lastMessageModel = [self lasetMsgWithIndex:indexPath.row];
    
    NSString * cellIdentifier;
    if (messageModel.type == 1) {
        cellIdentifier = @"textcell";
    }else{
        cellIdentifier = @"photocell";
    }

    CGFloat height = [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(TLMessageCell *cell) {
        [cell updateMessage:messageModel showDate:(messageModel.created_at - lastMessageModel.created_at > 60 * 5 * 1000)];
    }];
    return height;
}

#pragma - mark RCManagerDelegate

-(void)rcManagerReceiveMsg:(MessageModel *)msg{
    msg.messageStatus = MessageStatus_RECEIVED;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertMessage:msg];
    });
}

#pragma - mark private
-(void)sendSixinMessage:(NSString *)content withMessageType:(NSInteger )messageType{
    
    
    MessageModel * messageModel  =[[MessageModel alloc]init];
    messageModel.title = content;
    messageModel.messageType  = MessageType_SEND;
    messageModel.u_id = kUserId;
    messageModel.type = messageType;
    messageModel.image = kImage;
 
    [self insertMessage:messageModel];
    [self retrySendMessage:messageModel];
    
    
    NSString *path = @"/app.php/User/my_n_add";
     NSDictionary *params = @{
                             @"uid" :kUserId,
                             @"u_id" :_userId,
                             @"title" :content,
                             @"type" :@(messageType),
                             };
    [MCNetTool postWithUrl:path params:params hud:YES success:^(NSDictionary *requestDic, NSString *msg) {
        
    } fail:^(NSString *error) {
        
    }];

}

#pragma mark - 上传图片 然后发送
- (void)sendImageWithImage:(UIImage *)image{

    NSData * imageData = [[NSData alloc]init ];
    imageData = UIImageJPEGRepresentation(image, 1);

    
      NSDictionary *params = @{
                             @"image":image,
                              };
     [MCNetTool uploadDataWithURLStr:@"/app.php/User/image_add" withDic:params imageKey:@"image" withData:imageData uploadProgress:^(NSString *progress) {

    } success:^(NSDictionary *requestDic, NSString *msg) {

        NSString * imageUrl = requestDic[@"image_url"];
        
         [self sendSixinMessage:imageUrl withMessageType:2];
        
     } failure:^(NSString *error) {
        
    }];

}


- (void)insertMessage:(MessageModel *)message{
    if (!message.title) {
        return;
    }
    [self.messages addObject:message];
    
    [self.chatTableView insertRowsAtIndexPaths:@[[self lastMessageIndexPath]] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.chatTableView scrollToRowAtIndexPath:[self lastMessageIndexPath] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)retrySendMessage:(MessageModel *)message{
    
    
}

-(void)updateCellStatusWithMsg:(MessageModel *)msg{
    NSInteger index = [self.messages indexOfObject:msg];
    TLMessageCell *cell = [self.chatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell setMsgStatus:msg.messageStatus];
}

-(NSIndexPath *)lastMessageIndexPath{
    return [NSIndexPath indexPathForItem:self.messages.count - 1 inSection:0];
}
-(MessageModel *)lasetMsgWithIndex:(NSInteger)index{
    return index > 0 ? self.messages[index - 1] : nil;
}

#pragma - mark getter
-(NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}
-(UITableView *)chatTableView{
    if (!_chatTableView) {
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.backgroundColor = UIColorFromRGB(0xebebeb);
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _chatTableView.separatorColor = UIColorFromRGB(0xeeeeee);
        [_chatTableView registerClass:[TLTextMessageCell class] forCellReuseIdentifier:@"textcell"];
        [_chatTableView registerClass:[TLPhotoMessageCell class] forCellReuseIdentifier:@"photocell"];
     }
    return _chatTableView;
}
-(TLChatInputView *)inputView{
    if (!_inputView) {
        _inputView = [[TLChatInputView alloc] initWithChatVc:self];
    }
    return _inputView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
