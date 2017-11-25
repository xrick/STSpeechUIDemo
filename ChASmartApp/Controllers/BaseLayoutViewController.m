//
//  BaseLayoutViewController.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 02/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "BaseLayoutViewController.h"
#import "SettingViewController.h"

@interface BaseLayoutViewController ()<LayoutDelegate,SettingViewControllerDeleagte>
{
    BOOL _shouldUpdateLayout;
    BOOL _shouldUpdateSpeechToText;
    BOOL _shouldUpdateSpeakButton;
}
@end

@implementation BaseLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"didReceiveMemoryWarning class: %@",NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_shouldUpdateLayout) {
        _shouldUpdateLayout = NO;
        if ([self.delegate respondsToSelector:@selector(layoutDelegateUpdateLayoutServiceBySetting)]) {
            [self.delegate layoutDelegateUpdateLayoutServiceBySetting];
        }
    }
    
    if (_shouldUpdateSpeechToText) {
        _shouldUpdateSpeechToText = NO;
        if ([self.delegate respondsToSelector:@selector(layoutDelegateUpdateSpeechToTextServiceBySetting)]) {
            [self.delegate layoutDelegateUpdateSpeechToTextServiceBySetting];
        }
    }
    
    if (_shouldUpdateSpeakButton) {
        _shouldUpdateSpeakButton = NO;
        if ([self.delegate respondsToSelector:@selector(layoutDelegateUpdateSpeechToTextSpeakButton)]) {
            [self.delegate layoutDelegateUpdateSpeechToTextSpeakButton];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - init methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self){
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor whiteColor];
        [self setSettingBarButton];
    }
    return self;
}

#pragma mark Set Default UI

/*
 - (void)getDefaultUI {
 [self getNavigationBar];
 
 [self getChatTableView];
 [self getRefresh];
 
 [self getChatModel];
 [self getInputFunctionView];
 
 [_chatTableView reloadData];
 [self tableViewScrollToBottom];
 
 [_inputFunctionView btnChangeStateTapped:nil];
 }
 */
- (void)setDefaultUI {
    
}




#pragma mark Set Dafult UI End

#pragma mark - Command

- (void)speechToTextButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(layoutDelegateSpeakButtonTapped)]) {
        [self.delegate layoutDelegateSpeakButtonTapped];
    }
}

#pragma mark - LayoutDelegate

#pragma mark TextToSpeech

- (void)uiTextToSpeechWithText:(NSString *)text {
    
}

- (void)uiTextToSpeechWithText:(NSString *)text characterRange:(NSRange)range {
    
}

- (void)uiLayouthWithContentItem:(id)item {
    
}

#pragma mark - Speech to Text

- (void)uiStartRecording{
}

- (void)uiStopRecording{
    
}

- (void)uiCancelRecording{
    
}

#pragma mark - SpeakButton

- (void)updateSpeakButton{
    
}

- (void)settingTapped:(UIButton *)sender {
    SettingViewController *viewController = [[SettingViewController alloc] init];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark Delegate

- (void)settingViewControllerDeleagteUpdateLayout {
    _shouldUpdateLayout = YES;
}

- (void)settingViewControllerDeleagteUpdateSpeechToText {
    _shouldUpdateSpeechToText = YES;
}

- (void)settingViewControllerDeleagteUpdateSpeakButton {
    _shouldUpdateSpeakButton = YES;
}


#pragma mark - UI set
- (void)setSettingBarButton {
//    UIImage *settingImage = [UIImage imageNamed:@"icon_setting.png"];
//    CGRect settingFrame = CGRectMake(0, 0, 30, 30);
//    UIButton *settingsButton = [[UIButton alloc] initWithFrame:settingFrame];
//    [settingsButton setBackgroundImage:settingImage forState:UIControlStateNormal];
//    [settingsButton addTarget:self action:@selector(settingTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [settingsButton setShowsTouchWhenHighlighted:YES];
//    UIBarButtonItem *settingButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
//    self.navigationItem.rightBarButtonItem = settingButtonItem;
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(settingTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIView * customView = [[UIView alloc]init];
    customView.frame = CGRectMake(340, 0, 32, 32);
    btn.frame = CGRectMake(0, 0, 32, 32);
    [customView addSubview:btn];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

@end
