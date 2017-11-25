//
//  CILoginControllerViewController.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 20/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CILoginControllerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray * pickerData;
}
- (id)initWithFrame:(CGRect)frame;

@property(nonatomic,strong) UIButton * confirmBtn;
@property(nonatomic,strong) UITextField * uidTxtField;
@property(nonatomic,strong) UITextField * pwdTxtField ;
@property(nonatomic,strong) UITextField * birthTxtField;
@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,strong) UIView * pickerContainer;
@property(nonatomic,strong) UILabel * innerLbl;
@property(nonatomic,strong) NSString * memStirng;

@end
