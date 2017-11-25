//
//  CI_Shared_Constants.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 24/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#ifndef CI_Shared_Constants_h
#define CI_Shared_Constants_h

//UIScreen main screen Rect
#define ApplicationScreenFrame UIScreen.mainScreen.bounds

#define CenterPoint CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2)
/*
 CI : 表示華航案
 QF : 表示查航班
 */
//****基本圖片、CEll、Frame、字型的設定****/
//第一個Bubble與contentView的左右margin
#define CI_Bubble_Left_Margin 48.0
#define CI_Bubble_Right_Margiin 47.0

//設定一個Card內部元件共用的left margin
#define _LEFT_MARGIN 10.0

//人頭icon的設定
//長與寬
#define CI_Avatar_WH 16.0

//顏色的共享設定
#define LoginButtonBKColor  [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1/1.0];

#define NavBarBKColor [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9/1.0]

#define NavBarBKColor2 [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1/1.0]

#define RegisterButtonBKColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0]

#define grayColor [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1/1.0]

#define textColor_White [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0]

//#define headBackColoer [UIColor colorWithRed:62/255.0 green:98/255.0 blue:173/255.0 alpha:1/1.0]
//與cell左邊的margin
#define CI_Avatar_Left_Margin 8.0

//******所有Bubbl的字型設定******/
#define CI_Font_PingFangTC_Medium_13 [UIFont fontWithName:@"PingFangTC-Medium" size:13]
#define CI_Font_PingFangTC_Medium_11 [UIFont fontWithName:@"PingFangTC-Medium" size:11]
#define CI_Font_PingFangTC_Medium_10 [UIFont fontWithName:@"PingFangTC-Medium" size:10]

#define CI_Font_Arial_BoldMT_20 [UIFont fontWithName:@"Arial-BoldMT" size:20]


//******查動態與查航班的文字設定*******/
//Cell中間的灰色分隔線
#define CI_Cell_Spliter_W 224.5
#define CI_Cell_Spliter_H 2.0

//Cell的長與寬
#define CI_QF_Cell_W 225.0
#define CI_QF_Cell_H 46.0

//整個Frame的設定
#define CI_QF_Frame_W 225.0
#define CI_QF_Frame_H 225.0//186.0 //(圖高+2個Cell高+一個spliter)
#define CI_Frame_Left_Margin 48.0
#define CI_Frame_Top_Margin 15.0

//所有的Head圖片的設定
#define CI_Head_ImageView_BK_Color [UIColor colorWithRed:62/255.0 green:98/255.0 blue:173/255.0 alpha:1/1.0]
#define CI_Bubble_Head_Image_W 200.0
#define CI_Bubble_Head_Image_H 92.0
#define CI_Bubble_Head_Image_Left_Margin 10.0
#define CI_Bubble_Head_Image_Top_Margin 10.0

//日期長與寬
#define CI_Query_Flight_Date_W 67.0
#define CI_Query_Flight_Date_H 10.0



//航班的長與寬
#define CI_Flight_Number_W 28.0
#define CI_Flight_Number_H 10.0


//航班的起迄地英文縮寫文字的長與寬
#define CI_Departure_Landing_W 58.0
#define CI_Departure_Landing_H 17.0

//白色飛機標誌
#define CI_Airplane_W 15.0
#define CI_Airplane_H 15.2

//#define CALL_API_TEMPLATE @"{\"Command\":\"%@\",\"RequestArgument\":{\"Platform\":\"ios\",\"Question\":\"%@\",\"SupportedContentType\":[0],\"SourceLanguage\":\"%@\"},\"UserArgument\":{\"UserId\":\"%@\",\"Password\":\"%@\",\"OfficeId\":\"%@\"},\"RedisArgument\":{\"RedisDataKey\":\"%@\",\"RedisDataValue\":\"%@\"}}" // 8 %@
/*
@"{\"Command\":\"@command\",\"RequestArgument\":{\"Platform\":\"iOS\",\"Question\":\"@question\",\"SupportedContentType\":[0],\"SourceLanguage\":\"@language\"},\"UserArgument\":{\"UserId\":\"@uid\",\"Password\":\"@pwd\",\"OfficeId\":\"@officeid\"},\"RedisArgument\":{\"RedisDataKey\":\"##rediskey##\",\"RedisDataValue\":\"##redisvalue##\"}}"
*/
//#define ArgDict_String_Template @"@\"%@\",@\"Command\",@\"%@\",@\"Question\",@\"%@\",@\"SourceLanguage\",@\"%@\",@\"UserId\",@\"%@\",@\"Password\",@\"%@\",@\"OfficeId\",@\"%@\",@\"RedisDataKey\",@\"%@\",@\"RedisDataValue\""
//航班的起迄地中文文字的長與寬
#define CI_Departure_Landing_ZH_W 43.0
#define CI_Departure_Landing_ZH_H 10.0


//航班起飛與到達時間文字
#define CI_QF_Time_W 30.0
#define CI_QF_Time_H 10.0



//按鈕文字的長與寬
#define CI_QF_Button_Text_W 27.0
#define CI_QF_Button_Text_H 13.0


//按鈕本身的長與寬
#define CI_QF_Button_W 42.0
#define CI_QF_Button_H 24.3

//****圖片與文字的Layput設定****//
//日期的位置
#define CI_Query_Flight_Date_X 16.0
#define CI_Query_Flight_Date_Y 16.2
//航班號碼的位置
#define CI_Flight_Number_X 177.0
#define CI_Flight_Number_Y 15.0


//***艙等文字各項設定
//艙等+':'+"座位數量"
#define CI_QR_Class_W 80.0//56.0//一個字14.0
#define CI_QR_Class_H 13.0//16.0

//商務艙文字的XY座標
#define CI_Business_X 20.0
#define CI_Business_Y 120.2

//經濟艙文字的XY座標
#define CI_Economy_X 20.0
#define CI_Economy_Y 163.8

//座位數量：(暫時不用)
//#define CI_QR_Available_Seat_Num_W 8.0 //(一個數字、或一個減號寬)
//#define CI_QR_Available_Seat_Num_H 16.0 ////(一個數字、或一個減號高)

//Constants for reference not for programming
#define CI_Minus_W 8.0
#define CI_Minus_H 16.0
#endif /* CI_Shared_Constants_h */
