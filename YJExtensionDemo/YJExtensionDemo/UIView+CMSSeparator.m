//
//  UIView+CMSSeparator.m
//  cmsmobilesecurities
//
//  Created by 申健 on 2018/6/4.
//  Copyright © 2018年 cms. All rights reserved.
//

#import "UIView+CMSSeparator.h"
#import <objc/runtime.h>
#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]


static CGFloat lineWeight;

@interface UIView ()

@property (nonatomic, strong) CAShapeLayer *private_topLayer;
@property (nonatomic, strong) CAShapeLayer *private_bottomLayer;
@property (nonatomic, strong) CAShapeLayer *private_leftLayer;
@property (nonatomic, strong) CAShapeLayer *private_rightLayer;

@end

@implementation UIView (CMSSeparator)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([UIScreen mainScreen].scale >= 3) {
            lineWeight = 2 / [UIScreen mainScreen].scale;
        } else {
            lineWeight = 1 / [UIScreen mainScreen].scale;
        }
        
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(layoutSubviews)), class_getInstanceMethod([self class], @selector(cms_view_layoutSubviews)));
    });
    
}

- (void)cms_view_layoutSubviews {
    [self cms_view_layoutSubviews];
    [self cms_view_updateSeparators];
}

- (void)cms_view_updateSeparators {
    //the top separator
    if (self.showTopSeparator) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.private_topLayer.frame = CGRectMake(self.topSeparatorInsets.left, self.topSeparatorInsets.top, self.frame.size.width - self.topSeparatorInsets.left - self.topSeparatorInsets.right, self.separatorWidth);
        [self.private_topLayer setBackgroundColor:self.cms_separatorColor.CGColor];
        [CATransaction commit];
    } else {
        CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_topLayer));
        if (layer) {
            [self.private_topLayer removeFromSuperlayer];
            self.private_topLayer = nil;
        }
    }
    
    //the bottom separator
    if (self.showBottomSeparator) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.private_bottomLayer.frame = CGRectMake(self.bottomSeparatorInsets.left, self.frame.size.height - self.bottomSeparatorInsets.bottom - self.separatorWidth, self.frame.size.width - self.bottomSeparatorInsets.left - self.bottomSeparatorInsets.right, self.separatorWidth);
        [self.private_bottomLayer setBackgroundColor:self.cms_separatorColor.CGColor];
        [CATransaction commit];
    } else {
        CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_bottomLayer));
        if (layer) {
            [self.private_bottomLayer removeFromSuperlayer];
            self.private_bottomLayer = nil;
        }
    }
    
    //the left separator
    if (self.showLeftSeparator) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.private_leftLayer.frame = CGRectMake(self.leftSeparatorInsets.left, self.leftSeparatorInsets.top,self.separatorWidth, self.frame.size.height - self.leftSeparatorInsets.bottom - self.leftSeparatorInsets.top);
        [self.private_leftLayer setBackgroundColor:self.cms_separatorColor.CGColor];
        [CATransaction commit];
    } else {
        CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_leftLayer));
        if (layer) {
            [self.private_leftLayer removeFromSuperlayer];
            self.private_leftLayer = nil;
        }
    }
    
    //the right separator
    if (self.showRightSeparator) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.private_rightLayer.frame = CGRectMake(self.frame.size.width - self.rightSeparatorInsets.right - self.separatorWidth, self.rightSeparatorInsets.top, self.separatorWidth, self.frame.size.height - self.rightSeparatorInsets.bottom - self.rightSeparatorInsets.top);
        [self.private_rightLayer setBackgroundColor:self.cms_separatorColor.CGColor];
        [CATransaction commit];
    } else {
        CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_rightLayer));
        if (layer) {
            [self.private_rightLayer removeFromSuperlayer];
            self.private_rightLayer = nil;
        }
    }
}

#pragma mark - public properties' setters && getters

- (CGFloat)separatorWidth {
    NSNumber *number = objc_getAssociatedObject(self, @selector(separatorWidth));
    if (number) {
        return [number floatValue];
    }
    return lineWeight;
}

- (void)setSeparatorWidth:(CGFloat)separatorWidth
{
    if (separatorWidth < 0) {
        separatorWidth = lineWeight;
    }
    objc_setAssociatedObject(self, @selector(separatorWidth), @(separatorWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIColor *)cms_separatorColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(cms_separatorColor));
    if (color) {
        return color;
    }
    return [UIColor redColor];
//    return HEXCOLOR(0xeeeeee);
}

- (void)setCms_separatorColor:(UIColor *)separatorColor
{
    objc_setAssociatedObject(self, @selector(cms_separatorColor), separatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIEdgeInsets)topSeparatorInsets
{
    NSString *insets = objc_getAssociatedObject(self, @selector(topSeparatorInsets));
    if (insets) {
        return UIEdgeInsetsFromString(insets);
    }
    return UIEdgeInsetsZero;
}

- (void)setTopSeparatorInsets:(UIEdgeInsets)topSeparatorInsets
{
    objc_setAssociatedObject(self, @selector(topSeparatorInsets), NSStringFromUIEdgeInsets(topSeparatorInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIEdgeInsets)bottomSeparatorInsets
{
    NSString *insets = objc_getAssociatedObject(self, @selector(bottomSeparatorInsets));
    if (insets) {
        return UIEdgeInsetsFromString(insets);
    }
    return UIEdgeInsetsZero;
}

- (void)setBottomSeparatorInsets:(UIEdgeInsets)bottomSeparatorInsets
{
    objc_setAssociatedObject(self, @selector(bottomSeparatorInsets), NSStringFromUIEdgeInsets(bottomSeparatorInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIEdgeInsets)leftSeparatorInsets
{
    NSString *insets = objc_getAssociatedObject(self, @selector(leftSeparatorInsets));
    if (insets) {
        return UIEdgeInsetsFromString(insets);
    }
    return UIEdgeInsetsZero;
}

- (void)setLeftSeparatorInsets:(UIEdgeInsets)leftSeparatorInsets
{
    objc_setAssociatedObject(self, @selector(leftSeparatorInsets), NSStringFromUIEdgeInsets(leftSeparatorInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIEdgeInsets)rightSeparatorInsets
{
    NSString *insets = objc_getAssociatedObject(self, @selector(rightSeparatorInsets));
    if (insets) {
        return UIEdgeInsetsFromString(insets);
    }
    return UIEdgeInsetsZero;
}

- (void)setRightSeparatorInsets:(UIEdgeInsets)rightSeparatorInsets
{
    objc_setAssociatedObject(self, @selector(rightSeparatorInsets), NSStringFromUIEdgeInsets(rightSeparatorInsets), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (BOOL)showTopSeparator
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(showTopSeparator));
    return [number boolValue];
}

- (void)setShowTopSeparator:(BOOL)showTopSeparator
{
    objc_setAssociatedObject(self, @selector(showTopSeparator), @(showTopSeparator), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (BOOL)showBottomSeparator
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(showBottomSeparator));
    return [number boolValue];
}

- (void)setShowBottomSeparator:(BOOL)showBottomSeparator
{
    objc_setAssociatedObject(self, @selector(showBottomSeparator), @(showBottomSeparator), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (BOOL)showLeftSeparator
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(showLeftSeparator));
    return [number boolValue];
}

- (void)setShowLeftSeparator:(BOOL)showLeftSeparator
{
    objc_setAssociatedObject(self, @selector(showLeftSeparator), @(showLeftSeparator), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (BOOL)showRightSeparator
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(showRightSeparator));
    return [number boolValue];
}

- (void)setShowRightSeparator:(BOOL)showRightSeparator
{
    objc_setAssociatedObject(self, @selector(showRightSeparator), @(showRightSeparator), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

#pragma end

#pragma mark - private properties setters && getters

- (CAShapeLayer *)private_topLayer
{
    CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_topLayer));
    if (!layer) {
        layer = [CAShapeLayer layer];
        [layer setFillColor:[UIColor clearColor].CGColor];
        [layer setLineJoin:kCALineJoinRound];
        
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, @selector(private_topLayer), layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layer;
}

- (void)setPrivate_topLayer:(CAShapeLayer *)private_topLayer
{
    objc_setAssociatedObject(self, @selector(private_topLayer), private_topLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)private_bottomLayer
{
    CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_bottomLayer));
    if (!layer) {
        layer = [CAShapeLayer layer];
        [layer setBounds:self.bounds];
        [layer setFillColor:[UIColor clearColor].CGColor];
        [layer setLineJoin:kCALineJoinRound];
        
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, @selector(private_bottomLayer), layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layer;
}

- (void)setPrivate_bottomLayer:(CAShapeLayer *)private_bottomLayer
{
    objc_setAssociatedObject(self, @selector(private_bottomLayer), private_bottomLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)private_leftLayer
{
    CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_leftLayer));
    if (!layer) {
        layer = [CAShapeLayer layer];
        [layer setBounds:self.bounds];
        [layer setFillColor:[UIColor clearColor].CGColor];
        [layer setLineJoin:kCALineJoinRound];
        
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, @selector(private_leftLayer), layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layer;
}

- (void)setPrivate_leftLayer:(CAShapeLayer *)private_leftLayer
{
    objc_setAssociatedObject(self, @selector(private_leftLayer), private_leftLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)private_rightLayer
{
    CAShapeLayer *layer = objc_getAssociatedObject(self, @selector(private_rightLayer));
    if (!layer) {
        layer = [CAShapeLayer layer];
        [layer setBounds:self.bounds];
        [layer setFillColor:[UIColor clearColor].CGColor];
        [layer setLineJoin:kCALineJoinRound];
        
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, @selector(private_rightLayer), layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return layer;
}

- (void)setPrivate_rightLayer:(CAShapeLayer *)private_rightLayer
{
    objc_setAssociatedObject(self, @selector(private_rightLayer), private_rightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma end

@end

