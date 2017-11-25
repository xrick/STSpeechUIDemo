//
//  UUCIChangeFlightCell.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 03/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "UUMessageTemplateCell.h"
#import "ContentItem.h"
@interface UUCIChangeFlightCell : UUMessageTemplateCell
-(void)generateCustomCell : (NSObject*)datasource;
@property(nonatomic,retain)Element * elementItem;
@end
