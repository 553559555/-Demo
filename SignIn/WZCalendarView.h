//
//  WZCalendarView.h
//  日历demo
//
//  Created by 王壮 on 2016/11/28.
//  Copyright © 2016年 王壮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CALENDARBLOCK)(NSDictionary *dict);

@interface WZCalendarView : UIView

@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,copy) CALENDARBLOCK          cellClick;

- (void)cellWithClick:(CALENDARBLOCK)block;

@end
