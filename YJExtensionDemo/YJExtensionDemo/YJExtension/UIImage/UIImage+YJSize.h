//
//  UIImage+YJSize.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (YJSize)

/**
 *  返回网络图片的尺寸，带有header
 *
 *  @param imgURL     图片地址
 *  @param completion 返回的数据
 */
+ (void)requestSizeNoHeader:(NSURL*)imgURL completion:(UIImageSizeRequestCompleted)completion;

@end
