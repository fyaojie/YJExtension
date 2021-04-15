//
//  UIView+CMSSeparator.h
//  cmsmobilesecurities
//
//  Created by 申健 on 2018/6/4.
//  Copyright © 2018年 cms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CMSSeparator)

@property (nonatomic, assign) CGFloat separatorWidth;
@property (nonatomic, strong) UIColor *cms_separatorColor;
@property (nonatomic, assign) BOOL showTopSeparator;
@property (nonatomic, assign) BOOL showBottomSeparator;
@property (nonatomic, assign) BOOL showLeftSeparator;
@property (nonatomic, assign) BOOL showRightSeparator;
@property (nonatomic, assign) UIEdgeInsets topSeparatorInsets;
@property (nonatomic, assign) UIEdgeInsets bottomSeparatorInsets;
@property (nonatomic, assign) UIEdgeInsets leftSeparatorInsets;
@property (nonatomic, assign) UIEdgeInsets rightSeparatorInsets;

@end
