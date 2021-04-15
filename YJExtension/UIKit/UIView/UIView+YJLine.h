//
//  UIView+YJLine.h
//  CMSPaaS
//
//  Created by SJ on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YJLine)

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

NS_ASSUME_NONNULL_END
