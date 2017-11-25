//
//  UUCISecondConfirmBookingCell.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 09/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "UUCISecondConfirmBookingCell.h"

@implementation UUCISecondConfirmBookingCell
-(void)generateCustomCell:(NSObject *)datasource
{
    [self beforeDrawCard];
//    [self drawCardHeader];
//    [self drawCardHeaderLabels];
//    [self drawCardContentTitleLabels];
//    [self drawCardContentLabels];
//    [self drawCardBorder];
//    [self drawCheckButton];
}

-(void)beforeDrawCard
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    //self.contentView.layer.cornerRadius = 5; //Cell的角的弧度，0為直角
    //self.contentView.layer.borderWidth = 0.5; //Cell的邊框的線條粗細
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
}
@end
