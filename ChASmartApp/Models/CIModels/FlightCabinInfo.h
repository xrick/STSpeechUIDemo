//
//  FlightCabinInfo.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightCabinInfoCollection : NSMutableArray

@end

@interface FlightCabinInfo : NSObject
@property (nonatomic,assign)NSString * CabinClass;
@property (nonatomic,assign)int SeatAvailable;
@end
