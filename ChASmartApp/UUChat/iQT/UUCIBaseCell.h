//
//  UUCIBaseCell.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 19/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUCIBaseCellButton : UIButton
@property (nonatomic, assign) int ButtonActionID;
@property (nonatomic, retain) NSObject * ButtonPayLoad;
@property (nonatomic, retain) NSString * ButtonStringInfo;
@end

@protocol UUCIBaseCellDelegate;

@interface UUCIBaseCell : UICollectionViewCell
@property(nonatomic,assign)id<UUCIBaseCellDelegate> delegate;
//@property(nonatomic,retain)CIUIParameters * ExtendedParameters;

-(void)generateCustomCell : (NSObject*)datasource;
@end

@protocol UUCIBaseCellDelegate <NSObject>
-(void)UUCIBaseCellDelegateButtonTapped:(UUCIBaseCellButton *)button;
@end

/*
 - (void)buttonTapped:(UUCIBaseCellButton *)button {
 if ([self.delegate respondsToSelector:@selector(UUCIBaseCellDelegateButtonTapped:)]) {
 [self.delegate UUCIBaseCellDelegateButtonTapped:button];
 }
 }
 */
