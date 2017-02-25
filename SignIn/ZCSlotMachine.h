//
//  TZCSlotMachine.h
//  Hgdb
//
//  Created by 王壮 on 2016/12/5.
//  Copyright © 2016年 HGDB. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark - ZCSlotMachine Delegate

@class ZCSlotMachine;

@protocol ZCSlotMachineDelegate <NSObject>

@optional
- (void)slotMachineWillStartSliding:(ZCSlotMachine *)slotMachine;
- (void)slotMachineDidEndSliding:(ZCSlotMachine *)slotMachine;

@end

@protocol ZCSlotMachineDataSource <NSObject>

@required
- (NSUInteger)numberOfSlotsInSlotMachine:(ZCSlotMachine *)slotMachine;
- (NSArray *)iconsForSlotsInSlotMachine:(ZCSlotMachine *)slotMachine;

@optional
- (CGFloat)slotWidthInSlotMachine:(ZCSlotMachine *)slotMachine;
- (CGFloat)slotSpacingInSlotMachine:(ZCSlotMachine *)slotMachine;

@end

#pragma mark - ZCSlotMachine

@interface ZCSlotMachine : UIView

/****** UI Properties ******/
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *coverImage;

/****** Data Properties ******/
@property (nonatomic, strong) NSMutableArray *slotResults;

/****** Animation ******/

// You can use this property to control the spinning speed, default to 0.14f
@property (nonatomic) CGFloat singleUnitDuration;

@property (nonatomic, weak) id <ZCSlotMachineDelegate> delegate;
@property (nonatomic, weak) id <ZCSlotMachineDataSource> dataSource;

- (void)startSliding;

@end
