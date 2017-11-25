//
//  UUCISeatQueryResultCell.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 16/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "UUCISeatQueryResultCell.h"
#include "UUMessageFrame.h"
#include "CI_Shared_Constants.h"
#include "CI_ACTION_FLAGS.h"
#include "UUMessageTemplateCell.h"

@implementation UUCISeatQueryResultCell

- (void)generateCustomCell:(NSDictionary *)datasource
{
    //NSDictionary * dict = (NSDictionary*)datasource;
    [self createCellFromCellData : datasource];
}

-(void)createCellFromCellData:(NSDictionary*)dataDict
{
    //remove views to prepare add new ui component
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSArray * cabininfoary = [dataDict objectForKey:@"FlightCabininfo"];
    NSDictionary * flightInfoDict = [dataDict objectForKey:@"FlightInfo"];
    NSDictionary * classCommon = cabininfoary[0];
    NSDictionary * classBusiness = cabininfoary[2];
    NSLog(@"The Current element is %@",dataDict);
    //initialize
//    self.contentView.layer.cornerRadius = 10; //Cell的角的弧度，0為直角
//    self.contentView.layer.borderWidth = 0.5; //Cell的邊框的線條粗細
    //self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    /*********************Setting Values for Cell Component Layout************************/
    
    CGFloat width = self.frame.size.width - ChatTemplateLeftMargin*2;
    width = ChatTemplateElementW;
    CGFloat leftMargin = ChatTemplateLeftMargin;
    
    //開始進行卡片設定：Head Info Part
    UIView * cardHeadBackView = [[UIView alloc]init];
    cardHeadBackView.frame = CGRectMake(CI_Bubble_Head_Image_Left_Margin,CI_Bubble_Head_Image_Top_Margin,CI_Bubble_Head_Image_W,CI_Bubble_Head_Image_H);
    cardHeadBackView.backgroundColor = CI_Head_ImageView_BK_Color;
    //設定只有左上和右上的角為圓角。
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:cardHeadBackView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){5.0, 5.0}].CGPath;
    
    cardHeadBackView.backgroundColor = CI_Head_ImageView_BK_Color;
    cardHeadBackView.layer.mask = maskLayer;
    
    UIImageView * headBkImgView = [[UIImageView alloc]init];
    headBkImgView.frame = CGRectMake(53, 26.3, 120.0, 121.3);
    headBkImgView.image = [UIImage imageNamed:@"登記背景"];
    
    [self.contentView addSubview:cardHeadBackView];
    [self.contentView addSubview:headBkImgView];
    //set head labels
    //日期的label
    UILabel * dateLbl = [[UILabel alloc]init];
    dateLbl.frame = CGRectMake(16.0, 16.0, 67, 10);
    dateLbl.font = CI_Font_PingFangTC_Medium_10;
    dateLbl.text = [flightInfoDict objectForKey:@"ArriveDate"];//@"2017/11/01"; //程式設定
    [dateLbl setTextColor:[UIColor whiteColor]];
    
    //航班的label
    UILabel * flightLbl = [[UILabel alloc]init];
    flightLbl.frame = CGRectMake(182.0, 16.0, 67, 10);
    flightLbl.font = CI_Font_PingFangTC_Medium_10;
    flightLbl.text = [flightInfoDict objectForKey:@"AirlineCodeFlightNo"];//@"CI511"; //程式設定
    [flightLbl setTextColor:[UIColor whiteColor]];
    
    //設定出發地label
    UILabel * startLocLbl = [[UILabel alloc]init];
    startLocLbl.frame = CGRectMake(16.0, 30.5, 58, 17);
    startLocLbl.font = CI_Font_Arial_BoldMT_20;
    startLocLbl.text = [flightInfoDict objectForKey:@"DepartFrom"];//@"TPE"; //程式設定
    [startLocLbl setTextColor:[UIColor whiteColor]];
    
    //設定目的地label
    UILabel * destLocLbl = [[UILabel alloc]init];
    destLocLbl.frame = CGRectMake(162.0, 30.5, 58, 17);
    destLocLbl.font = CI_Font_Arial_BoldMT_20;
    destLocLbl.text = [flightInfoDict objectForKey:@"ArriveTo"];//程式設定
    [destLocLbl setTextColor:[UIColor whiteColor]];
    
    UIImageView * airplaneImgView = [[UIImageView alloc]init];
    airplaneImgView.frame = CGRectMake(105, 31.3, 15, 15);
    airplaneImgView.image = [UIImage imageNamed:@"airplane"];
    
//    UILabel * capitalLbl = [[UILabel alloc]init];
//    capitalLbl.frame = CGRectMake(16, 51.6, 43, 10);
//    capitalLbl.font = CI_Font_PingFangTC_Medium_10;
//    capitalLbl.text = @"台北桃園";//程式設定
//    [capitalLbl setTextColor:[UIColor whiteColor]];
    
//    UILabel * destCapitalLbl = [[UILabel alloc]init];
//    destCapitalLbl.font = CI_Font_PingFangTC_Medium_10;
//    destCapitalLbl.frame = CGRectMake(167, 51.6, 43, 10);
//    destCapitalLbl.text = @"北京首都";//程式設定
//    [destCapitalLbl setTextColor:[UIColor whiteColor]];
    
    UILabel * startTimeLbl = [[UILabel alloc]init];
    startTimeLbl.frame = CGRectMake(16, 65.8, 30, 10);
    startTimeLbl.text = [flightInfoDict objectForKey:@"DepartTime"];//@"15:35";//程式設定
    [startTimeLbl setTextColor:[UIColor whiteColor]];
    startTimeLbl.font = CI_Font_PingFangTC_Medium_10;
    
    UILabel * endTimeLbl = [[UILabel alloc]init];
    endTimeLbl.frame = CGRectMake(180, 65.8, 30, 10);
    endTimeLbl.text = [flightInfoDict objectForKey:@"ArriveTime"];//@"15:35";//程式設定
    [endTimeLbl setTextColor:[UIColor whiteColor]];
    endTimeLbl.font = CI_Font_PingFangTC_Medium_10;
    
    [self.contentView addSubview:destLocLbl];
    [self.contentView addSubview:startLocLbl];
    [self.contentView addSubview:flightLbl];
    [self.contentView addSubview:dateLbl];
    [self.contentView addSubview:airplaneImgView];
//    [self.contentView addSubview:capitalLbl];
//    [self.contentView addSubview:destCapitalLbl];
    [self.contentView addSubview:startTimeLbl];
    [self.contentView addSubview:endTimeLbl];
    //content background image
    UIImageView * contentBusinessBackImgView = [[UIImageView alloc]init];
    contentBusinessBackImgView.frame = CGRectMake(CI_Bubble_Head_Image_Left_Margin, CI_Bubble_Head_Image_Top_Margin+CI_Bubble_Head_Image_H, 225.0, CI_QF_Cell_H);
    [contentBusinessBackImgView setImage:[UIImage imageNamed:@"plain-white-background"]];
    [self.contentView addSubview:contentBusinessBackImgView];
    
    //spliter
    UIImageView * spliterImgView = [[UIImageView alloc]init];
    spliterImgView.frame = CGRectMake(11.0, CI_Bubble_Head_Image_Top_Margin+CI_Bubble_Head_Image_H+CI_QF_Cell_H, 200, 2);
    [spliterImgView setImage:[UIImage imageNamed:@"spliter"]];
    [self.contentView addSubview:spliterImgView];
    
    UIImageView * contentEconomyBackImgView = [[UIImageView alloc]init];
    contentEconomyBackImgView.frame = CGRectMake(CI_Bubble_Head_Image_Left_Margin, CI_Bubble_Head_Image_Top_Margin+CI_Bubble_Head_Image_H+CI_QF_Cell_H+2, 225.0,55);
    [contentEconomyBackImgView setImage:[UIImage imageNamed:@"plain-white-background"]];
    [self.contentView addSubview:contentEconomyBackImgView];
    
    UILabel * businessClassNum = [[UILabel alloc]init];
    businessClassNum.frame = CGRectMake(20, 120.2, 72, 13);
    businessClassNum.text = [NSString stringWithFormat:@"商務艙 : %@",[classBusiness objectForKey:@"SeatAvailable"]];//@"商務艙：10";
    businessClassNum.font = CI_Font_PingFangTC_Medium_13;
    businessClassNum.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1/1.0];
    [self.contentView addSubview:businessClassNum];
    
    UILabel * economyClassNum = [[UILabel alloc]init];
    economyClassNum.frame = CGRectMake(20, 163.8, 80, 13);
    economyClassNum.text = [NSString stringWithFormat:@"經濟艙 : %@",[classCommon objectForKey:@"SeatAvailable"]];//@"經濟艙：-10";
    economyClassNum.font = CI_Font_PingFangTC_Medium_13;
    economyClassNum.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1/1.0];
    [self.contentView addSubview:economyClassNum];
    

    //第一個登記按鈕(之後要重構，趕時間只能用CP大法)
    //UUCIBaseCellButton * regBtn1 = [[UUCIBaseCellButton alloc]initWithFrame:CGRectMake(155.0, 113.1, 42, 24.3)];
    UUTemplateButton * regBtn1 = [[UUTemplateButton alloc]initWithFrame:CGRectMake(155.0, 113.1, 42, 24.3)];
    regBtn1.ButtonActionID = CI_Business_Reg;
    regBtn1.backgroundColor = RegisterButtonBKColor;
    [[regBtn1 layer]setBorderWidth:2.0f];
    [[regBtn1 layer]setBorderColor:[UIColor blueColor].CGColor];
    [regBtn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    regBtn1.titleLabel.font = CI_Font_PingFangTC_Medium_11;
    [regBtn1 setTitle:@"登 記" forState:UIControlStateNormal];
    [regBtn1 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:regBtn1];
    
    //第二個登記按鈕
    UUTemplateButton * regBtn2 = [[UUTemplateButton alloc]initWithFrame:CGRectMake(155.0, 162.1, 42, 24.3)];
    regBtn2.ButtonActionID = 1;//CI_Economy_Reg;
    regBtn2.backgroundColor = RegisterButtonBKColor;
    [[regBtn2 layer]setBorderWidth:2.0f];
    [[regBtn2 layer]setBorderColor:[UIColor blueColor].CGColor];
    [regBtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    regBtn2.titleLabel.font = CI_Font_PingFangTC_Medium_11;
    [regBtn2 setTitle:@"登 記" forState:UIControlStateNormal];
    [regBtn2 addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:regBtn2];
    
    //set border lines
    //left border view
    UIView * leftborderView = [[UIView alloc]init];
    leftborderView.frame = CGRectMake(leftMargin, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 100);
    leftborderView.backgroundColor = grayColor;
    
    //right border view
    UIView * rightborderView = [[UIView alloc]init];
    rightborderView.frame = CGRectMake(200+leftMargin-1, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 100);
    rightborderView.backgroundColor = grayColor;
    
    //bottom border view
    UIView * bottomBorderView = [[UIView alloc]init];
    bottomBorderView.frame = CGRectMake(leftMargin, 202, 200, 1);
    bottomBorderView.backgroundColor = grayColor;
    
    [self.contentView addSubview:leftborderView];
    [self.contentView addSubview:rightborderView];
    [self.contentView addSubview:bottomBorderView];
    
}


- (void)buttonTapped:(UUTemplateButton *)button {
    if ([self.delegate respondsToSelector:@selector(UUMessageTemplateCellDelegateButtonTapped:)]) {
        [self.delegate UUMessageTemplateCellDelegateButtonTapped:button];
    }
}
@end
