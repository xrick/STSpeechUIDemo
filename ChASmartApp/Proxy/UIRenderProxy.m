//
//  UIRenderProxy.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "UIRenderProxy.h"
#import "ChatViewController.h"
#import "AgentFacade.h"
#import "UUMessageTemplateCell.h"
#import "TestData.h"
#import "CIJsonProcessor.h"
@implementation UIRenderProxy
@synthesize delegate;
@synthesize containerViewController;
@synthesize LayoutViewController;
@synthesize renderType;
@synthesize webCtrl;
//@synthesize _item;
//init
-(id)initWithContainerViewController:(UIViewController *)ContainerViewController
{
    self = [super init];
    if(self)
    {
        self.containerViewController = ContainerViewController;
    }
    return self;
}

#pragma mark - some methods
- (void)updateLayoutSpeakButton {
    [self.LayoutViewController updateSpeakButton];
}

#pragma mark TextToSpeech

- (void)uiTextToSpeechWithText:(NSString *)text {
    [self.LayoutViewController uiTextToSpeechWithText:text];
}

- (void)uiTextToSpeechWithText:(NSString *)text characterRange:(NSRange)range {
    [self.LayoutViewController uiTextToSpeechWithText:text characterRange:range];
}

- (void)uiLayoutWithContentItem:(ContentItem *)item {
    [self.LayoutViewController uiLayouthWithContentItem:item];
}

#pragma mark - update ui

-(void)loadCIWebPage : (UIButton*)sender
{
    if(self.webCtrl == nil){
        self.webCtrl = [[WebViewController alloc]init];
        [self.webCtrl goToURL:@"https://calcfec.china-airlines.com/StaffTicketWeb/et_main.aspx"];
    }
    /*
     let transition:CATransition = CATransition()
     transition.duration = 0.5
     transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
     transition.type = kCATransitionPush
     transition.subtype = kCATransitionFromBottom
     self.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
     self.navigationController?.pushViewController(dstVC, animated: false)
     and type of transition you can use are
     
     kCATransitionFromLeft
     kCATransitionFromBottom
     kCATransitionFromRight
     kCATransitionFromTop
     */
    CATransition * transition = [[CATransition alloc]init];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.LayoutViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.LayoutViewController.navigationController pushViewController:self.webCtrl animated:true];
}

-(void)setViewController
{
    CGRect frame = containerViewController.view.frame;
    if(!self.LayoutViewController)
    {
        ChatViewController *viewController = [[ChatViewController alloc] initWithFrame:frame];
        [containerViewController.view addSubview:viewController.view];
        self.LayoutViewController = viewController;
    }
    
    self.LayoutViewController.delegate = self.delegate; // set delegate.
    [self.containerViewController.navigationController pushViewController:self.LayoutViewController animated:NO];
    
    
    //set swith to CI web page icon on navigation bar
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"cloud36"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadCIWebPage:) forControlEvents:UIControlEventTouchUpInside];
    UIView * customView = [[UIView alloc]init];
    customView.frame = CGRectMake(15, 0, 32, 32);
    btn.frame = CGRectMake(0, 0, 32, 32);
    [customView addSubview:btn];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    [LayoutViewController.navigationItem setLeftBarButtonItem:leftBarItem];
    
    
    self.LayoutViewController.title = @"中華航空員工優待機票系統";//[self getNavigationTitleStr];
    /*
     backItem = UIBarButtonItem()
     backItem.title = "Back"
     navigationItem.backBarButtonItem = backItem
     */
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    LayoutViewController.navigationItem.backBarButtonItem = backItem;
    //UIImageView * navImgView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 5, 164.8, 28)];
    //[navImgView setImage:[UIImage imageNamed:@"China_Airlines"]];
    //self.LayoutViewController.navigationItem.titleView = navImgView;
    [self.LayoutViewController setDefaultUI];
    
    [self uiTextToSpeechWithText:@"您可以直接用說的來查詢班次。"];//[self getOpeningShowStr]

//    [self uiLayoutWithContentItem:[self CIQuerySeatTest]];
//    [self uiLayoutWithContentItem:[self CIQuerySeatTest3]];
//    [self uiLayoutWithContentItem:[self CIQuerySeatTest2]];
}

-(ContentItem*)CIQuerySeatTest
{
//    if(_item == nil){
     ContentItem* _item = [[ContentItem alloc]init];
//    }
    //_item.message.text = @"Test Data";
    _item.message.attachment.type = Message_Type_Template;
    _item.recipient.from = Message_From_Other;
    _item.message.attachment.payload.template_type = Template_Type_CI_Query_Seat;
    //_item.agent.service = Agent_Service_AskPolyResults;
    
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (int i=0; i<3; i++)
    {
        Element *element = [[Element alloc] init];
        //element.image_url = @"fadfa";
        element.index = 3 ;
        //element.title = @"fwrbrgrb";
        //element.subtitle = @"fbgbgb";
        [elements addObject:element];
    }
    _item.message.attachment.payload.elements = elements;
    return _item;
}

-(ContentItem*)CIQuerySeatTest2
{
    ContentItem* _item = [[ContentItem alloc]init];
    //_item.message.text = @"Test Data";
    _item.message.attachment.type = Message_Type_Template;
    _item.recipient.from = Message_From_Other;
    _item.message.attachment.payload.template_type = Template_Type_CI_Confirm_Booking;
    //_item.agent.service = Agent_Service_AskPolyResults;
    
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (int i=0; i<3; i++)
    {
        Element *element = [[Element alloc] init];
        //element.image_url = @"fadfa";
        element.index = 3 ;
        //element.title = @"fwrbrgrb";
        //element.subtitle = @"fbgbgb";
        [elements addObject:element];
    }
    _item.message.attachment.payload.elements = elements;
    return _item;
}

-(ContentItem*)CIQuerySeatTest3
{
    ContentItem* _item = [[ContentItem alloc]init];
    //_item.message.text = @"Test Data";
    _item.message.attachment.type = Message_Type_Template;
    _item.recipient.from = Message_From_Other;
    _item.message.attachment.payload.template_type = Template_Type_CI_Change_Confirm;
    //_item.agent.service = Agent_Service_AskPolyResults;
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (int i=0; i<3; i++)
    {
        Element *element = [[Element alloc] init];
        //element.image_url = @"fadfa";
        element.index = i ;
        //element.title = @"fwrbrgrb";
        //element.subtitle = @"fbgbgb";
        [elements addObject:element];
    }
    _item.message.attachment.payload.elements = elements;
    return _item;
}

- (void)deallocLayoutViewController {
    if (self.LayoutViewController) {
        [self.containerViewController.navigationController popToRootViewControllerAnimated:NO];
        self.LayoutViewController = nil;
    }
}
#pragma mark SpeechToText

- (void)uiStartRecording {
    [self.LayoutViewController uiStartRecording];
}

- (void)uiStopRecording {
    [self.LayoutViewController uiStopRecording];
}

- (void)uiCancelRecording {
    [self.LayoutViewController uiCancelRecording];
}

#pragma mark - Agent
- (void)uiAgentQuestionWithQuestion:(NSString *)questionStr
{
    [self.LayoutViewController uiAgentQuestionWithQuestion:questionStr];
}

@end
