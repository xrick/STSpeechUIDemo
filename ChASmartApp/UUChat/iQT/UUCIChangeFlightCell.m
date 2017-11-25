//
//  UUCIChangeFlightCell.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 03/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//
//改變航班的第一個步驟介面。
#import "UUCIChangeFlightCell.h"
#include "UUMessageFrame.h"
#include "CI_Shared_Constants.h"
#include "CI_ACTION_FLAGS.h"

@implementation UUCIChangeFlightCell
@synthesize elementItem;
-(void)generateCustomCell:(NSObject *)datasource
{
    self.elementItem = (Element*)datasource;
    //做清除動作。
    [self beforeDrawCard];
    [self drawCardHeader];
    [self drawCardHeaderLabels];
    [self drawCardContentTitleLabels];
    [self drawCardContentLabels];
    [self drawCardBorder];
    [self drawCheckButton];
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

-(void)drawCardHeader
{
    //建立card head view container
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(CI_Bubble_Head_Image_Left_Margin,CI_Bubble_Head_Image_Top_Margin,CI_Bubble_Head_Image_W,CI_Bubble_Head_Image_H)];
    //設定只有左上和右上的角為圓角。
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:headView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    headView.backgroundColor = CI_Head_ImageView_BK_Color;
    headView.layer.mask = maskLayer;
    
    //設定Card Header 背景色及浮水印圖
    headView.frame = CGRectMake(CI_Bubble_Head_Image_Left_Margin,CI_Bubble_Head_Image_Top_Margin,CI_Bubble_Head_Image_W,CI_Bubble_Head_Image_H);
    headView.backgroundColor = CI_Head_ImageView_BK_Color;
    UIImageView * headBkImgView = [[UIImageView alloc]init];
    headBkImgView.frame = CGRectMake(58, 32, 110.0, 80);
    headBkImgView.image = [UIImage imageNamed:@"機票背景"];
    
    [self.contentView addSubview:headView];
    [self.contentView addSubview:headBkImgView];
}

-(void)drawCardHeaderLabels
{
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

    [self.contentView addSubview:destLocLbl];
    [self.contentView addSubview:startLocLbl];
    [self.contentView addSubview:flightLbl];
    [self.contentView addSubview:dateLbl];
    [self.contentView addSubview:airplaneImgView];
    [self.contentView addSubview:capitalLbl];
    [self.contentView addSubview:destCapitalLbl];
    [self.contentView addSubview:startTimeLbl];
    [self.contentView addSubview:endTimeLbl];
}

-(void)drawCardContentTitleLabels
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16, 100, 70, 140);
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.text = @"訂位艙等：乘客姓名：\n\n\n機票號碼：訂位票種：開票日期：";
    label.font = CI_Font_PingFangTC_Medium_13;//[UIFont fontWithName:@"PingFangTC-Medium" size:13];
    [self.contentView addSubview:label];
}

-(void)drawCardContentLabels
{
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(85, 100, 129, 140);
    label.font = CI_Font_PingFangTC_Medium_13;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    NSString * strFormat = @"%@\n%@ / \n%@ %@\n%@\n%@\n%@";
    NSString * strContent = [NSString stringWithFormat:strFormat, @"商務艙",@"LIU",@"SHAUNG SHAUNG",@"劉霜霜", @"1234567890123",@"ID00R2",@"106/06/06" ];
    label.text = strContent;
    [self.contentView addSubview:label];
}

-(void)drawCardBorder
{
    //set border lines
    //left border view
    UIView * leftborderView = [[UIView alloc]init];
    leftborderView.frame = CGRectMake(10, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 184);
    leftborderView.backgroundColor = grayColor;
    
    //right border view
    UIView * rightborderView = [[UIView alloc]init];
    rightborderView.frame = CGRectMake(209, ChatContentTop+CI_CARD_LOGO_BACKGORUND_IMAGE_HEIGHT-6, 1.0, 184);
    rightborderView.backgroundColor = grayColor;
    
    //first bottom border view
    UIView * bottomBorderView = [[UIView alloc]init];
    bottomBorderView.frame = CGRectMake(10, 240, 200, 1);
    bottomBorderView.backgroundColor = grayColor;
    //second bottom border view
    UIView * bottomBorderView2 = [[UIView alloc]init];
    bottomBorderView2.frame = CGRectMake(10, 286, 200, 1);
    bottomBorderView2.backgroundColor = grayColor;
    
    [self.contentView addSubview:leftborderView];
    [self.contentView addSubview:rightborderView];
    [self.contentView addSubview:bottomBorderView];
    [self.contentView addSubview:bottomBorderView2];
}

-(void)drawCheckButton
{
    UIView * customView = [[UIView alloc]init];
    customView.frame = CGRectMake(36, 250, 90, 24);
    if(elementItem.buttons.count == 0)
    {
        UUTemplateButton * chkButton =[UUTemplateButton buttonWithType:UIButtonTypeCustom];
//        LCJBaseButtonDescriptor * btnDesc = [self.elementItem.buttons objectAtIndex:0];
        [chkButton setBackgroundImage:[UIImage imageNamed:@"checkbok_unchecked"] forState:UIControlStateNormal];
        [chkButton setAccessibilityIdentifier:@"checkbok_unchecked"];
    //這邊必須有資料結構來記錄，否則會消失。
    //set chkButton Action, uncomment later.
        chkButton.ButtonActionID = CI_Book_Flight_Confirm_Action;
        [chkButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        chkButton.frame = CGRectMake(0, 0, 24, 24);
        [elementItem.buttons addObject:chkButton];
        [customView addSubview:chkButton];
    }
    else{
        [customView addSubview:[elementItem.buttons objectAtIndex:0]];
    }
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(30, 0, 100, 24);
    label.font = CI_Font_PingFangTC_Medium_13;
    label.text = @"選擇本機票";
    [customView addSubview:label];
    
    [self.contentView addSubview:customView];
}

- (void)buttonTapped:(UUTemplateButton *)button {
    if ([self.delegate respondsToSelector:@selector(UUMessageTemplateCellDelegateButtonTapped:)]) {
        [self.delegate UUMessageTemplateCellDelegateButtonTapped:button];
    }
}
@end
