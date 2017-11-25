//
//  ContentItem.h
//  IQAgent
//
//  Created by IanFan on 2016/12/6.
//  Copyright © 2016年 IanFan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Message_Type) {
    Message_Type_Text                       = 0, //文字
    Message_Type_Audio                      , //語音 (0)
    Message_Type_Image                      , //圖片
    Message_Type_Video                      , //影片
    Message_Type_File                       , //檔案
    Message_Type_Template                   , //模板 (5)
};

typedef NS_ENUM(NSInteger, Template_Type) {
    Template_Type_Button                 = 0,  //選項式
    Template_Type_Generic                   ,  //卡片式
    Template_Type_CI_Query_Seat             ,  //班機資訊
    Template_Type_BookInfo                  ,  //訂票資訊(單程)
    Template_Type_BookInfo_GO               ,  //訂票資訊(去程)
    Template_Type_BookInfo_Back             ,  //訂票資訊(回程)
    Template_Type_CI_Confirm_Booking        ,  //確認訂票(單程)(6)
    Template_Type_CI_Confirm_Booking_GO     ,  //確認訂票(去程)
    Template_Type_CI_Confirm_Booking_Back   ,  //確認訂票(回程)
    Template_Type_CI_Change_Confirm         ,  //變更確認(單程)
    Template_Type_CI_Change_Confirm_GO      ,  //變更確認(單程)
    Template_Type_CI_Change_Confirm_Back    ,  //變更確認(回程)
    Template_Type_CI_Change_First_Confirm  ,  //二次變更確認(單程)
    Template_Type_CI_Change_First_Confirm_GO  ,  //二次變更確認(單程)
    Template_Type_CI_Change_First_Confirm_Back,  //二次變更確認(回程)
    Template_Type_CI_Change_Final_Confirm  ,     //最後變更確認(單程)
    Template_Type_CI_Change_Final_Confirm_GO  ,  //最後變更確認(單程)
    Template_Type_CI_Change_Final_Confirm_Back,  //最後變更確認(回程)
    Template_Type_CI_Choose_Round              //選擇單程或來回程

};

typedef NS_ENUM(NSInteger, Button_Type) {
    Button_Type_WebUrl                   = 0, //網頁
    Button_Type_Postback                    , //回覆
    Button_Type_CheckBox                    , //CheckBox
    Button_Type_QucikReply                    //快速回覆。
};

typedef NS_ENUM(NSInteger, Message_From) {
    Message_From_Me                      = 0, // 自己發的
    Message_From_Other                      , // 對方發的
};

@interface ButtonItem : NSObject
@property (nonatomic, assign) Button_Type type;
//@property (nonatomic, retain) NSString *url;
//@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSAttributedString *attributedTitle;
@property (nonatomic, retain) NSString *payload;
-(id)init;
@end

@interface Element : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSMutableArray *buttons;
//@property (nonatomic, retain) NSString *image_url;
//@property (nonatomic, retain) NSString *title;
//@property (nonatomic, retain) NSString *subtitle;
//@property (nonatomic, retain) NSString *item_url;
-(id)init;
@end

@interface Payload : NSObject
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSString *voiceTime;
@property (nonatomic, assign) Template_Type template_type;
@property (nonatomic, retain) NSMutableArray *elements;
//@property (nonatomic, retain) NSString *text;
//@property (nonatomic, retain) NSString *url;
//@property (nonatomic, retain) UIImage *image;
-(id)init;
@end

@interface Attachment : NSObject
@property (nonatomic, assign) Message_Type type;
@property (nonatomic, retain) Payload *payload; //將華航案的物件放入這裏
-(id)init;
@end

@interface Message : NSObject
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) Attachment *attachment;
-(id)init;
@end

@interface Recipient : NSObject
//@property (nonatomic, retain) NSString *userID;
//@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userIcon;
@property (nonatomic, retain) NSString *sendTime;
@property (nonatomic, assign) BOOL showDateLabel;
@property (nonatomic, assign) Message_From from;
-(id)init;
@end

@interface AllTypesItem : NSObject
@property (nonatomic,assign) NSInteger typesID;//TypesID
@property (nonatomic,copy) NSString *text;//Text
@property (nonatomic,assign) NSInteger sequence;//Sequence
+ (AllTypesItem *)copyItem:(AllTypesItem *)item;
@end

@interface ResponseStatusItem : NSObject
@property (nonatomic,copy) NSString *errorCode;//ErrorCode
@property (nonatomic,copy) NSString *message;//Message
@property (nonatomic,copy) NSString *stackTrace;//StackTrace
+ (ResponseStatusItem *)copyItem:(ResponseStatusItem *)item;
@end

@interface Agent : NSObject
@property (nonatomic,assign) NSInteger service;//服務功能
@property (nonatomic,assign) BOOL result;//回傳結果
@property (nonatomic,assign) BOOL isSuccess;//回傳成功
@property (nonatomic,copy) ResponseStatusItem *responseStatusItem;//偵錯用
@property (nonatomic,copy) NSString *sessionID;//SessionID
@property (nonatomic,copy) NSArray *allTypesArray;//問答所有類型
@property (nonatomic,copy) NSString *question;//使用者問的問題
@property (nonatomic,copy) NSString *speakContent;//服務提供的答案。用以朗讀
@property (nonatomic,copy) NSString *showContent;//服務提供的答案。用以顯示
@property (nonatomic,copy) NSString *emotion;//表情
@property (nonatomic,copy) NSString *url;//網址
@property (nonatomic,assign) int inputType;//用以確認目前會傳的答案為哪類
+ (Agent *)copyItem:(Agent *)item;
+ (NSString *)getInputTypeName:(int)inputType agent:(Agent *)agent;
@end

@interface ContentItem : NSObject
@property (nonatomic, retain) Recipient *recipient;
@property (nonatomic, retain) Message *message;
-(id)init;
- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;
@end
