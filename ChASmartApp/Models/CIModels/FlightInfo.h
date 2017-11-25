//
//  FlightInfo.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightCabinInfoCollection : NSArray

@end

@interface FlightInfo : NSObject
@property(nonatomic,assign)NSString* AirlineCodeFlightNo; //CI101
@property(nonatomic,assign)NSString* DepartFrom; //出發地TPE
@property(nonatomic,assign)NSString* DepartFromCn;//出發地(中文)(桃園)
@property(nonatomic,assign)NSString* DepartDate; //出發日期2017/09/01
@property(nonatomic,assign)NSString* DepartTime; //出發時間 15:35
@property(nonatomic,assign)NSString* ArriveTo; //目的地 PEK
@property(nonatomic,assign)NSString* ArriveToCn; //日的地(北京)
@property(nonatomic,assign)NSString* ArriveDate; //到達日期(2017/09/01)
@property(nonatomic,assign)NSString* ArriveTime; //到達時間 19:05
@end
