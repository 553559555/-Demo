//
//  SignViewController.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "SignViewController.h"
#import "SignHeaderView.h"
#import "SignPrizeView.h"
#import "WZCalendarView.h"
#import "SignDescView.h"
#import <Masonry.h>
#import "TigerViewController.h"
#import "GiveRedPacketView.h"
#import "Common.h"
#import "UIColor+MQHex.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface SignViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SignHeaderView *headerView;
@property (nonatomic,strong) SignPrizeView *prizeView;
@property (nonatomic,strong) WZCalendarView *calendarView;
@property (nonatomic,strong) SignDescView *descView;

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"签到";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecebeb"];
    [self addChildViews];
    [self layoutChildViews];
    
}


//点击签到
- (void)sign {
    
}

//补签
- (void)repair:(NSDictionary *)dcit {
    
}

//添加子控件
- (void)addChildViews {
    
    typeof(self) weakSelf = self;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    [self.view addSubview:self.scrollView];

    _headerView = [[SignHeaderView alloc] init];
    _headerView.signButtonClick = ^{
        [weakSelf sign];
    };
    [self.scrollView addSubview:_headerView];

    _prizeView = [[SignPrizeView alloc] init];
    [_prizeView cellWithClick:^(NSString *imageName) {
        TigerViewController *tiger = [[TigerViewController alloc] initWithImageName:imageName];
        [self.navigationController pushViewController:tiger animated:YES];
    }];
    [self.scrollView addSubview:_prizeView];
    
    _calendarView = [[WZCalendarView alloc] init];
    [_calendarView cellWithClick:^(NSDictionary *dict) {
        [weakSelf repair:dict];
    }];
    [self.scrollView addSubview:_calendarView];
    
    _descView = [[SignDescView alloc] init];
    [self.scrollView addSubview:_descView];
    
}

//布局
- (void)layoutChildViews {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.width.mas_equalTo(SCREENWIDTH);
    }];
    
    [_prizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREENWIDTH);
        make.top.equalTo(_headerView.mas_bottom);
    }];
    
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREENWIDTH);
        make.top.equalTo(_prizeView.mas_bottom).offset(16 * HEIGHT_RATIO);
    }];
    
    [_descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREENWIDTH);
        make.left.equalTo(self.scrollView);
        make.top.equalTo(_calendarView.mas_bottom).offset(16 * HEIGHT_RATIO);
    }];
    
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, 2000 * HEIGHT_RATIO);
}

@end
