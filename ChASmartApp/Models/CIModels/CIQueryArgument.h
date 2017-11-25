//
//  CIQueryArgument.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

//Argument for Request
@interface CIQueryArgument : NSObject
{}
///
/*
 Platform: 用以記錄呼叫平台
 值：
 “Unknown”
 “Website”
 “FacebookMessenger”
 “Line”
 “Slack”
 “Android”,
 “ios”
 */
///
@property (nonatomic,assign) NSString * Platform;

///
/*
 Question : 使用者輸入之語句, 例如："我要查桃園到東京的航班"
 */
///
@property (nonatomic,assign) NSString * Question;

///
///SupportedContentType : 在這裏，request時，只要給["Any"]
/*
 Any: 支援所有類型
 Text:一般文字
 Uri:網址
 StreamingUri:串流網址
 Video:影片檔
 VideoUri:影片網址
 Audio:音檔
 AudioUri:音樂網址
 Image:圖檔
 ImageUri: 圖檔網址
 Command特殊指令
 DynamicObject 動態物件
 */
///
@property (nonatomic,assign) NSString * SupportedContentType;

///
///(String)使用者提問的語言
///值：
///TraditionalChinese
///SimplifiedChinese
///English
@property (nonatomic,assign) NSString * SourceLangueage;
@end
