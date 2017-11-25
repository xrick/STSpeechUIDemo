//
//  UUCIConfirmBookingCell.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 19/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "UUCIConfirmBookingCell.h"
#include "UUMessageFrame.h"
#include "CI_Shared_Constants.h"

@implementation UUCIConfirmBookingCell

-(void)generateCustomCell:(NSObject *)datasource
{
    //remove views to prepare add new ui component
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;//[UIColor lightGrayColor].CGColor;

    
    CGFloat leftMargin = ChatTemplateLeftMargin;

    /*******CP大法*******/
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(CI_Bubble_Head_Image_Left_Margin,CI_Bubble_Head_Image_Top_Margin,CI_Bubble_Head_Image_W,CI_Bubble_Head_Image_H)];
    
    //設定只有左上和右上的角為圓角。
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:headView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    headView.backgroundColor = CI_Head_ImageView_BK_Color;
    headView.layer.mask = maskLayer;
    // [self.contentView addSubview:headView];
    

    UIImageView * headBkImgView = [[UIImageView alloc]init];
    headBkImgView.frame = CGRectMake(47, 20.5, 108.0, 86);
    headBkImgView.image = [UIImage imageNamed:@"機票背景"];
    
    [headView addSubview:headBkImgView];
    [self.contentView addSubview:headView];
    
    //[self.contentView addSubview:headBkImgView];
    //set head labels
    //日期的label
    UILabel * dateLbl = [[UILabel alloc]init];
    dateLbl.frame = CGRectMake(16.0, 16.0, 67, 10);
    dateLbl.font = CI_Font_PingFangTC_Medium_10;
    dateLbl.text = @"2017/11/01"; //程式設定
    [dateLbl setTextColor:[UIColor whiteColor]];
    
    //航班的label
    UILabel * flightLbl = [[UILabel alloc]init];
    flightLbl.frame = CGRectMake(182.0, 16.0, 67, 10);
    flightLbl.font = CI_Font_PingFangTC_Medium_10;
    flightLbl.text = @"CI511"; //程式設定
    [flightLbl setTextColor:[UIColor whiteColor]];
    
    //設定出發地label
    UILabel * startLocLbl = [[UILabel alloc]init];
    startLocLbl.frame = CGRectMake(16.0, 30.5, 58, 17);
    startLocLbl.font = CI_Font_Arial_BoldMT_20;
    startLocLbl.text = @"TPE"; //程式設定
    [startLocLbl setTextColor:[UIColor whiteColor]];
    
    //設定目的地label
    UILabel * destLocLbl = [[UILabel alloc]init];
    destLocLbl.frame = CGRectMake(162.0, 30.5, 58, 17);
    destLocLbl.font = CI_Font_Arial_BoldMT_20;
    destLocLbl.text = @"PEK";//程式設定
    [destLocLbl setTextColor:[UIColor whiteColor]];
    
    UIImageView * airplaneImgView = [[UIImageView alloc]init];
    airplaneImgView.frame = CGRectMake(105, 31.3, 15, 15);
    airplaneImgView.image = [UIImage imageNamed:@"airplane"];
    
    UILabel * capitalLbl = [[UILabel alloc]init];
    capitalLbl.frame = CGRectMake(16, 51.6, 43, 10);
    capitalLbl.font = CI_Font_PingFangTC_Medium_10;
    capitalLbl.text = @"台北桃園";//程式設定
    [capitalLbl setTextColor:[UIColor whiteColor]];
    
    UILabel * destCapitalLbl = [[UILabel alloc]init];
    destCapitalLbl.font = CI_Font_PingFangTC_Medium_10;
    destCapitalLbl.frame = CGRectMake(167, 51.6, 43, 10);
    destCapitalLbl.text = @"北京首都";//程式設定
    [destCapitalLbl setTextColor:[UIColor whiteColor]];
    
    UILabel * startTimeLbl = [[UILabel alloc]init];
    startTimeLbl.frame = CGRectMake(16, 65.8, 30, 10);
    startTimeLbl.text = @"15:35";//程式設定
    [startTimeLbl setTextColor:[UIColor whiteColor]];
    startTimeLbl.font = CI_Font_PingFangTC_Medium_10;
    
    UILabel * endTimeLbl = [[UILabel alloc]init];
    endTimeLbl.frame = CGRectMake(180, 65.8, 30, 10);
    endTimeLbl.text = @"15:35";//程式設定
    [endTimeLbl setTextColor:[UIColor whiteColor]];
    endTimeLbl.font = CI_Font_PingFangTC_Medium_10;
    
    [self.contentView addSubview:headView];
    [self.contentView addSubview:destLocLbl];
    [self.contentView addSubview:startLocLbl];
    [self.contentView addSubview:flightLbl];
    [self.contentView addSubview:dateLbl];
    [self.contentView addSubview:airplaneImgView];
    [self.contentView addSubview:capitalLbl];
    [self.contentView addSubview:destCapitalLbl];
    [self.contentView addSubview:startTimeLbl];
    [self.contentView addSubview:endTimeLbl];
    
    /*******End of CP 大法*/
    
    
    //setting buttons
    
    //left border view
    //set border lines
    //left border view
    UIView * leftborderView = [[UIView alloc]init];
    leftborderView.frame = CGRectMake(leftMargin, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 100);
    leftborderView.backgroundColor = grayColor;
    
    //right border view
    UIView * rightborderView = [[UIView alloc]init];
    rightborderView.frame = CGRectMake(209, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 100);
    rightborderView.backgroundColor = grayColor;
    
    //bottom border view
    UIView * bottomBorderView = [[UIView alloc]init];
    bottomBorderView.frame = CGRectMake(leftMargin, 202, 200, 1);
    bottomBorderView.backgroundColor = grayColor;
    
    [self.contentView addSubview:leftborderView];
    [self.contentView addSubview:rightborderView];
    [self.contentView addSubview:bottomBorderView];
    //setting labels (put the labels onto the right place)
    
}

-(void)drawTicketInfo
{
    
}


@end
