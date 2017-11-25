//
//  TicketChangeConfirm.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"
@interface TicketChangeConfirm : NSObject
@property(nonatomic,assign)NSString* BookingReference; //AB1234
@property(nonatomic,assign)FlightInfo* FligtBefore; //更改前班機資訊
@property(nonatomic,assign)NSString* CabinClassBefore; //Y
@property(nonatomic,assign)FlightInfo* FlightAfter;//更改後班機資訊
@property(nonatomic,assign)NSString* CabinClassAfter; //更改後艙等。
@end
