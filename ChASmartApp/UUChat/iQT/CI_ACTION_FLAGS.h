//
//  CI_ACTION_FLAGS.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 27/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#ifndef CI_ACTION_FLAGS_h
#define CI_ACTION_FLAGS_h
/*****/
#define Action_String_Length 8

//以下為處理不同種類的Card的Button，按下後的動作。
//每個2位數，十位為card的種類，個位為此種類中的次種類，代表更具體的意義
//故可以有九大類的card，每大類又可以有九類的子類別，所以共可分辨81種動作card。

#define CI_Business_Reg 11//@"RegBusiness_Action01"
#define CI_Economy_Reg 12//@"RegEconomy_Action02"
#define CI_Book_Flight_Confirm_Action 21//@"Confirm_Flight_Booking"

#endif /* CI_ACTION_FLAGS_h */
