//
//  TLChatInputView.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "TLChatInputView.h"
#import "LPlaceholderTextView.h"
#import "TLPluginBoardView.h"
#import "TLChatEmojiBoard.h"
#import "TLPhotoPickerViewController.h"

typedef NS_ENUM(NSUInteger, BoardAction) {
    BoardActionChangeEmojiBoard = 1,
    BoardActionChangePluginBoard,
    BoardActionShowKeyBoard,
    BoardActionHideAllBoard
};

//最大输入字数
static NSInteger maxInputLength = 300;
//输入框最大高度
static CGFloat   maxInputTextViewHeight = 60.0f;

@interface TLChatInputView ()
<UITextViewDelegate,
TLPluginBoardViewDelegate,
TLChatEmojiBoardDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TLPhotoPickerDelegate>

@property(nonatomic,weak)TLChatViewController *chatVc;
@property(nonatomic,strong)UIButton *emojiKeyboardBtn;
@property(nonatomic,strong)UIButton *pluginBoardBtn;

@property(nonatomic,strong)LPlaceholderTextView *inputTextView;
 @property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)TLPluginBoardView *pluginBoard;
@property(nonatomic,strong)TLChatEmojiBoard *emojiBoard;

@property(nonatomic,strong)UITapGestureRecognizer *touchTap;
@property(nonatomic,strong)PHImageRequestOptions *options;
@end

@implementation TLChatInputView
{
    //记录上一次chattableview的contentoffset以便只在其变化时修改
    CGFloat _lastContentOffset;
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"emojiBtnSelected"];
//     [self removeObserver:self forKeyPath:@"selected"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithChatVc:(TLChatViewController *)vc{
    if (self = [super init]) {
        self.chatVc = vc;
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
 
        
        [self addSubview:self.inputTextView];
        [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);

            make.top.equalTo(self.mas_top).offset(6);
            make.bottom.equalTo(self.mas_bottom).offset(-6);
        }];
        

        
        [self addSubview:self.emojiKeyboardBtn];
//        [self removeObserver:self forKeyPath:@"emojiBtnSelected"];
        [self addObserver:self forKeyPath:@"emojiBtnSelected" options:NSKeyValueObservingOptionPrior context:nil];
        [self.emojiKeyboardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(0);
            make.size.mas_offset(CGSizeMake(30, 44));
        }];
        
        [self addSubview:self.pluginBoardBtn];
        [self.pluginBoardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.emojiKeyboardBtn.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.mas_top).offset(0);
            make.size.mas_offset(CGSizeMake(30, 44));
        }];
        
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.height.mas_offset(@0.5);
        }];
        
        [self.chatVc.view addSubview:self.pluginBoard];
        [self.pluginBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.chatVc.view.mas_left).offset(0);
            make.right.equalTo(self.chatVc.view.mas_right).offset(0);
            make.bottom.equalTo(self.chatVc.view.mas_bottom).offset(pluginBoardHeight);
            make.height.mas_offset(pluginBoardHeight);
        }];
        
        [self.chatVc.view addSubview:self.emojiBoard];
        [self.emojiBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.chatVc.view.mas_left).offset(0);
            make.right.equalTo(self.chatVc.view.mas_right).offset(0);
            make.bottom.equalTo(self.chatVc.view.mas_bottom).offset(emojiBoardHeight);
            make.height.mas_offset(emojiBoardHeight);
        }];
        
//        [self.voiceKeybaordBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}
#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([object isEqual:self.voiceKeybaordBtn]) {
//        self.tapVoiceBtn.hidden = !self.voiceKeybaordBtn.selected;
//    }
}
- (void)keyboardWillShow:(NSNotification *)sender{
    NSDictionary *userInfo = [sender userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat offsetY = self.chatVc.chatTableView.contentSize.height - self.chatVc.chatTableView.bounds.size.height + keyboardRect.size.height;
    [self changeBoard:BoardActionShowKeyBoard height:keyboardRect.size.height offsetY:offsetY];
}

#pragma mark - TLPluginBoardViewDelegate
-(NSArray *)pluginBoardItems{
    TLPluginBoardItem *photo = [[TLPluginBoardItem alloc] initWithIcoNamed:@"actionbar_picture_icon" title:@"相册"];
    TLPluginBoardItem *can = [[TLPluginBoardItem alloc] initWithIcoNamed:@"actionbar_camera_icon" title:@"相机"];
    return @[photo,can];
}
-(void)pluginBoardDidClickItemIndex:(NSInteger)itemIndex{
    switch (itemIndex) {
        case 0:
        {
//            TLPhotoPickerViewController *vc = [[TLPhotoPickerViewController alloc] initWithDelegate:self];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            [self.chatVc presentViewController :nav animated:YES completion:nil];
            
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

        }
            break;
        case 1:
        {
            [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case 2:
        {
           
            
        }
        default:
            break;
    }
}


#pragma - mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString* mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation = image.imageOrientation;
        
        if(imageOrientation != UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
        
        [self.chatVc dismissViewControllerAnimated:YES completion:^{
            
            if (self.sendImageAction) self.sendImageAction(image);
            
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.chatVc dismissViewControllerAnimated:YES completion:nil];
}

#pragma - mark emojiBoardViewDelegate
-(void)chatEmojiBoarDidSelectEmoji:(NSString *)emoji{
    [self.inputView appendEmoji:emoji];
}
-(void)chatEmojiBoarDidClickBackspace{
    [self.inputView backspace];
}
-(void)chatEmojiBoarDidClickSend{
    [self.inputView sendMessage];
}


#pragma mark - textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage];
        return NO;
    }
    
    if ([textView.text length] > maxInputLength) {
        self.inputTextView.text = [textView.text substringWithRange:NSMakeRange(0, maxInputLength)];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.inputTextView.contentSize.height + 12);
        }];
    }
    
    return YES;
}
#pragma mark - 
-(void)didSendPhotos:(NSArray *)photos{
    for (PHAsset *item in photos) {
        [[PHImageManager defaultManager] requestImageForAsset:item targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:self.options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            RCImageMessage *msg = [RCImageMessage messageWithImage:result];
//            if (self.sendMsgAction) self.sendMsgAction(msg);
            
            
            //发送图片
            
        }];
    }
}

#pragma mark - buttonActions

-(void)didClickMoreAcion:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.emojiKeyboardBtn.selected = NO;
    [self changeBoard:BoardActionChangeEmojiBoard height:pluginBoardHeight offsetY:pluginBoardHeight];
    
}
-(void)didClickEmojiAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self changeBoard:BoardActionChangePluginBoard height:emojiBoardHeight offsetY:emojiBoardHeight];
        
     }else{
         
        [self.inputView becomeInputTextViewFirstResponder];
    }
}


#pragma mark - private
//处理几种键盘隐藏显示逻辑。。略复杂待优化
-(void)changeBoard:(BoardAction)board height:(CGFloat)height offsetY:(CGFloat)offsetY{
    BOOL showKeyBoard = NO;
    switch (board) {
        case BoardActionChangeEmojiBoard: {
            self.pluginBoard.show = !self.pluginBoard.show;
            self.emojiBoard.show = NO;
            showKeyBoard = NO;
            [self.inputView resignInputTextViewFirstResponder];
            break;
        }
        case BoardActionChangePluginBoard: {
            self.emojiBoard.show = !self.emojiBoard.show;
            self.pluginBoard.show = NO;
            showKeyBoard = NO;
            [self.inputView resignInputTextViewFirstResponder];
            break;
        }
        case BoardActionShowKeyBoard: {
            self.emojiBoard.show = NO;
            self.pluginBoard.show = NO;
            showKeyBoard = YES;
            self.emojiKeyboardBtn.selected = NO;
//            self.voiceKeybaordBtn.selected = NO;
            break;
        }
        case BoardActionHideAllBoard: {
            self.emojiBoard.show = NO;
            self.pluginBoard.show = NO;
            showKeyBoard = NO;
            break;
        }
    }
    
    BOOL pluginShow = self.pluginBoard.show;
    BOOL emojiSshow = self.emojiBoard.show;
    
    BOOL showBoard = pluginShow || emojiSshow || showKeyBoard;
    
    [self.pluginBoard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chatVc.view.mas_bottom).offset(pluginShow ? 0 : height);
    }];
    
    [self.emojiBoard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chatVc.view.mas_bottom).offset(emojiSshow ? 0 : height);
    }];
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chatVc.view.mas_bottom).offset(showBoard ? - height : 0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.chatVc.chatTableView beginUpdates];
        [self.chatVc.view layoutIfNeeded];
        [self.chatVc.chatTableView endUpdates];
    }];
    
    if (_lastContentOffset != offsetY && offsetY > 0) {
        [self.chatVc.chatTableView beginUpdates];
        [self.chatVc.chatTableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
        [self.chatVc.chatTableView endUpdates];
    }
    
    [self.chatVc scrollToBottom];
    
    _lastContentOffset = offsetY;
    
    [self.chatVc.chatTableView addGestureRecognizer:self.touchTap];
}
-(void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self.chatVc presentViewController:picker animated:YES completion:nil];
    }
}
-(void)appendEmoji:(NSString *)emoji{
    NSMutableString *text = [self.inputTextView.text mutableCopy];
    [text appendString:emoji];
    self.inputTextView.text = [text copy];
    
    self.inputTextView.text = text.length > maxInputLength ? [text substringWithRange:NSMakeRange(0, maxInputLength)] : [text copy];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.inputTextView.contentSize.height + 12);
    }];
}
-(void)backspace{
    [self.inputTextView deleteBackward];
}
- (void)sendMessage{
    NSString *text = self.inputTextView.text;
    if ([text isEqualToString:@""] || !text) {
        return;
    }
    
    // 发送文字
    if (self.sendMsgAction) self.sendMsgAction(text);
    
    self.inputTextView.text = @"";
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.inputTextView.contentSize.height + 12);
    }];
}

-(void)resignInputTextViewFirstResponder{
    if (self.inputTextView.isFirstResponder){
        [self.inputTextView resignFirstResponder];
    }
}
-(void)becomeInputTextViewFirstResponder{
    if (!self.inputTextView.isFirstResponder){
        [self.inputTextView becomeFirstResponder];
    }
}
-(BOOL)inputTextViewIsFirstResponder{
    return self.inputTextView.isFirstResponder;
}
- (void)tapHideKeyboard:(UITapGestureRecognizer *)tap{
    [self.inputView resignInputTextViewFirstResponder];
    [self hidePluginAndEmojiBoard];
    [self.chatVc.chatTableView removeGestureRecognizer:self.touchTap];
}
- (void)hidePluginAndEmojiBoard{
    self.emojiKeyboardBtn.selected = NO;
    [self changeBoard:BoardActionHideAllBoard height:emojiBoardHeight offsetY:0];
}


-(PHImageRequestOptions *)options{
    if (!_options) {
        _options = [[PHImageRequestOptions alloc] init];
    }
    return _options;
}
#pragma mark - gatter
-(UITapGestureRecognizer *)touchTap{
    if (!_touchTap) {
        _touchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideKeyboard:)];
        _touchTap.cancelsTouchesInView = NO;
    }
    return _touchTap;
}

-(UIButton *)emojiKeyboardBtn{
    if (!_emojiKeyboardBtn) {
        _emojiKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiKeyboardBtn setImage:[UIImage imageNamed:@"icon_xiaolian"] forState:UIControlStateNormal];
        [_emojiKeyboardBtn setImage:[UIImage imageNamed:@"icon_kyb"] forState:UIControlStateSelected];
        [_emojiKeyboardBtn addTarget:self action:@selector(didClickEmojiAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiKeyboardBtn;
}
-(UIButton *)pluginBoardBtn{
    if (!_pluginBoardBtn) {
        _pluginBoardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pluginBoardBtn setImage:[UIImage imageNamed:@"icon_+"] forState:UIControlStateNormal];
        [_pluginBoardBtn addTarget:self action:@selector(didClickMoreAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pluginBoardBtn;
}

-(LPlaceholderTextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[LPlaceholderTextView alloc] init];
        _inputTextView.font = [UIFont systemFontOfSize:13];
        _inputTextView.tintColor = UIColorFromRGB(0x999999);
        _inputTextView.placeholderText = @"聊点什么吧";
        _inputTextView.placeholderColor = UIColorFromRGB(0x999999);
        _inputTextView.layer.cornerRadius = 4.0;
        _inputTextView.delegate = self;
        _inputTextView.returnKeyType = UIReturnKeySend;
        _inputTextView.maxTextViewHeight = maxInputTextViewHeight;
        _inputTextView.layer.cornerRadius = 4.0f;
        _inputTextView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        _inputTextView.layer.borderWidth = 0.5;
        [_inputTextView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _inputTextView;
}
-(TLPluginBoardView *)pluginBoard{
    if (!_pluginBoard) {
        _pluginBoard = [[TLPluginBoardView alloc] initWithDelegate:self];
    }
    return _pluginBoard;
}
-(TLChatEmojiBoard *)emojiBoard{
    if (!_emojiBoard) {
        _emojiBoard = [[TLChatEmojiBoard alloc] init];
        _emojiBoard.delegate = self;
    }
    return _emojiBoard;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColorFromRGB(0xcccccc);
    }
    return _line;
}
@end
