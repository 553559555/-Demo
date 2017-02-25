//
//  WZCalendarCell.h
//  日历demo
//
//  Created by 王壮 on 2016/11/28.
//  Copyright © 2016年 王壮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZCalendarCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary   *dic;
@property (nonatomic,assign) NSInteger      count;
@property (nonatomic,strong) NSMutableArray *tempArr;


@end
