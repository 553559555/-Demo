//
//  TigerViewController.m
//  Hgdb
//
//  Created by 王壮 on 2016/12/5.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import "TigerViewController.h"
#import "ZCSlotMachine.h"
#import "UIColor+MQHex.h"
#import <Masonry.h>
#import "Common.h"
#import "GiveRedPacketView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface TigerViewController() <ZCSlotMachineDelegate, ZCSlotMachineDataSource>

@property (nonatomic,assign) NSUInteger slotOneIndex;
@property (nonatomic,assign) NSUInteger slotTwoIndex;
@property (nonatomic,assign) NSUInteger slotThreeIndex;
@property (nonatomic,assign) NSUInteger slotFourIndex;

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,strong) UIImageView *backgourdImage;

@end

@implementation TigerViewController {
@private
    ZCSlotMachine *_slotMachine;
    UIButton *_startButton;
    
    UIView *_slotContainerView;
    UIImageView *_slotOneImageView;
    UIImageView *_slotTwoImageView;
    UIImageView *_slotThreeImageView;
    UIImageView *_slotFourImageView;
    
    NSArray *_slotIcons;
}

#pragma mark - View LifeCycle

- (instancetype)initWithImageName:(NSString *)name {
    if (self = [super init]) {
        
        _imageName = name;
        _slotIcons = [NSArray arrayWithObjects:
                      [UIImage imageNamed:[NSString stringWithFormat:@"%@x", name]], [UIImage imageNamed:@"Mario"], [UIImage imageNamed:@"Nobi Nobita"], nil];
    }
    return self;
}

- (void)dealloc {
    [_startButton removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"签到抽奖";
    
    self.backgourdImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.backgourdImage.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:self.backgourdImage];
    
    _slotMachine = [[ZCSlotMachine alloc] initWithFrame:CGRectMake(0, 0, 291, 190)];
    _slotMachine.center = CGPointMake(self.view.frame.size.width / 2, 260);
    _slotMachine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _slotMachine.contentInset = UIEdgeInsetsMake(-20, 10, 50, 0);
    _slotMachine.backgroundImage = [UIImage imageNamed:@"SlotMachineBackground"];
    _slotMachine.coverImage = [UIImage imageNamed:@"SlotMachineCover"];
    
    _slotMachine.delegate = self;
    _slotMachine.dataSource = self;
    
    [self.view addSubview:_slotMachine];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImageN = [UIImage imageNamed:@"StartBtn_N"];
    UIImage *btnImageH = [UIImage imageNamed:@"StartBtn_H"];
    _startButton.frame = CGRectMake(0, 0, btnImageN.size.width, btnImageN.size.height);
    _startButton.center = CGPointMake(self.view.frame.size.width / 2, 800 * HEIGHT_RATIO);
    _startButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _startButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [_startButton setBackgroundImage:btnImageN forState:UIControlStateNormal];
    [_startButton setBackgroundImage:btnImageH forState:UIControlStateHighlighted];
    [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_startButton];
    
    UIImageView *bottomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TigerBottomImage"]];
    [self.view addSubview:bottomImage];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"fabf2d"];
    [self.view addSubview:bottomView];
    
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(300 * HEIGHT_RATIO);
    }];
    
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
}

#pragma mark - Private Methods

- (void)start {
    NSUInteger slotIconCount = [_slotIcons count];
    
    _slotOneIndex   = abs(rand() % slotIconCount);
    _slotTwoIndex   = abs(rand() % slotIconCount);
    _slotThreeIndex = abs(rand() % slotIconCount);
    
    _slotMachine.slotResults =  [NSMutableArray arrayWithObjects:
                                [NSNumber numberWithInteger:_slotOneIndex],
                                [NSNumber numberWithInteger:_slotTwoIndex],
                                [NSNumber numberWithInteger:_slotThreeIndex],
                                nil];
    
//        _slotOneIndex   = 0;
//        _slotTwoIndex   = 0;
//        _slotThreeIndex = 0;
//        _slotFourIndex  = 0;
//    
//        _slotMachine.slotResults = [NSMutableArray arrayWithObjects:
//                                    [NSNumber numberWithInteger:0],
//                                    [NSNumber numberWithInteger:0],
//                                    [NSNumber numberWithInteger:0],
//                                    [NSNumber numberWithInteger:0],
//                                    nil];
    
    if (_slotOneIndex == 0 && _slotTwoIndex == 0 && _slotThreeIndex == 0) {
        NSInteger index = arc4random() % 2 + 1;
        _slotThreeIndex = index;
        _slotMachine.slotResults[2] = [NSNumber numberWithInteger:index];
    }


    
    [_slotMachine startSliding];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    _startButton.highlighted = YES;
    [_startButton performSelector:@selector(setHighlighted:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.8];
    
    [self start];
}

#pragma mark - ZCSlotMachineDelegate

- (void)slotMachineWillStartSliding:(ZCSlotMachine *)slotMachine {
    _startButton.enabled = NO;
}

- (void)slotMachineDidEndSliding:(ZCSlotMachine *)slotMachine {
//    _startButton.enabled = YES;
    
    if (_slotOneIndex == 0 && _slotTwoIndex == 0 && _slotThreeIndex == 0 && _slotFourIndex == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"恭喜您中奖了！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *finish = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"发送网络请求");
        }];
        [alert addAction:finish];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"很遗憾，再接再厉"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *finish = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSLog(@"发送网络请求");
          }];
        [alert addAction:finish];
        
         [self presentViewController:alert animated:YES completion:nil];
    }

}

#pragma mark - ZCSlotMachineDataSource

- (NSArray *)iconsForSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    return _slotIcons;
}

- (NSUInteger)numberOfSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 3;
}

- (CGFloat)slotWidthInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 90.0f;
}

- (CGFloat)slotSpacingInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 0.1f;
}

@end
