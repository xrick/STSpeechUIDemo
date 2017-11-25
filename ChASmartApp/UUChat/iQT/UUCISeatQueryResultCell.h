//
//  UUCISeatQueryResultCell.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 16/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UUCIBaseCell.h"
#import "UUMessageTemplateCell.h"
#import "ContentItem.h"
//卡片底線的x,y位置
#define UUCI_Bottom_Line_POS_X 16.0
#define UUCI_Bottom_Line_POS_Y 200.0

@interface UUCISeatQueryResultCell : UUMessageTemplateCell
-(void)generateCustomCell : (NSDictionary*)datasource;
@end


