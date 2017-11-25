//
//  UUMessageTemplateCell.h
//  IQAgent
//
//  Created by IanFan on 2016/12/8.
//  Copyright © 2016年 IanFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UUTemplateButton : UIButton
@property (nonatomic, assign) Button_Type type;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) int ButtonActionID;
@property (nonatomic, retain) NSString * buttonDesc;
@property (nonatomic, retain) NSAttributedString *attributedTitle;
@property (nonatomic, retain) NSString *payload;
@end

@protocol UUMessageTemplateCellDelegate;

@interface UUMessageTemplateCell : UICollectionViewCell
-(void)generateCustomCell : (NSObject*)datasource;
@property (nonatomic, assign) id<UUMessageTemplateCellDelegate> delegate;
- (void)updateWithElement:(Element *)element;
@end

@protocol UUMessageTemplateCellDelegate <NSObject>
- (void)UUMessageTemplateCellDelegateButtonTapped:(UUTemplateButton *)button;
@end
