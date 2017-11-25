//
//  UUMessageTemplateView.m
//  IQAgent
//
//  Created by IanFan on 2016/12/8.
//  Copyright © 2016年 IanFan. All rights reserved.
//

#import "UUMessageTemplateView.h"
#include "UUMessageFrame.h"
#include "UUCISeatQueryResultCell.h"
#include "UUCIConfirmBookingCell.h"
#include "UUCIChangeFlightCell.h"
#include "UUCIFistConfirmChangeCell.h"
#include "UUCIFinalConfirmChangeCell.h"


#define CELL_IDENTIFIER @"Cell"

@interface UUMessageTemplateView () <UICollectionViewDelegate, UICollectionViewDataSource, UUMessageTemplateCellDelegate,UUCIBaseCellDelegate>
{
    UICollectionView *_collectionView;
    ContentItem *_item;
}
@end

@implementation UUMessageTemplateView
@synthesize callCount;

- (void)dealloc {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _collectionView = nil;
}

- (void)updateWithContentItem:(ContentItem *)item
{
    callCount = 0 ;
    NSLog(@"updateWithContentItem:(ContentItem *)item is called");
    _item = item;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    _collectionView = nil;
    [self setCollectionView];
    
    switch (item.message.attachment.payload.template_type) {
        case Template_Type_Button:
        {
            ChatTemplateImage;
            break;
        }
        case Template_Type_Generic:
        {
            NSLog(@"Template_Type_Generic is captured!");
            //[_collectionView registerClass:[UUMessageTemplateCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        case Template_Type_CI_Query_Seat:
        {
            NSLog(@"Template_Type_CI_Query_Seat is captured!");
            [_collectionView registerClass:[UUCISeatQueryResultCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        case Template_Type_CI_Confirm_Booking:
        {
            NSLog(@"Template_Type_CI_Confirm_Booking is captured!");
            [_collectionView registerClass:[UUCIConfirmBookingCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        case Template_Type_CI_Change_Confirm:
        {
            [_collectionView registerClass:[UUCIChangeFlightCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        case Template_Type_CI_Change_First_Confirm:
        {
            NSLog(@"Template_Type_CI_Change_First_Confirm!");
            [_collectionView registerClass:[UUCIFistConfirmChangeCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        case Template_Type_CI_Change_Final_Confirm:
        {
            NSLog(@"Template_Type_CI_Change_Final_Confirm is captured!");
            [_collectionView registerClass:[UUCIFinalConfirmChangeCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
            break;
        }
        default:
            break;
    }
}

#pragma mark - CollectionView

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"Current Process is in numberOfSectionsInCollectionView:");
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"(Current Process is in collectionView numberOfItemsInSection:)The count is %d",(int)_item.message.attachment.payload.elements.count);
    return _item.message.attachment.payload.elements.count; //2
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch(_item.message.attachment.payload.template_type)
    {
//        case Template_Type_Button:
//        case Template_Type_Generic:
//        {
//            NSLog(@"__Process is in collectionView: cellForItemAtIndexPath--Template_Type_Generic");
//            UUMessageTemplateCell *cell = (UUMessageTemplateCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
//            cell.delegate = self;
//            Element *element = [_item.message.attachment.payload.elements objectAtIndex:indexPath.row];
//            [cell updateWithElement:element];
//            return cell;
//        }
        //以下結構簡直是…讓我無言，要改架構。
        case Template_Type_CI_Query_Seat:
        case Template_Type_CI_Confirm_Booking:
        case Template_Type_CI_Change_Confirm:
        case Template_Type_CI_Change_Confirm_GO:
        case Template_Type_CI_Change_Confirm_Back:
        case Template_Type_CI_Change_First_Confirm:
        case Template_Type_CI_Change_First_Confirm_GO:
        case Template_Type_CI_Change_First_Confirm_Back:
        case Template_Type_CI_Change_Final_Confirm:
        case Template_Type_CI_Change_Final_Confirm_GO:
        case Template_Type_CI_Change_Final_Confirm_Back:
        {
            NSLog(@"__Process is in collectionView: cellForItemAtIndexPath--%d",(int)_item.message.attachment.payload.template_type);
            callCount++;
            NSLog(@"The __Process is in collectionView is called %d time", callCount);
            //UUCIBaseCell * cell = (UUCIBaseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
            UUMessageTemplateCell * cell = (UUMessageTemplateCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
            cell.delegate = self;
            Element * ele = (Element*)_item.message.attachment.payload.elements[indexPath.item];
            [cell generateCustomCell:ele];
            return cell;
        }
        default:
            return nil;
    }
}

#pragma mark CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"(Current Process is in collectionView layout:collectionViewLayout sizeForItemAtIndexPath:)The UUMessageTemplateView Height is %f",(double)self.frame.size.height);
    return CGSizeMake(ChatTemplateElementW + ChatTemplateLeftMargin*2, self.frame.size.height+20);
    //CGSizeMake(ChatTemplateElementW + ChatTemplateLeftMargin*2, self.frame.size.height);//
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    NSLog(@"__Process is in collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:");
    CGFloat spacing = 0;
    return spacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumColumnSpacingForSectionAtIndex:(NSInteger)section
{
    NSLog(@"__Process is in collectionView layout:collectionViewLayout minimumColumnSpacingForSectionAtIndex:");
    CGFloat spacing = 0;
    return spacing;
}

#pragma mark CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

#pragma mark - UUMessageTemplateCellDelegate

- (void)UUMessageTemplateCellDelegateButtonTapped:(UUTemplateButton *)button {
    if ([self.delegate respondsToSelector:@selector(UUMessageTemplateViewDelegateButtonTapped:)]) {
        [self.delegate UUMessageTemplateViewDelegateButtonTapped:button];
    }
}

#pragma mark - UUCIBaseCellDelegate
//-(void)UUCIBaseCellDelegateButtonTapped:(UUCIBaseCellButton *)button
//{
//    if ([self.delegate respondsToSelector:@selector(UUMessageTemplateViewDelegateButtonTapped:)]) {
//        [self.delegate UUMessageTemplateViewDelegateButtonTapped:button];
//    }
//}

#pragma mark - Factory

- (UICollectionView *)setCollectionView {
    //上下滑動的collectionView
    NSLog(@"setCollectionView is called");
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
