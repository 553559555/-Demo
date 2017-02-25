//
//  WZCalendarView.m
//  日历demo
//
//  Created by 王壮 on 2016/11/28.
//  Copyright © 2016年 王壮. All rights reserved.
//

#import "WZCalendarView.h"
#import "WZCalendarCell.h"
#import <Masonry.h>
#import "Common.h"

#define ITEMWIDTH [UIScreen mainScreen].bounds.size.width / 7
static NSString *identifier = @"WZCalendarCell";

@interface WZCalendarView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong) UIView            *headerView;
@property (nonatomic,strong) NSMutableArray    *dateArray;
@property (nonatomic,strong) UILabel           *yearLabel;
@property (nonatomic,assign) NSInteger         today;
@property (nonatomic,assign) NSInteger         oneDay;

@end

@implementation WZCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *array = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 160 * HEIGHT_RATIO)];
        self.headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerView];
        self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 80 * HEIGHT_RATIO)];
        self.yearLabel.textAlignment = NSTextAlignmentCenter;
        self.yearLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.headerView addSubview:self.yearLabel];
        for (int i = 0; i < 7; ++i) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * ITEMWIDTH, 80 * HEIGHT_RATIO, ITEMWIDTH, 80 * HEIGHT_RATIO)];
            
            label.text = array[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor blackColor];
            label.layer.borderWidth = 0.5;
            label.layer.borderColor = [UIColor lightGrayColor].CGColor;
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 0 || i == 6) {
                label.textColor = [UIColor redColor];
            }
            [self.headerView addSubview:label];
        }
        
        [self addChildViews];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.collectionView).offset(16 * HEIGHT_RATIO);
        }];
        [self gain];
    }
    return self;
}

- (void)cellWithClick:(CALENDARBLOCK)block {
    self.cellClick = block;
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    NSArray *alreadySign = dict[@"data"][@"userdate"];
    if (alreadySign != nil) {
        for (int i = 0; i < alreadySign.count; i++) {
            for (int j = 0; j < self.dateArray.count; j++) {
                if ([[self.dateArray[j] objectForKey:@"day"] isEqualToString:alreadySign[i]]) {
                    [self.dateArray[j] setObject:@YES forKey:@"sign"];
                }
            }
        }
        for (NSInteger i = self.oneDay - 1; i < self.today + self.oneDay - 2; i++) {
            if ([[self.dateArray[i] objectForKey:@"sign"] integerValue] == 0) {
                [self.dateArray[i] setObject:@YES forKey:@"repair"];
            } else {
                [self.dateArray[i] setObject:@NO forKey:@"repair"];
            }
        }
    }
    
    [self.collectionView reloadData];
}

//获取日期
- (void)gain {
    
    self.dateArray = [NSMutableArray array];
    
    //获取当前月份有多少天
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    //获取当前是那年，那个月
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger iCurYear = [components year];  //当前的年份
    NSInteger iCurMonth = [components month];  //当前的月份
    self.today = [components day];
    self.yearLabel.text = [NSString stringWithFormat:@"%tu年%tu月", iCurYear, iCurMonth];
    //获取当前月份第一天星期几
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:1];
    [_comps setMonth:iCurMonth];
    [_comps setYear:iCurYear];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int _weekday = [weekdayComponents weekday];
    self.oneDay = _weekday;
    //添加到数组中
    for (NSInteger i = 0; i < range.length + _weekday - 1; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (i < _weekday - 1) {
            [dict addEntriesFromDictionary:@{@"day" : @" " , @"sign" : @NO , @"repair" : @NO}];
            [self.dateArray addObject:dict];
        } else {
            [dict addEntriesFromDictionary:@{@"day" : [NSString stringWithFormat:@"%ld", i - _weekday + 2] , @"sign" : @NO , @"repair" : @NO}];
            [self.dateArray addObject:dict];
        }
    }
    
}

- (void)addChildViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ITEMWIDTH, ITEMWIDTH - 10);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[WZCalendarCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.mas_equalTo(6 * (ITEMWIDTH - 10));
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.dateArray.count > indexPath.row) {
        cell.dic = self.dateArray[indexPath.row];
    } else {
        cell.dic = @{@"day" : @" " , @"sign" : @NO , @"repair" : @NO};
    }
    //cell.count = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dateArray[indexPath.row];
    if ([dict[@"repair"] integerValue] == 1) {
        if (self.cellClick) {
            self.cellClick(dict);
        }
    }
}

@end
