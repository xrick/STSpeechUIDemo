//
//  CIResponseDataItem.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIResponseArgument.h"

@interface CIResponseDataItemCollection : NSMutableArray

@end

@interface CIResponseDataItem : NSObject
@property(nonatomic,assign) NSString * Major;
@property(nonatomic,assign) NSString * Minor;
@property(nonatomic,assign) NSString * AuthKey;
@property(nonatomic,assign) NSString * Command;
@property(nonatomic,assign) Boolean IsSuccess;
@property(nonatomic,retain) CIResponseArgumentCollection* ArgumentArray;
@end
