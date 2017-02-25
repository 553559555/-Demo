//
//  SignPrizeView.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "SignPrizeView.h"
#import "SignPrizeCell.h"
#import "UIColor+MQHex.h"
#import "Common.h"
#import <Masonry.h>

@interface SignPrizeView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView   *collectionView;
@property (nonatomic,strong) UILabel            *lineLabel;
@property (nonatomic,strong) UILabel            *alreadyLineLabel;
@property (nonatomic,assign) NSInteger          dayCount;
@property (nonatomic,strong) NSArray            *imageArray;
@property (nonatomic,strong) UIImageView        *image0;
@property (nonatomic,strong) UIImageView        *image1;
@property (nonatomic,strong) UIImageView        *image2;
@property (nonatomic,strong) UIImageView        *image3;
@property (nonatomic,strong) UIImageView        *image4;
@property (nonatomic,strong) UILabel            *label0;
@property (nonatomic,strong) UILabel            *label1;
@property (nonatomic,strong) UILabel            *label2;
@property (nonatomic,strong) UILabel            *label3;
@property (nonatomic,strong) UILabel            *label4;
@property (nonatomic,strong) NSArray            *imageArr;
@property (nonatomic,strong) NSArray            *lockArray;

@end

@implementation SignPrizeView

static NSString *identifier = @"signprizecell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addChildViews];
    }
    return self;
}

- (void)cellWithClick:(BLOCK)block {
    _cellBlock = block;
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    
    
}

- (NSArray *)imageArr {
    if (_imageArr == nil) {
        _imageArr = @[@{@"icon" : @"sign", @"name" : @"奖品名称"},
                      @{@"icon" : @"sign", @"name" : @"奖品名称"},
                      @{@"icon" : @"sign", @"name" : @"奖品名称"},
                      @{@"icon" : @"sign", @"name" : @"奖品名称"},
                      @{@"icon" : @"sign", @"name" : @"奖品名称"}];
    }
    return _imageArr;
}

//添加子控件
- (void)addChildViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(104 * WIDTH_RATIO, 120 * HEIGHT_RATIO);
    flowLayout.sectionInset = UIEdgeInsetsMake(40 * HEIGHT_RATIO, 20 * WIDTH_RATIO, 0, 20 * WIDTH_RATIO);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[SignPrizeCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:self.collectionView];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineLabel];
    
    _alreadyLineLabel = [[UILabel alloc] init];
    _alreadyLineLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_alreadyLineLabel];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    self.dayCount = range.length;

    self.image0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy1"]];
    self.image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy1"]];
    self.image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy1"]];
    self.image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy1"]];
    self.image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dy1"]];
    [self addSubview:self.image0];
    [self addSubview:self.image1];
    [self addSubview:self.image2];
    [self addSubview:self.image3];
    [self addSubview:self.image4];
    
    self.label0 = [[UILabel alloc] init];
    self.label0.text = @"1天";
    self.label0.font = [UIFont systemFontOfSize:12];
    self.label0.textColor = [UIColor colorWithHexString:@"949494"];
    [self addSubview:self.label0];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"7天";
    self.label1.font = [UIFont systemFontOfSize:12];
    self.label1.textColor = [UIColor colorWithHexString:@"949494"];
    [self addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"14天";
    self.label2.font = [UIFont systemFontOfSize:12];
    self.label2.textColor = [UIColor colorWithHexString:@"949494"];
    [self addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"21天";
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label3.textColor = [UIColor colorWithHexString:@"949494"];
    [self addSubview:self.label3];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.font = [UIFont systemFontOfSize:12];
    self.label4.text = [NSString stringWithFormat:@"%tu天", self.dayCount];
    self.label4.textColor = [UIColor colorWithHexString:@"949494"];
    [self addSubview:self.label4];
    
}

//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageX = (screenWith - 75 * 2 * WIDTH_RATIO) / 4;
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(200 * HEIGHT_RATIO);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom).offset(20 * HEIGHT_RATIO);
        make.left.equalTo(_collectionView).offset((20 + 52) * WIDTH_RATIO);
        make.right.equalTo(_collectionView).offset(-(20 + 52) * WIDTH_RATIO);
        make.height.mas_equalTo(5);
    }];
    
    [_alreadyLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_lineLabel);
    }];
    
    [_image0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_lineLabel.mas_left);
        make.centerY.equalTo(_lineLabel);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_RATIO, 25 * HEIGHT_RATIO));
    }];
    
    [_label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image0);
        make.top.equalTo(_image0.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image0.mas_left).offset(imageX + 12.5 * WIDTH_RATIO);
        make.centerY.equalTo(_lineLabel);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_RATIO, 25 * HEIGHT_RATIO));
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image1);
        make.top.equalTo(_image1.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image1.mas_left).offset(imageX + 12.5 * WIDTH_RATIO);
        make.centerY.equalTo(_lineLabel);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_RATIO, 25 * HEIGHT_RATIO));
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image2);
        make.top.equalTo(_image2.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [_image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image2.mas_left).offset(imageX + 12.5 * WIDTH_RATIO);
        make.centerY.equalTo(_lineLabel);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_RATIO, 25 * HEIGHT_RATIO));
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image3);
        make.top.equalTo(_image3.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    
    [_image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image3.mas_left).offset(imageX + 12.5 * WIDTH_RATIO);
        make.centerY.equalTo(_lineLabel);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_RATIO, 25 * HEIGHT_RATIO));
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_image4);
        make.top.equalTo(_image4.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_label4.mas_bottom).offset(20 * HEIGHT_RATIO);
    }];
}

//数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SignPrizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dict = self.imageArr[indexPath.row];
    cell.luck = self.lockArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.lockArray[indexPath.row][@"is_enough"] integerValue] == 1) {
        if ([self.lockArray[indexPath.row][@"is_draw"] integerValue] == 0) {
            if (self.cellBlock) {
                self.cellBlock([NSString stringWithFormat:@"sign%tu", indexPath.row]);
            }
        }
    }
}

@end
