//
//  UIButton+YJBadge.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YJBadge)

@property (strong, nonatomic) UILabel *yj_badge;

/** Badge数值 */
@property (nonatomic) NSString *yj_badgeValue;
/** Badge颜色 */
@property (nonatomic) UIColor *yj_badgeBGColor;
/** 字体颜色 */
@property (nonatomic) UIColor *yj_badgeTextColor;
/** 字体大小 */
@property (nonatomic) UIFont *yj_badgeFont;
/** Badge大小 */
@property (nonatomic) CGFloat yj_badgePadding;
/** 最小尺寸 */
@property (nonatomic) CGFloat yj_badgeMinSize;
/** X轴 */
@property (nonatomic) CGFloat yj_badgeOriginX;
/** Y轴 */
@property (nonatomic) CGFloat yj_badgeOriginY;
/** 当值为0的时候是否隐藏 */
@property BOOL yj_shouldHideBadgeAtZero;
/** 当值发生变化时是否显示动画 */
@property BOOL yj_shouldAnimateBadge;


@end
