//
//  SignDescView.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/2.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "SignDescView.h"
#import "UIColor+MQHex.h"
#import <Masonry.h>
#import "Common.h"

@interface SignDescView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *oneTitleLabel;
@property (nonatomic,strong) UILabel *oneDescLabel;
@property (nonatomic,strong) UILabel *twoTitleLabel;
@property (nonatomic,strong) UILabel *twoDescLabel;
@property (nonatomic,strong) UILabel *threeTitleLabel;
@property (nonatomic,strong) UILabel *threeDescLabel;

@end

@implementation SignDescView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"f55943"];
        [self addChildViews];
    }
    return self;
}

- (void)addChildViews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"活动规则";
    _titleLabel.textColor = [UIColor colorWithHexString:@"f8e517"];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_titleLabel];
    
    _oneTitleLabel = [[UILabel alloc] init];
    _oneTitleLabel.text = @"每日签到礼：";
    _oneTitleLabel.textColor = [UIColor whiteColor];
    _oneTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_oneTitleLabel];
    
    _oneDescLabel = [[UILabel alloc] init];
    _oneDescLabel.numberOfLines = 0;
    _oneDescLabel.text = @"1.每日登陆后即可签到，签到可随机获得一个签到礼；\n2.如果当日忘记签到，可在日后补签；\n3.每次补签需要支付2个夺宝币，补签可计入连续签到天数，也可以获得签到礼；\n4.签到奖励包括1~100元的随机红包、1~100元的随机夺宝币、实物奖励；\n5.连续签到天数越多，获得大奖的几率越大。";
    _oneDescLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _oneDescLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_oneDescLabel];
    
    _twoTitleLabel = [[UILabel alloc] init];
    _twoTitleLabel.text = @"礼包大奖：";
    _twoTitleLabel.textColor = [UIColor whiteColor];
    _twoTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_twoTitleLabel];
    
    _twoDescLabel = [[UILabel alloc] init];
    _twoDescLabel.numberOfLines = 0;
    _twoDescLabel.text = @"1.当月积累签到7天、14天、21天、满勤，即可解锁神秘大礼包，有机会获得超值大奖；\n2.开启神秘大礼包，有一定几率获得：Apple苹果耳机、Apple iPad平板电脑、Apple iPhone7手机、Apple Mac笔记本电脑等惊喜大奖；\n注：补签亦计入连续签到天数";
    _twoDescLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _twoDescLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_twoDescLabel];
    
    _threeTitleLabel = [[UILabel alloc] init];
    _threeTitleLabel.text = @"活动说明：";
    _threeTitleLabel.textColor = [UIColor whiteColor];
    _threeTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_threeTitleLabel];
    
    _threeDescLabel = [[UILabel alloc] init];
    _threeDescLabel.numberOfLines = 0;
    _threeDescLabel.text = @"1.活动主办方将在法律允许的范围内，对活动作出必要的说明和解释，如遇到不可抗力的因素，获得主办方拥有取消本次获得的权利\n2.本活动与苹果公司无关。";
    _threeDescLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _threeDescLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_threeDescLabel];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40 * HEIGHT_RATIO);
        make.centerX.equalTo(self);
    }];
    
    [_oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_titleLabel.mas_bottom).offset(40 * HEIGHT_RATIO);
    }];
    
    [_oneDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_oneTitleLabel.mas_bottom);
    }];
    
    [_twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_oneDescLabel.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [_twoDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_twoTitleLabel.mas_bottom);
    }];
    
    [_threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_twoDescLabel.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [_threeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10 * WIDTH_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
        make.top.equalTo(_threeTitleLabel.mas_bottom);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_threeDescLabel).offset(100 * HEIGHT_RATIO);
    }];
}

@end
