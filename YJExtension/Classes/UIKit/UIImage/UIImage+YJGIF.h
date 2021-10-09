//
//  UIImage+YJGIF.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJGIF)

/*
 UIImage *animation = [UIImage animatedImageWithAnimatedGIFData:theData];
 
 我把“数据”解释为GIF。我使用GIF中的源图像创建一个动画的“UIImage”。
 I interpret `theData` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 GIF为每一帧存储一个单独的持续时间，单位为秒(百分之一秒)。然而，“UIImage”只有一个单独的、总“持续时间”属性，即浮点数。
 The GIF stores a separate duration for each frame, in units of centiseconds (hundredths of a second).  However, a `UIImage` only has a single, total `duration` property, which is a floating-point number.
 
 为了处理这种不匹配，我将每个源图像(从GIF)添加到“animation”，以匹配GIF中帧间的比率。
 To handle this mismatch, I add each source image (from the GIF) to `animation` a varying number of times to match the ratios between the frame durations in the GIF.
 
 For example, suppose the GIF contains three frames.  Frame 0 has duration 3.  Frame 1 has duration 9.  Frame 2 has duration 15.  I divide each duration by the greatest common denominator of all the durations, which is 3, and add each frame the resulting number of times.  Thus `animation` will contain frame 0 3/3 = 1 time, then frame 1 9/3 = 3 times, then frame 2 15/3 = 5 times.  I set `animation.duration` to (3+9+15)/100 = 0.27 seconds.
 */


+ (nullable UIImage *)yj_animatedImageWithAnimatedGIFData:(nullable NSData *)theData;

/*
 UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:theURL];
 
 I interpret the contents of `theURL` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 I operate exactly like `+[UIImage animatedImageWithAnimatedGIFData:]`, except that I read the data from `theURL`.  If `theURL` is not a `file:` URL, you probably want to call me on a background thread or GCD queue to avoid blocking the main thread.
 */
+ (nullable UIImage *)yj_animatedImageWithAnimatedGIFURL:(nullable NSURL *)theURL;

/**
 *  修改大小
 *
 *  @param size 变成的尺寸
 */
- (nullable UIImage *)yj_animatedImageByScalingAndCroppingToSize:(CGSize)size;
@end
