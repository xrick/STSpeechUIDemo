//
//  CIQueryDataItem.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 17/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIQueryArgument.h"
//This class is the first level of the object for Request

@interface CIQueryDataItemCollection : NSMutableArray


@end

@interface CIQueryDataItem : NSObject
{}
@property (nonatomic,assign) NSString * Major;
@property (nonatomic,assign) NSString * Minor;
@property (nonatomic,assign) NSString * AuthKey;
@property (nonatomic,assign) NSString * UniqueID; //UserID
@property (nonatomic,assign) NSString * BrainBuilderUID; //UserID
@property (nonatomic,assign) NSString * ConversationID; //UserID+OfficeID
@property (nonatomic,assign) NSString * Command;
@property (nonatomic,retain) CIQueryArgument * Argument;

@end
