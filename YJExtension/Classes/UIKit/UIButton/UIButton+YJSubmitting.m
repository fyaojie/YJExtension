//
//  UIButton+YJSubmitting.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIButton+YJSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *yj_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *yj_spinnerView;
@property(nonatomic, strong) UILabel *yj_spinnerTitleLabel;

@end

@implementation UIButton (YJSubmitting)

- (void)yj_beginSubmitting:(NSString *)title {
    [self yj_endSubmitting];
    
    self.yj_submitting = @YES;
    self.hidden = YES;
    
    self.yj_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.yj_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.yj_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.yj_modalView.layer.borderWidth = self.layer.borderWidth;
    self.yj_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.yj_modalView.bounds;
    self.yj_spinnerView = [[UIActivityIndicatorView alloc]
                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.yj_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.yj_spinnerView.bounds;
    self.yj_spinnerView.frame = CGRectMake(
                                           15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                           spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.yj_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.yj_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.yj_spinnerTitleLabel.text = title;
    self.yj_spinnerTitleLabel.font = self.titleLabel.font;
    self.yj_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.yj_modalView addSubview:self.yj_spinnerView];
    [self.yj_modalView addSubview:self.yj_spinnerTitleLabel];
    [self.superview addSubview:self.yj_modalView];
    [self.yj_spinnerView startAnimating];
}

- (void)yj_endSubmitting {
    if (!self.isYJSubmitting.boolValue) {
        return;
    }
    
    self.yj_submitting = @NO;
    self.hidden = NO;
    
    [self.yj_modalView removeFromSuperview];
    self.yj_modalView = nil;
    self.yj_spinnerView = nil;
    self.yj_spinnerTitleLabel = nil;
}

- (NSNumber *)isYJSubmitting {
    return objc_getAssociatedObject(self, @selector(setYj_submitting:));
}

- (void)setYj_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setYj_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)yj_spinnerView {
    return objc_getAssociatedObject(self, @selector(setYj_spinnerView:));
}

- (void)setYj_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setYj_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)yj_modalView {
    return objc_getAssociatedObject(self, @selector(setYj_modalView:));
    
}

- (void)setYj_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setYj_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)yj_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setYj_spinnerTitleLabel:));
}

- (void)setYj_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setYj_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
