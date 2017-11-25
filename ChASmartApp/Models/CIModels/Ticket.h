//
//  Ticket.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketCollection : NSMutableArray

@end

@interface Ticket : NSObject
@property(nonatomic,assign)NSString* CName; //中文名
@property(nonatomic,assign)NSString* EName; //英文名
@property(nonatomic,assign)NSString* TicketNumber; //機票號碼
@property(nonatomic,assign)NSString* IssueDate; //開票日期
@property(nonatomic,assign)NSString* CabinClass; //Y
@end
