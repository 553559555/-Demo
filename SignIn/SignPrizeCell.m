//
//  SignPrizeCell.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "SignPrizeCell.h"
#import <Masonry.h>
#import "Common.h"

@interface SignPrizeCell()

@property (nonatomic,strong) UIImageView *prizeImage;
@property (nonatomic,strong) UIImageView *maskImage;
@property (nonatomic,strong) UILabel     *descLabel;

@end

@implementation SignPrizeCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.prizeImage = [[UIImageView alloc] init];
        self.prizeImage.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.prizeImage];
        
        self.maskImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
        [self.contentView addSubview:self.maskImage];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.text = @"首次签到";
        self.descLabel.textAlignment = NSTextAlignmentCenter;
        self.descLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.descLabel];
        
    }
    return self;
}

- (void)setLuck:(NSDictionary *)luck {
    if ([luck[@"is_enough"] integerValue] == 1) {
        self.maskImage.hidden = YES;
    } else {
        self.maskImage.hidden = NO;
    }
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    
    self.prizeImage.image = [UIImage imageNamed:dict[@"icon"]];
    self.descLabel.text = dict[@"name"];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.prizeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width);
    }];
    
    [self.maskImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prizeImage);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.prizeImage.mas_bottom).offset(10 * HEIGHT_RATIO);
        make.left.right.equalTo(self);
    }];
    
}

@end
