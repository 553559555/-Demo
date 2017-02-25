//
//  GiveRedPacketView.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/15.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "GiveRedPacketView.h"
#import <Masonry.h>
#import "Common.h"

@interface GiveRedPacketView()

@property (nonatomic,strong) UIImageView     *redImageView;
@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UILabel        *redLabel;
@property (nonatomic,strong) UILabel        *scoreLabel;
@property (nonatomic,strong) UIButton       *finishButton;

@end

@implementation GiveRedPacketView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addChildViews];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    
}

- (void)finishButtonWithClick {
    [self removeFromSuperview];
}

- (void)addChildViews {
    
    _redImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GiveRedPacketImage"]];
    [self addSubview:_redImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor yellowColor];
    _titleLabel.text = @"赠送您:";
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:_titleLabel];
    
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.textColor = [UIColor yellowColor];
    _scoreLabel.text = @"1积分";
    _scoreLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_scoreLabel];
    
    _redLabel = [[UILabel alloc] init];
    _redLabel.textAlignment = NSTextAlignmentCenter;
    _redLabel.textColor = [UIColor yellowColor];
    _redLabel.text = @"1元红包";
    _redLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_redLabel];
    
    _finishButton = [[UIButton alloc] init];
    [_finishButton setBackgroundImage:[UIImage imageNamed:@"Draw"] forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishButtonWithClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_finishButton];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(400 * WIDTH_RATIO, 600 * HEIGHT_RATIO));
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_redImageView).offset(-90 * HEIGHT_RATIO);
        make.size.mas_equalTo(CGSizeMake(200 * WIDTH_RATIO, 200 / 2.87 * HEIGHT_RATIO));
    }];
    
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(_redImageView);
    }];
    
    [_redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_scoreLabel.mas_bottom).offset(20 * HEIGHT_RATIO);
        make.width.equalTo(_redImageView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_scoreLabel.mas_top).offset(-20 * HEIGHT_RATIO);
        make.width.equalTo(_redImageView);
    }];
}

@end
