//
//  SignHeaderView.h
//  Hgdb
//
//  Created by 王壮 on 2016/12/1.
//  Copyright © 2016年 HGDB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignHeaderView : UIView

@property (nonatomic,strong) NSDictionary   *dict;
@property (nonatomic,strong) UIButton       *signButton;
@property (nonatomic,copy)   void (^signButtonClick)();

@end
