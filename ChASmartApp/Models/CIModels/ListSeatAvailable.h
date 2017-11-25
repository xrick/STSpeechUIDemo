//
//  ListSeatAvailable.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"
#import "CI_ENUM.h"

@interface ListSeatAvailableCollection : NSMutableArray
@property (nonatomic,assign) Flight_Status DepatureOrReturn;

@end


@interface ListSeatAvailable : NSObject
@property (nonatomic,assign)FlightInfo* FlightInfo; //班機資訊。
@property (nonatomic,assign)FlightCabinInfoCollection * FlightInfoAry;
@end
