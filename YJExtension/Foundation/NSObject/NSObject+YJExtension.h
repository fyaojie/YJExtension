//
//  NSObject+YJExtension.h
//  YJExtension
//
//  Created by symbio on 2021/4/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJExtension)
/// 适配iPhoneX系列屏幕
- (UIEdgeInsets)yj_safeAreaInsets;

/// 屏幕宽
- (CGFloat)yj_screenWidth;
/// 屏幕高
- (CGFloat)yj_screenHeight;

/// 屏幕顶部高度
- (CGFloat)yj_screenTopHeight;
/// 导航条高度
- (CGFloat)yj_navigationBarHeight;
/// 状态栏高度
- (CGFloat)yj_statusBarHeight;



/// 屏幕底部部高度
- (CGFloat)yj_screenBottomHeight;
/// 标签栏高度
- (CGFloat)yj_tabBarHeight;
/// 底部的安全区域高度
- (CGFloat)yj_bottomSafeHeight;
@end

NS_ASSUME_NONNULL_END
