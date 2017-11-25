//
//  CIResponseArgument.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 05/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CIResponseArgumentCollection : NSMutableArray

@end

@interface CIResponseArgument : NSObject
@property (nonatomic,assign) NSString * Type;
@property (nonatomic,assign) NSString * SubType;
@property (nonatomic,assign) NSString * Payload;
@property (nonatomic,assign) NSString * PayloadInfo;
@end
