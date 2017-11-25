//
//  TicketTemplate.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberTicket.h"

@interface TicketTemplate : NSObject
@property (nonatomic,retain)MemberTicketCollection * MemberTicketArray;
//values : {“Selectable”,"Confirm","Change","View"}
@property (nonatomic,assign)NSString * ActionType;
@end
