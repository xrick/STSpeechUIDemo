//
//  CI_ENUM.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#ifndef CI_ENUM_h
#define CI_ENUM_h

typedef NS_ENUM(NSInteger, Flight_Status)
{
    None = 0,
    Depature,
    Return
};

typedef NS_ENUM(NSInteger, Action_Type)
{
  Selectable = 0,
  Confirm,
  Change,
  View
};

typedef NS_ENUM(NSInteger, CI_Platform_Type){
    CI_API_WEB        = 1,
    CI_API_iOS           ,
    CI_API_Android
};
/*
 SaveDataToRedisAndQuery”,
 ”Query”,
 ”GetUserInfo”
 “ NameList”
 */
typedef NS_ENUM(NSInteger, CI_Command_Type){
    SaveDataToRedisAndQuery    = 1,
    Query,
    GetUserInfo,
    NameList
};

typedef NS_ENUM(NSInteger, CI_DynamicObject_Type){
    ListSeatAvailableArray  = 1,
    TicketsTemplate,
    QuickReply,
    TicketChangeConfirm,
    BoardingTerminal
};
#endif /* CI_ENUM_h */
