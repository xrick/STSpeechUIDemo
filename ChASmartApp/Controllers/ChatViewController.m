//
//  ChatViewController.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 02/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "ChatViewController.h"
#import "WebViewController.h"
//chat
#import "UUInputFunctionView.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
//widget
#import "IQSound.h"
#import "CI_ACTION_FLAGS.h"

#define CELL_ID @"CELLID"

@interface ChatViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UUInputFunctionView *inputFunctionView;
@property (strong, nonatomic) ChatModel *chatModel;
@property (strong, nonatomic) UITableView *chatTableView;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic,assign) int inputViewOffSet;
@end

@implementation ChatViewController

//init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){}
    _inputViewOffSet = 20;
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark Keyboard

-(void)keyboardChange:(NSNotification *)notification {

    if (notification.name == UIKeyboardWillShowNotification) {
        NSDictionary *userInfo = [notification userInfo];
        NSTimeInterval animationDuration;
        UIViewAnimationCurve animationCurve;
        CGRect keyboardEndFrame;
        
        [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
        [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
        [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        
        _bottomConstraint.constant = keyboardEndFrame.size.height + INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT;
        [self.view layoutIfNeeded];
        //在這裏調整當鍵盤升起時，文字輸入框的位置。
        _inputFunctionView.frame = CGRectMake(0, keyboardEndFrame.origin.y - INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT,
                                              Main_Screen_Width, INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT);
        
        [UIView commitAnimations];
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        if (_inputFunctionView.frame.size.height != INPUTFUNCTIONVIEW_SPEAK_HEIGHT) {
            NSDictionary *userInfo = [notification userInfo];
            NSTimeInterval animationDuration;
            UIViewAnimationCurve animationCurve;
            CGRect keyboardEndFrame;
            
            [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
            [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
            [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:animationDuration];
            [UIView setAnimationCurve:animationCurve];
            
            _bottomConstraint.constant = INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT;
            [self.view layoutIfNeeded];
            
            _inputFunctionView.frame = CGRectMake(0, Main_Screen_Height - INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT, Main_Screen_Width, INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT);
            [UIView commitAnimations];
        }
    }
     
}


#pragma mark - TableView

//tableView Scroll to bottom
- (void)tableViewScrollToBottom {
    if (_chatModel.dataSource.count == 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_chatModel.dataSource.count-1 inSection:0];
    [_chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


- (void)tableViewRefresh:(id)sender {
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"讀取中..."];
    dispatch_async(dispatch_queue_create("loading...", NULL), ^{
        [NSThread sleepForTimeInterval:0.5];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉更新"];
            [_refreshControl endRefreshing];
        });
    });
}

#pragma mark DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"_chatModel dataSource count is %u",(int)section);
    return _chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
        cell.delegate = self;
    }
    [cell setMessageFrame:_chatModel.dataSource[indexPath.row]];
    return cell;
}


#pragma mark Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Template_Type cellType = ((UUMessageFrame*)_chatModel.dataSource[indexPath.row]).contentItem.message.attachment.payload.template_type;
    switch(cellType)
    {
        case Template_Type_Button:
        case Template_Type_Generic:
        case Template_Type_BookInfo:
        case Template_Type_CI_Query_Seat:
            return 245;
        case Template_Type_CI_Change_Confirm:
            return 300;
        default:
            return 245.0;
    }
    //NSLog(@"The class of _chatModel.dataSource[indexPath.row] is %@", [_chatModel.dataSource[indexPath.row] class]);
    //return [_chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}



#pragma mark - InputFunctionViewDelegate

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message {
    funcView.textViewInput.text = @"";
    [funcView changeSendBtnIsExistText:NO];
    
    if ([self.delegate respondsToSelector:@selector(layoutDelegateQuestionText:)]) {
        [self.delegate layoutDelegateQuestionText:message];
    }
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image {
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //    [dic setObject:image forKey:UUMESSAGE_KEY_PICTURE];
    //    [dic setObject:@(UUMessageTypeImage) forKey:UUMESSAGE_KEY_TYPE];
    //    [dic setObject:@(UUMessageFromMe) forKey:UUMESSAGE_KEY_FROM];
    //
    //    [self dealTheFunctionData:dic];
    
    ContentItem *item = [[ContentItem alloc] init];
    //item.message.attachment.payload.image = image;
    item.message.attachment.type = Message_Type_Image;
    item.recipient.from = Message_From_Other;
    
    [self handleContentItem:item];
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second {
    ContentItem *item = [[ContentItem alloc] init];
    item.message.attachment.payload.data = voice;
    item.message.attachment.payload.voiceTime = [NSString stringWithFormat:@"%d",(int)second];
    item.message.attachment.type = Message_Type_Audio;
    item.recipient.from = Message_From_Me;
    
    [self handleContentItem:item];
}

- (void)UUInputFunctionViewVoiceSpeakButtonTapped {
    if ([self.delegate respondsToSelector:@selector(layoutDelegateSpeakButtonTapped)]) {
        [self.delegate layoutDelegateSpeakButtonTapped];
    }
}

- (void)UUInputFunctionViewVoiceSpeakButtonBegin {
    if ([self.delegate respondsToSelector:@selector(layoutDelegateSpeakButtonBegin)]) {
        [self.delegate layoutDelegateSpeakButtonBegin];
    }
}

- (void)UUInputFunctionViewVoiceSpeakButtonEnd {
    if ([self.delegate respondsToSelector:@selector(layoutDelegateSpeakButtonEnd)]) {
        [self.delegate layoutDelegateSpeakButtonEnd];
    }
}

- (void)UUInputFunctionViewVoiceSpeakButtonCancel {
    if ([self.delegate respondsToSelector:@selector(layoutDelegateSpeakButtonCancel)]) {
        [self.delegate layoutDelegateSpeakButtonCancel];
    }
}

- (void)UUInputFunctionViewVoiceUpdateToType:(UUInputFunctionView_Type)type {
    switch (type) {
        case UUInputFunctionView_Type_Speak:
        {
            //狀況1：keyboard已升起，點按鈕，keyboard降下，變成typeSpeak
            //狀況2：點按鈕，變成typeSpeak
            //因此不寫在keyboardChange
            
            [UIView beginAnimations:nil context:nil];
            
            _bottomConstraint.constant = INPUTFUNCTIONVIEW_SPEAK_HEIGHT;
            [self.view layoutIfNeeded];
            
            _inputFunctionView.frame = CGRectMake(0, Main_Screen_Height - INPUTFUNCTIONVIEW_SPEAK_HEIGHT, Main_Screen_Width, INPUTFUNCTIONVIEW_SPEAK_HEIGHT);
            
            [UIView commitAnimations];
            
            [self tableViewScrollToBottom];
        }
            break;
            
        case UUInputFunctionView_Type_Keyboard:
        default:
        {
            //由keyboardChange控制
        }
            break;
    }
}

//- (void)dealTheFunctionData:(NSDictionary *)dic {
//    [_chatModel addSpecifiedItem:dic];
//    [_chatTableView reloadData];
//    [self tableViewScrollToBottom];
//}

- (void)handleContentItem:(ContentItem *)item {
    NSLog(@"handleContentItem called");
    NSLog(@"The ContentItem's type is : %d",(int)item.message.attachment.type);
    Message_From from = item.recipient.from;
    item.recipient.userIcon = [self getUserIconWithFrom:from];
    //item.recipient.userName = [self getUserNameWithFrom:from];
    
    [_chatModel addContentItem:item];
    NSLog(@"Add item to chatModel");
    [_chatTableView reloadData];
    [self tableViewScrollToBottom];
}

- (NSString *)getUserIconWithFrom:(Message_From)from {
    switch ([IQSetting sharedInstance].ITEM_LAYOUT_SERVICE.iDefault) {
        case 0:
        {
            switch (from) {
                case Message_From_Other: return @"BOT圖片.png";
                case Message_From_Me: return @"chat_headImage_me.png";
                    
                default: NSLog(@"error getUserIconWithFrom"); return @"";
            }
        }
            break;
            
        case 1:
        {
            switch (from) {
                case Message_From_Other: return @"chat_headImage_other_chat.png";
                case Message_From_Me: return @"chat_headImage_me.png";
                    
                default: NSLog(@"error getUserIconWithFrom"); return @"";
            }
        }
        default: NSLog(@"error getUserIconWithFrom"); return @"";
    }
}

- (NSString *)getUserNameWithFrom:(Message_From)from {
    switch (from) {
        case Message_From_Other:
        {
            NSString *fromOtherName = @"BoBo";
            fromOtherName = [[IQSetting sharedInstance] convertUserNameBySettingWithStr:fromOtherName];
            return fromOtherName;
        }
            break;
        case Message_From_Me: return @"Me";
            
        default: NSLog(@"error getUserNameWithFrom"); return @"";
    }
}

#pragma mark - UUMessageCellDelegate

- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId {
}

- (void)cellContentDidClick:(UUMessageCell *)cell image:(UIImage *)contentImage {
    
}

//- (void)cellTemplateButtonTapped:(UUCIBaseCellButton *)button {
-(void)cellTemplateButtonTapped:(UUTemplateButton *)button{
    //在這裏分流card button動作
    NSLog(@"The Action ID is %d",(int)button.ButtonActionID);
    switch (button.ButtonActionID) {
        case CI_Economy_Reg:
            break;
        case CI_Business_Reg:
            break;
        case CI_Book_Flight_Confirm_Action:
        
           if([button.accessibilityIdentifier isEqualToString:@"checkbok_unchecked"])
           {
               //1.alter the data table               
               //2.set the button image to checked
               NSLog(@"Change to checkbox_checked");
               [button setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
               [button setAccessibilityIdentifier:@"checkbox_checked"];
           }
           else{
               //1.alter the data table
               
               //2.set the button image to unchecked
               NSLog(@"Change to checkbox_unchecked");
               [button setImage:[UIImage imageNamed:@"checkbok_unchecked"] forState:UIControlStateNormal];
               [button setAccessibilityIdentifier:@"checkbok_unchecked"];
           }
            break;
        default:
            break;
    }
    /*
    switch (button.type) {
        case Button_Type_WebUrl:
        {
            WebViewController *viewController = [[WebViewController alloc] init];
            [viewController updateWithTemplateButton:button];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        case Button_Type_Postback:
            break;
            
        default:
            break;
    }*/
}

#pragma mark - UI

#pragma mark SpeechToText

- (void)uiStartRecording {
    [[IQSound sharedInstance] playKeySoundWithSoundID:@"0016"];
    //    [[IQSound sharedInstance] playVibration];
}

- (void)uiStopRecording {
   [_inputFunctionView endRecordVoiceWithDelegate:NO];
    
    [[IQSound sharedInstance] playKeySoundWithSoundID:@"0017"];
    //    [[IQSound sharedInstance] playVibration];
}

- (void)uiCancelRecording {
    [_inputFunctionView endRecordVoiceWithDelegate:NO];
    
    [[IQSound sharedInstance] playKeySoundWithSoundID:@"0018"];
    //    [[IQSound sharedInstance] playVibration];
}

#pragma mark Agent

- (void)uiAgentQuestionWithQuestion:(NSString *)questionStr {
    
    ContentItem *item = [[ContentItem alloc] init];
    item.message.text = questionStr;
    item.message.attachment.type = Message_Type_Text;
    item.recipient.from = Message_From_Me;
    [self handleContentItem:item];
}

#pragma mark Agent

- (void)uiTextToSpeechWithText:(NSString *)text {
    //text = @"test";//[[IQSetting sharedInstance] convertUserNameBySettingWithStr:text];
    
    ContentItem *item = [[ContentItem alloc] init];
    item.message.text = text;
    item.message.attachment.type = Message_Type_Text;
    item.recipient.from = Message_From_Other;
    
    [self handleContentItem:item];
}

- (void)uiTextToSpeechWithText:(NSString *)text characterRange:(NSRange)range {
    if (range.length == 0) {
        [self uiTextToSpeechWithText:text];
    }
    else {
        
        [self uiTextToSpeechWithText:text];
    }
}

- (void)uiLayouthWithContentItem:(id)item {
    ContentItem *contentItem = (ContentItem *)item;
    contentItem.message.text = [[IQSetting sharedInstance] convertUserNameBySettingWithStr:contentItem.message.text];
    
    [self handleContentItem:contentItem];
}

#pragma mark - SpeakButton

- (void)updateSpeakButton {
    [_inputFunctionView updateSpeakButtonControlEventBySetting];
}

#pragma mark - Factory

- (void)setNavigationBar {
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.title = @"中華航空公司員工訂票系統";
}

//- (UITableView *)getChatTableView {
- (void)setChatTableView {
    if (!_chatTableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.accessibilityLabel = @"chatTableView";
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView *superView = self.view;
        UIView *itemView = tableView;
        {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:itemView
                                                                          attribute:NSLayoutAttributeLeading
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:superView
                                                                          attribute:NSLayoutAttributeLeading
                                                                         multiplier:1
                                                                           constant:0];
            constraint.priority = 1000;
            [superView addConstraint:constraint];
        }
        
        {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:itemView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:superView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
            constraint.priority = 1000;
            [superView addConstraint:constraint];
        }
        
        {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:itemView
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:superView
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:0];
            constraint.priority = 1000;
            [superView addConstraint:constraint];
        }
        
        {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:superView
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:itemView
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1
                                                                           constant:INPUTFUNCTIONVIEW_TEXTBAR_HEIGHT];
            constraint.priority = 1000;
            [superView addConstraint:constraint];
            _bottomConstraint = constraint;
        }
        
        _chatTableView = tableView;
    }
}

//- (UIRefreshControl *)setRefresh {
- (void)setRefresh {
    if (!_refreshControl) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(tableViewRefresh:)
                 forControlEvents:UIControlEventValueChanged];
        [self setChatTableView];
        [self.chatTableView addSubview:refreshControl];
        _refreshControl = refreshControl;
        //_refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:IQLocalizedString(@"下拉更新", nil)];
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉更新"];
    }
}

//- (UUInputFunctionView *)getInputFunctionView {
-(void)setInputFunctionView {
    if (!_inputFunctionView) {
        UUInputFunctionView *inputFuncionView = [[UUInputFunctionView alloc] initWithSuperVC:self];
        inputFuncionView.delegate = self;
        [self.view addSubview:inputFuncionView];
        _inputFunctionView = inputFuncionView;
    }
}

//- (ChatModel *)getChatModel {
- (void)setChatModel {
    if (!_chatModel) {
        self.chatModel = [[ChatModel alloc]init];
        //self.chatModel.isGroupChat = NO;
    }
}

-(void)setDefaultUI{
    [self setNavigationBar];
    
    [self setChatTableView];
    [self setRefresh];
    [self setChatModel];
    [self setInputFunctionView];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
    [_inputFunctionView btnChangeStateTapped:nil];
}
/*
 - (void)getSpeakButton {
 if (!_speakButton) {
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 UIImage *image = [UIImage imageNamed:@"mic-gray"];
 [button setImage:image forState:UIControlStateNormal];
 UIImage *hightlightedImage = [UIImage imageNamed:@"mic-white"];
 [button setImage:hightlightedImage forState:UIControlStateHighlighted];
 [button addTarget:self action:@selector(speechToTextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:button];
 
 _speakButton = button;
 _speakButton.frame = CGRectMake(0, 0, 100, 100);
 _speakButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
 }

 }
 */

#pragma mark Text to Speech Delegates

#pragma mark Delegate

/*
 @protocol TextToSpeechFacadeDelegate <NSObject>
 - (void)textToSpeechFacadeDelegateStartSpeakText:(NSString *)text;
 - (void)textToSpeechFacadeDelegateSpeakText:(NSString *)text characterRange:(NSRange)range;
 - (void)textToSpeechFacadeDelegateEndSpeakText:(NSString *)text;
 */

- (void)textToSpeechFacadeDelegateStartSpeakText:(NSString *)text {
    //    [self textToSpeechUIWithText:text];
}


- (void)textToSpeechFacadeDelegateSpeakText:(NSString *)text characterRange:(NSRange)range {
    //    [self textToSpeechUIWithText:text characterRange:range];
}

- (void)textToSpeechFacadeDelegateEndSpeakText:(NSString *)text {
    //    [self textToSpeechUIWithText:text];
}

@end
