//
//  TestData.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 18/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIResponseDataItem.h"
#import "CIResponseArgument.h"
#import "ContentItem.h"
#import "ListSeatAvailable.h"
#import "CIResponseArgument.h"
@interface TestData : NSObject
{

}



//@property (class,nonatomic,retain) NSMutableArray * TestDataItems;

+(ContentItem*)GenTestData;

+(NSMutableDictionary*)doParseJson;

@end
