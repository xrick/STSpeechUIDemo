//
//  ViewController.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 29/09/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Speech/Speech.h>
#import "SpeechToTextFacade.h"
#import "TextToSpeechFacade.h"
#import "UIRenderProxy.h"
#import "ReachabilityFacade.h"
#import "AgentFacade.h"
#import "CI_ENUM.h"
@interface MainViewController : UIViewController<TextToSpeechFacadeDelegate, SpeechToTextDelegate,ReachabilityDelegate, LayoutDelegate,NSURLSessionDelegate> //TextToSpeechFacadeDelegate
{
//    SFSpeechRecognizer *speechRecognizer;
//    SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
//    SFSpeechRecognitionTask *recognitionTask;
//    AVAudioEngine *audioEngine;
    //RecordingButton * _recBtnContainer;
    
}

@property (nonatomic,retain) SpeechToTextFacade * SpeechToTextProxy;
@property (nonatomic,retain) TextToSpeechFacade * TextToSpeechProxy;
@property (nonatomic,retain) UIRenderProxy * renderProxy;
@property (nonatomic,assign) AgentFacade * agentProxy;
//-(void)SetButton;
//
//-(void)SetTextView;
//@property (nonatomic) int MessageCount;
//@property (nonatomic,retain) RecordUIView * recordView;
//@property (nonatomic,retain) UIButton * recButton;
//@property (nonatomic,retain) UITextView * txtView;
@end

