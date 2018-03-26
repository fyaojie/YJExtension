//
//  UIButton+YJBadge.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIButton+YJBadge.h"
#import <objc/runtime.h>

NSString const *yj_UIButton_badgeKey = @"yj_UIButton_badgeKey";

NSString const *yj_UIButton_badgeBGColorKey = @"yj_UIButton_badgeBGColorKey";
NSString const *yj_UIButton_badgeTextColorKey = @"yj_UIButton_badgeTextColorKey";
NSString const *yj_UIButton_badgeFontKey = @"yj_UIButton_badgeFontKey";
NSString const *yj_UIButton_badgePaddingKey = @"yj_UIButton_badgePaddingKey";
NSString const *yj_UIButton_badgeMinSizeKey = @"yj_UIButton_badgeMinSizeKey";
NSString const *yj_UIButton_badgeOriginXKey = @"yj_UIButton_badgeOriginXKey";
NSString const *yj_UIButton_badgeOriginYKey = @"yj_UIButton_badgeOriginYKey";
NSString const *yj_UIButton_shouldHideBadgeAtZeroKey = @"yj_UIButton_shouldHideBadgeAtZeroKey";
NSString const *yj_UIButton_shouldAnimateBadgeKey = @"yj_UIButton_shouldAnimateBadgeKey";
NSString const *yj_UIButton_badgeValueKey = @"yj_UIButton_badgeValueKey";


@implementation UIButton (YJBadge)

/**
 告诉编译器你会动态生成setter和getter方法，不会要编译器帮你生成
 */
@dynamic yj_badge;
@dynamic yj_badgeValue, yj_badgeBGColor, yj_badgeTextColor, yj_badgeFont;
@dynamic yj_badgePadding, yj_badgeMinSize, yj_badgeOriginX, yj_badgeOriginY;
@dynamic yj_shouldHideBadgeAtZero, yj_shouldAnimateBadge;

- (void)yj_badgeInit
{
    // Default design initialization
    self.yj_badgeBGColor   = [UIColor redColor];
    self.yj_badgeTextColor = [UIColor whiteColor];
    self.yj_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.yj_badgePadding   = 6;
    self.yj_badgeMinSize   = 8;
    self.yj_badgeOriginX   = self.frame.size.width - self.yj_badge.frame.size.width/2;
    self.yj_badgeOriginY   = -4;
    self.yj_shouldHideBadgeAtZero = YES;
    self.yj_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)yj_refreshBadge
{
    // Change new attributes
    self.yj_badge.textColor        = self.yj_badgeTextColor;
    self.yj_badge.backgroundColor  = self.yj_badgeBGColor;
    self.yj_badge.font             = self.yj_badgeFont;
}

- (CGSize) yj_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self yj_duplicateLabel:self.yj_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)yj_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self yj_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.yj_badgeMinSize) ? self.yj_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.yj_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.yj_badge.frame = CGRectMake(self.yj_badgeOriginX, self.yj_badgeOriginY, minWidth + padding, minHeight + padding);
    self.yj_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.yj_badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)yj_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.yj_shouldAnimateBadge && ![self.yj_badge.text isEqualToString:self.yj_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.yj_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.yj_badge.text = self.yj_badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self yj_updateBadgeFrame];
    }];
}

- (UILabel *)yj_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)yj_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.yj_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.yj_badge removeFromSuperview];
        self.yj_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)yj_badge {
    return objc_getAssociatedObject(self, &yj_UIButton_badgeKey);
}
-(void)setYj_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &yj_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)yj_badgeValue {
    return objc_getAssociatedObject(self, &yj_UIButton_badgeValueKey);
}
-(void) setYj_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &yj_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.yj_shouldHideBadgeAtZero)) {
        [self yj_removeBadge];
    } else if (!self.yj_badge) {
        // Create a new badge because not existing
        self.yj_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.yj_badgeOriginX, self.yj_badgeOriginY, 20, 20)];
        self.yj_badge.textColor            = self.yj_badgeTextColor;
        self.yj_badge.backgroundColor      = self.yj_badgeBGColor;
        self.yj_badge.font                 = self.yj_badgeFont;
        self.yj_badge.textAlignment        = NSTextAlignmentCenter;
        [self yj_badgeInit];
        [self addSubview:self.yj_badge];
        [self yj_updateBadgeValueAnimated:NO];
    } else {
        [self yj_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)yj_badgeBGColor {
    return objc_getAssociatedObject(self, &yj_UIButton_badgeBGColorKey);
}
-(void)setYj_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &yj_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_refreshBadge];
    }
}

// Badge text color
-(UIColor *)yj_badgeTextColor {
    return objc_getAssociatedObject(self, &yj_UIButton_badgeTextColorKey);
}
-(void)setYj_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &yj_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_refreshBadge];
    }
}

// Badge font
-(UIFont *)yj_badgeFont {
    return objc_getAssociatedObject(self, &yj_UIButton_badgeFontKey);
}
-(void)setYj_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &yj_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) yj_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setYj_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &yj_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) yj_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setYj_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &yj_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) yj_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setYj_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &yj_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_updateBadgeFrame];
    }
}

-(CGFloat) yj_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setYj_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &yj_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yj_badge) {
        [self yj_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) yj_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setYj_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &yj_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) yj_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &yj_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setYj_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &yj_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
