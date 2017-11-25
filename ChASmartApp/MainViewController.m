//
//  ViewController.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 29/09/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "MainViewController.h"
#import "TestData.h"
#import "CIJsonProcessor.h"

//#import "STBubbleTableViewCell.h"


@interface MainViewController (){
    NSTimeInterval _launchTimeInterval;//App開啟時間
    BOOL _isRecording;//正在錄音
    int _inputType;//0:一般，1:哈拉，2:點餐...，由IQAgent提供清單，使用者可選擇。（暫定為0）
    NSString *_questionStr;//使用者問的問題
    NSString *_answerStr;//電腦人回答的答案
    
    ContentItem *_contentItem;//電腦人回答的item
}
@property (nonatomic, strong) NSMutableArray * MessageArray;
@end

@implementation MainViewController
//@synthesize recButton;
//@synthesize txtView;
@synthesize SpeechToTextProxy;
@synthesize TextToSpeechProxy;
@synthesize renderProxy;
@synthesize agentProxy;

- (void)viewDidLoad {
    [super viewDidLoad];
    _launchTimeInterval = [[NSDate date] timeIntervalSince1970];
    
    [self setTextToSpeechProxy];
    [self setSpeechToTextProxy];
    [self setUIRenderProxy];
    [self layoutDelegateUpdateLayoutServiceBySetting];
    self.navigationController.navigationBar.hidden = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)setUIRenderProxy {
    if (!self.renderProxy) {
        UIRenderProxy * proxy = [[UIRenderProxy alloc] initWithContainerViewController:self];
        self.renderProxy = proxy;
        self.renderProxy.delegate = self;
    }
}

#pragma mark - initial Facade Objects

- (void)setTextToSpeechProxy {
    if (!TextToSpeechProxy) {
        TextToSpeechFacade *proxy = [[TextToSpeechFacade alloc] init];
        proxy.delegate = self;
        TextToSpeechProxy = proxy;
    }
}

- (void)setSpeechToTextProxy {
    if (!SpeechToTextProxy) {
        SpeechToTextFacade *proxy = [[SpeechToTextFacade alloc] init];
        proxy.delegate = self;
        SpeechToTextProxy = proxy;
    }
}



-(void)setBasicUI
{
    //self.renderProxy 
}

#pragma mark LayoutDelegate

-(void)layoutDelegateUpdateLayoutServiceBySetting
{
    if(self.renderProxy)
    {
        [self.renderProxy setViewController];
    }
    else{
        NSLog(@"renderProxy is null");
    }
}

-(void)layoutDelegateQuestionText:(NSString *)text
{
    [self speechToTextDelegateResultText:text];
}

-(void)layoutDelegateSpeakButtonBegin
{
     [self speechToTextStartRecording];
}

-(void)layoutDelegateSpeakButtonCancel
{
    [self speechToTextCancelRecording];
}

-(void)layoutDelegateSpeakButtonEnd
{
    [self speechToTextStopRecording];
}

-(void)layoutDelegateUpdateSpeechToTextServiceBySetting
{
    [self.SpeechToTextProxy updateSpeechToTextServiceBySetting];
}

-(void)layoutDelegateUpdateSpeechToTextSpeakButton
{
    [self.renderProxy updateLayoutSpeakButton];
}

-(void)layoutDelegateSpeakButtonTapped
{
    [self speechToTextSpeakButtonTapped];
}

#pragma mark LayoutDelegate End

#pragma mark - SpeechToTextDelegate
- (void)speechToTextDelegateUpdateServiceBySetting {
    [self.SpeechToTextProxy updateSpeechToTextServiceBySetting];
}

- (void)speechToTextDelegateStopRecording {
    if (_isRecording) {
        [self speechToTextStopRecording];
    }
}

//實作
- (void)speechToTextDelegateResultText:(NSString *)text {
    if (text.length == 0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:@"請您再說一次"];
        [array addObject:@"對不起，我沒聽懂"];
        [array addObject:@"抱歉，我沒聽清楚"];
        [array addObject:@"抱歉，我不確定你說什麼"];
        [array addObject:@"我不確定你剛說什麼"];
        [array addObject:@"我不太確定你說了什麼"];
        [array addObject:@"我不太明白你的意思"];
        
        int random = arc4random()%array.count;
        text = [array objectAtIndex:random];
        [self textToSpeechWithText:text];
       // [self.renderProxy uiTextToSpeechWithText:text];
    } else {
        //[self agentQuestionWithQuestion:text]; //啟動agent
        
        //從這裏呼叫WebAPI
        //step 1: call web api to get json
        //NSString * callResult = [CIJsonProcessor callListSeatAvailableAPI:nil];//[self queryWebApi];
        //NSLog(@"The call result is %@",callResult);
        //step 2: parse json
        /*
         in the step 2 we must parse the json data into our data model, which means converting the json data to objective-c object containing
         the data of json data passed from the server.
         */
        //step 3: change ui
        //
        //[self.renderProxy.LayoutViewController uiAgentQuestionWithQuestion:text];//啟動 ui 的變更
        //if(is only text){
        //     [self.renderProxy.LayoutViewController uiAgentQuestionWithQuestion:text];
        //}else
        //{
        [self.renderProxy.LayoutViewController uiAgentQuestionWithQuestion:text];
        
        //update by contentitem
        /*
         dispatch_queue_t myQueue = dispatch_queue_create("My Queue", NULL);
         dispatch_async(myQueue, ^{
         });
         */
        dispatch_queue_t queryQueue = dispatch_queue_create("queryQueue", NULL);
        dispatch_async(queryQueue, ^{
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *uidStr = [defaults objectForKey:@"uid"];
            NSString *pwdStr = [defaults objectForKey:@"pwd"];
            
            NSDictionary * argDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"Query",@"Command",text,@"Question",@"TraditionalChinese",@"SourceLanguage",uidStr,@"UserId",pwdStr,@"Password",@"TPEC567",@"OfficeId",@"Datakey",@"RedisDataKey",@"datavalue",@"RedisDataValue",nil];
            
            NSData * argData = [CIJsonProcessor generatCallApiJSON:argDict withFlag:Query];
            NSDictionary * callResultData = [CIJsonProcessor performAPICall:argData];
            NSArray* arguments = (NSArray*)[callResultData objectForKey:@"Argument"];
            for(int idx  = 0 ; idx < arguments.count ; idx++){
                if([[arguments[idx] objectForKey:@"Type"] isEqualToString:@"DynamicObject"]){
                        NSLog(@"The payloadinfo is %@",[arguments[idx] objectForKey:@"Payload"]);
                }
                else if([[arguments[idx] objectForKey:@"Type"] isEqualToString:@"Text"]){
                    [self.renderProxy.LayoutViewController uiAgentQuestionWithQuestion:[arguments[idx] objectForKey:@"Payload"]];
                }
            }
            NSString * resultStr = [NSString stringWithFormat:@"The Return json is %@",callResultData];
            NSLog(@"the result string is %@",resultStr);
            //[self.renderProxy.LayoutViewController uiAgentQuestionWithQuestion:resultStr];
        });
        
        //[self.renderProxy.LayoutViewController uiLayouthWithContentItem:[TestData GenTestData]];
        
        
    }
}

-(NSString*)queryWebApi
{
/*
 {
     Command:"SaveDataToRedisAndQuery",
     RequestArgument:
     {
        Platform:"Website",
        Question:"查訂位",
        SupportedContentType:[0],
        SourceLanguage:0
     },
     UserArgument:
     {
        UserId:"999999",
        Password:"999999",
        OfficeId:"TPECI08CF"
     },
     RedisArgument:
     {
        RedisDataKey:"testKey",
        RedisDataValue:"testValue"
     }
}
*/
    //1. create NSDictionay for data to send
    NSError * error = nil;
    NSMutableDictionary * requestArguments = [[NSMutableDictionary alloc]init];
    [requestArguments setObject:@"WebSite" forKey:@"Platform"];
    [requestArguments setObject:@"Question" forKey:@"查訂位"];
    //NSArray * ary = [[NSArray alloc]initWithObjects:@1, nil];
    [requestArguments setObject:[[NSArray alloc]initWithObjects:@1, nil] forKey:@"SupportedContentType"];
    [requestArguments setObject:@"0" forKey:@"SourceLanguage"];
    
    NSMutableDictionary * userArguments = [[NSMutableDictionary alloc]init];
    [userArguments setObject:@"999999" forKey:@"UserId"];
    [userArguments setObject:@"999999" forKey:@"Password"];
    [userArguments setObject:@"TPECI08CF" forKey:@"OfficeId"];
    
    NSMutableDictionary * redisArguments = [[NSMutableDictionary alloc]init];
    [requestArguments setObject:@"testKey" forKey:@"RedisDataKey"];
    [requestArguments setObject:@"testValue" forKey:@"RedisDataValue"];
    
    //set root dictionary
    NSMutableDictionary * rootDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                              @"SaveDataToRedisAndQuery", @"Command",
                              requestArguments, @"RequestArgument",
                              userArguments,@"UserArgument",
                              redisArguments,@"RedisArgument",
                              nil];
    //2. Convert postDict to NSData and create your request
    //NSError *error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:rootDict options:kNilOptions error:&error];
    NSLog(@"Ths jsonData to send is %@",jsonData);
    NSURLResponse *response;
    NSData *localData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.184:8081/api/query"]];
    [request setHTTPMethod:@"POST"];
    NSString *result = @"";
    //3. And finally, send your request to the server:
   if (error == nil)
   {
       [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:jsonData];
        // Send the request and get the response
        localData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    }
   
    NSLog(@"Error occured : %@",error);
   
    return result;
}

- (void)speechToTextDelegateInternetOffline {
    [IQAlert showAlertView:ALERTVIEW_InternetOffline superVC:self];
}

#pragma mark - SpeechToText


- (void)speechToTextSpeakButtonTapped {
    if (_isRecording == NO) {
        [self speechToTextStartRecording];
    } else {
        [self speechToTextStopRecording];
    }
}

- (void)speechToTextStartRecording {
    if (_isRecording == NO) {
        _isRecording = YES;
        
        [self.TextToSpeechProxy stopSpeech];
        
        [self uiSpeechToTextStartRecording];
        //[self.SpeechToTextProxy startRecording];
        [self.SpeechToTextProxy performSelector:@selector(startRecording) withObject:nil afterDelay:0.15];
        //        [_speechToTextFacade startRecording];
    }
}

- (void)speechToTextStopRecording {
    if (_isRecording) {
        _isRecording = NO;
        
        [self.SpeechToTextProxy stopRecording];
        
        [self uiSpeechToTextStopRecording];
    }
}

- (void)speechToTextCancelRecording
{
    if (_isRecording)
    {
        [self.SpeechToTextProxy cancelRecording];
        
        [self uiSpeechToTextCancelRecording];
        
        _isRecording = NO;
    }
}

#pragma mark - text to speech
- (void)textToSpeechWithText:(NSString *)text {
    if (!_isRecording) {
        [self.TextToSpeechProxy textToSpeechWithText:text];
    }
}

#pragma mark - ui update while recording status change
- (void)uiSpeechToTextStartRecording {
    [self.renderProxy uiStartRecording];
}

#pragma mark UI


- (void)uiSpeechToTextStopRecording {
    [self.renderProxy uiStopRecording];
}

- (void)uiSpeechToTextCancelRecording {
    [self.renderProxy uiCancelRecording];
}

#pragma mark - agent
- (void)agentQuestionWithQuestion:(NSString *)questionStr {
    //_questionStr = questionStr;
    
    //    [_agentFacade connectAskQuestion:questionStr intputType:_inputType];
    //[agentProxy connectAskPolyResults:questionStr intputType:_inputType];
}


#pragma mark TextToSpeech Delegate

- (void)textToSpeechFacadeDelegateStartSpeakText:(NSString *)text {
    //[self textToSpeechUIWithText:text];
}

- (void)textToSpeechFacadeDelegateSpeakText:(NSString *)text characterRange:(NSRange)range {
        //[self textToSpeechUIWithText:text characterRange:range];
}

- (void)textToSpeechFacadeDelegateEndSpeakText:(NSString *)text {
        //[self textToSpeechUIWithText:text];
}

@end
