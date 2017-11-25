//
//  UIRenderProxy.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LayoutDelegate.h"
#import "BaseLayoutViewController.h"
#import "ContentItem.h"
#import "WebViewController.h"

typedef NS_ENUM(NSInteger, RenderType) {
    UIRender_Demo       = 0,
    UIRender_Chat          ,
    UIRender_Train
};

@interface UIRenderProxy : NSObject
{
    
}

@property (nonatomic,assign) id<LayoutDelegate> delegate;
@property (nonatomic,assign) UIViewController * containerViewController;
@property (nonatomic,assign) BaseLayoutViewController* LayoutViewController;
@property (nonatomic,assign) RenderType renderType;
@property (nonatomic,retain) WebViewController * webCtrl;
//@property (nonatomic,retain) ContentItem * _item;

//init
-(id)initWithContainerViewController:(UIViewController *)ContainerViewController ;

//update ui
-(void)updateLayoutSpeakButton;

//text to speech methods

- (void)uiTextToSpeechWithText:(NSString *)text;
- (void)uiTextToSpeechWithText:(NSString *)text characterRange:(NSRange)range;
- (void)uiLayoutWithContentItem:(ContentItem *)item;

//set container UI
-(void)setViewController;

//SpeechToText
- (void)uiStartRecording;
- (void)uiStopRecording;
- (void)uiCancelRecording;

//Agent
- (void)uiAgentQuestionWithQuestion:(NSString *)questionStr;

@end
