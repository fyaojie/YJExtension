//
//  NSObject+YJExtension.m
//  YJExtension
//
//  Created by symbio on 2021/4/13.
//

#import "NSObject+YJExtension.h"

@implementation NSObject (YJExtension)
- (UIEdgeInsets)yj_safeAreaInsets {
    static UIEdgeInsets insets;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        insets = UIEdgeInsetsZero;
        NSArray<UIWindow *> *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            if (@available(iOS 11.0, *)) {
                if (window.safeAreaInsets.bottom != 0 ||
                    window.safeAreaInsets.top != 0 ||
                    window.safeAreaInsets.left != 0 ||
                    window.safeAreaInsets.right != 0
                    ) {
                    insets = window.safeAreaInsets;
                }
            }
        }
    });
    return insets;
}

/// 屏幕宽
- (CGFloat)yj_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
/// 屏幕高
- (CGFloat)yj_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
/// 导航条高度
- (CGFloat)yj_navigationBarHeight {
    return 44;
}
/// 状态栏高度
- (CGFloat)yj_statusBarHeight {
    return MAX(self.yj_safeAreaInsets.top, 20) ;
}
/// 屏幕顶部高度
- (CGFloat)yj_screenTopHeight {
    return self.yj_statusBarHeight + self.yj_navigationBarHeight;
}
/// 屏幕底部部高度
- (CGFloat)yj_screenBottomHeight {
    return self.yj_tabBarHeight + self.yj_bottomSafeHeight;
}
/// 标签栏高度
- (CGFloat)yj_tabBarHeight {
    return 49;
}
/// 底部的安全区域高度
- (CGFloat)yj_bottomSafeHeight {
    return self.yj_safeAreaInsets.bottom;
}

@end
