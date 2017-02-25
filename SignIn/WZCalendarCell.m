//
//  WZCalendarCell.m
//  日历demo
//
//  Created by 王壮 on 2016/11/28.
//  Copyright © 2016年 王壮. All rights reserved.
//

#import "WZCalendarCell.h"
#import <Masonry.h>
#import "Common.h"

@interface WZCalendarCell()

@property (nonatomic,strong) UILabel        *dateLabel;
@property (nonatomic,strong) UIImageView    *backgroundImage;
@property (nonatomic,strong) UILabel        *repairImage;

@end

@implementation WZCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"y1"];
        _backgroundImage.hidden = YES;
        [self.contentView addSubview:_backgroundImage];
        
        _repairImage = [[UILabel alloc] init];
        _repairImage.text = @"补签";
        _repairImage.font = [UIFont systemFontOfSize:9];
        _repairImage.textColor = [UIColor redColor];
        _repairImage.layer.cornerRadius = 3;
        _repairImage.layer.masksToBounds = YES;
        _repairImage.layer.borderWidth = 0.5;
        _repairImage.layer.borderColor = [UIColor redColor].CGColor;
        _repairImage.textAlignment = NSTextAlignmentCenter;
        _repairImage.hidden = YES;
        [self.contentView addSubview:_repairImage];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.dateLabel.font = [UIFont systemFontOfSize:13];
        self.dateLabel.textColor = [UIColor grayColor];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dateLabel];
        
        [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(frame.size.height, frame.size.height));
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        }];
        
        [_repairImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(frame.size.width, frame.size.height / 3));
            make.bottom.equalTo(self.contentView).offset(-2 * HEIGHT_RATIO);
            make.left.equalTo(self.contentView).offset(20 * WIDTH_RATIO);
            make.right.equalTo(self.contentView).offset(-20 * WIDTH_RATIO);
        }];
        
    }
    return self;
}

//- (void)setCount:(NSInteger)count {
//    _count = count;
//    if (count % 7 == 6 || count % 7 == 0) {
//        _dateLabel.textColor = [UIColor redColor];
//    } else {
//        _dateLabel.textColor = [UIColor blueColor];
//    }
//}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
    if ([[dic objectForKey:@"sign"] boolValue]) {
        _backgroundImage.hidden = NO;
    } else {
        _backgroundImage.hidden = YES;
    }
    if ([[dic objectForKey:@"repair"] boolValue]) {
        _repairImage.hidden = NO;
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    } else {
        _repairImage.hidden = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    _dateLabel.text = [dic objectForKey:@"day"];
}

@end
