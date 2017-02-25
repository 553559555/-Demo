//
//  SignHeaderView.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "SignHeaderView.h"
#import <Masonry.h>
#import "Common.h"

@interface SignHeaderView()

@property (nonatomic,strong) UIImageView    *backgourdImageView;
@property (nonatomic,strong) UIButton       *rightButton;
@property (nonatomic,strong) UILabel        *signTimeLabel;

@end

@implementation SignHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addChildViews];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;

}

- (void)rightButtonWithClick {
    
}

- (void)signButtonWithClick {
    if (self.signButtonClick) {
        self.signButtonClick();
    }
}

- (void)addChildViews {
    
    self.backgourdImageView = [[UIImageView alloc] init];
    self.backgourdImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.backgourdImageView];
    
    self.rightButton = [[UIButton alloc] init];
    [self.rightButton setTitle:@"抽奖记录" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonWithClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    
    self.signButton = [[UIButton alloc] init];
    self.signButton.backgroundColor = [UIColor greenColor];
    [self.signButton setTitle:@"签到" forState:UIControlStateNormal];
    [self.signButton setTitle:@"已签到" forState:UIControlStateSelected];
    [self.signButton addTarget:self action:@selector(signButtonWithClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signButton];
    
    self.signTimeLabel = [[UILabel alloc] init];
    self.signTimeLabel.text = @"本月已积累签到 1 天";
    self.signTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.signTimeLabel.textColor = [UIColor whiteColor];
    self.signTimeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.signTimeLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backgourdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(750 * WIDTH_RATIO, 320 * HEIGHT_RATIO));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10 * HEIGHT_RATIO);
        make.right.equalTo(self).offset(-10 * WIDTH_RATIO);
    }];
    
    [self.signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(100 * HEIGHT_RATIO);
        make.size.mas_equalTo(CGSizeMake(172 * WIDTH_RATIO, 172 * HEIGHT_RATIO));
    }];
    
    [self.signTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.signButton.mas_bottom).offset(10 * HEIGHT_RATIO);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.signTimeLabel).offset(10 * HEIGHT_RATIO);
    }];
}

@end
