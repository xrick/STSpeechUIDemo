//
//  UUMessageFrame.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#define ChatMargin 10       //间隔
#define ChatIconWH 36 //44       //头像宽高height、width(原本為44，華航案改為36)
#define ChatPicWH 240       //图片宽高200
#define ChatContentW 240    //内容宽度180

#define ChatTimeMarginW 15  //时间文本与边框间隔宽度方向
#define ChatTimeMarginH 10  //时间文本与边框间隔高度方向

#define ChatContentTop 15   //文本内容与按钮上边缘间隔
#define ChatContentLeft 25  //文本内容与按钮左边缘间隔
#define ChatContentBottom 15 //文本内容与按钮下边缘间隔
#define ChatContentRight 15 //文本内容与按钮右边缘间隔

#define ChatTimeFont [UIFont systemFontOfSize:12]
#define ChatNameFont [UIFont systemFontOfSize:14]
#define ChatContentFont [UIFont systemFontOfSize:24]

#define ChatTemplateLeftMargin  10
#define ChatTemplateSpacing      4
#define ChatTemplateImage      184
#define ChatTemplateTitle       22
#define ChatTemplateSubTitle    18
#define ChatTemplateButton      40
#define ChatTemplateElementW   225

/******華航案APP設定******/
//Constans for CI IQ Agent
#define CI_TEMPLATE_IMAGE_HEIGHT 186
#define CI_CARD_LOGO_BACKGROUND_IMAGE_WIDTH 225
#define CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT 93

////Query Seat Result Cell Frame
#define CI_CARD_QUERY_SEAT_RESULT_CELL_WIDTH 225
#define CI_CARD_QUERY_SEAT_RESULT_CELL_HEIGHT 93
//Base Cell Frame
#define DEFAULT_CI_BASE_CELL_FRAME_ORIGIN_X 48
#define DEFAULT_CI_BASE_CELL_FRAME_ORIGIN_Y 10
//Base Cell Button Frame
#define CI_BASE_CELL_BUTTON_WIDTH 40
#define CI_BASE_CELL_BUTTON_HEIGHT 20
////Font Data

//End of Definitions of CI IQ Agent

#define ChatTemplateTitleFont [UIFont boldSystemFontOfSize:20]
#define ChatTemplateSubtitleFont [UIFont systemFontOfSize:16]
#define ChatTemplateButtonFont [UIFont systemFontOfSize:20]

#import <Foundation/Foundation.h>
@class UUMessage;

@interface UUMessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign) BOOL showTime;
//@property (nonatomic, strong) UUMessage *message;
@property (nonatomic, strong) ContentItem *contentItem;

@end
