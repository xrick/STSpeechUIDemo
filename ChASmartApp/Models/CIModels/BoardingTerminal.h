//
//  BoardingTerminal.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"
@interface BoardingTerminal : NSObject
@property (nonatomic,assign)NSString* BoardingTerminalInfo;
@property (nonatomic,assign)FlightInfo* FlightInfo;
@end
