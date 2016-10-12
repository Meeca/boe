//
//  MosViewController.m
//  jingdongfang
//
//  Created by 郝志宇 on 16/7/10.
//  Copyright © 2016年 XuDong Jin. All rights reserved.
//

#import "MosViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "IWTextView.h"

@interface MosViewController () <UITableViewDataSource, UITableViewDelegate> {
    UserModel *userModel;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *table;

@end

@implementation MosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"简介";
    
    userModel = [UserModel modelWithObserver:self];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sure:)];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPPCOLOR} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeainEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

ON_SIGNAL3(UserModel, USERCONTENT, signal) {
    [Tool performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:.3];
}

#pragma mark — UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    CGFloat x = cell.separatorInset.left;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IWTextView *textView = [[IWTextView alloc] initWithFrame:CGRectMake(x, 15, KSCREENWIDTH-2*x, 135)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth = 1;
    textView.tag = indexPath.row;
    textView.placeholder = @"这里记录着你的辉煌与过往";
    textView.text = self.context;
    textView.keyboardType = UIKeyboardTypeDefault;
    [cell.contentView addSubview:textView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)textBeainEditing:(NSNotification *)not {
    if ([not.object isMemberOfClass:[IWTextView class]]) {
        self.table.bounces = YES;
    }
}

- (void)textEndEditing:(NSNotification *)not {
    if ([not.object isMemberOfClass:[IWTextView class]]) {
        self.table.bounces = NO;
    }
}

- (void)textChange:(NSNotification *)not {
    if ([not.object isMemberOfClass:[IWTextView class]]) {
        IWTextView *textView = not.object;
        if (textView.tag == 0) {
            UITextRange *markedRange = [textView markedTextRange];
            if (markedRange) {
                
                return;
            }
            
            if (textView.text.length > 50) {
                [self presentMessageTips:@"最多可输入50个字"];
                NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:50];
                textView.text = [textView.text substringToIndex:range.location];
            }
            self.context = textView.text;
        }
    }
}

- (void)sure:(UIBarButtonItem *)btn {
    [self.view endEditing:YES];

    [userModel app_php_User_user_content:self.context.length>0?self.context:@""];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
