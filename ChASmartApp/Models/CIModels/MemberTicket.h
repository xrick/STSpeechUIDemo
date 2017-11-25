//
//  MemberTicket.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"
#import "Ticket.h"
#import "CI_ENUM.h"

@interface MemberTicketCollection : NSMutableArray

@end

@interface MemberTicket : NSObject
@property(nonatomic,assign)FlightInfo* FlightInfo;
@property(nonatomic,assign)TicketCollection* Tickets;
@property(nonatomic,assign)Action_Type ActionType;
@property(nonatomic,assign)Flight_Status DepartureOrReturn;
@end
