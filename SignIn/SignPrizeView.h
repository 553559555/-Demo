//
//  SignPrizeView.h
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK)(NSString *imageName);

@interface SignPrizeView : UIView

@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,copy) BLOCK cellBlock;

- (void)cellWithClick:(BLOCK)block;

@end
