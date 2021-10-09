//
//  UIControl+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIControl+YJExtension.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>

#define UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(id x))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)(id x) = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block(sender);                                                                \
}                                                                           \
}

@implementation UIControl (YJExtension)

@end


@implementation UIControl (YJBlock)

UICONTROL_EVENT(yj_touchDown, TouchDown)
UICONTROL_EVENT(yj_touchDownRepeat, TouchDownRepeat)
UICONTROL_EVENT(yj_touchDragInside, TouchDragInside)
UICONTROL_EVENT(yj_touchDragOutside, TouchDragOutside)
UICONTROL_EVENT(yj_touchDragEnter, TouchDragEnter)
UICONTROL_EVENT(yj_touchDragExit, TouchDragExit)
UICONTROL_EVENT(yj_touchUpInside, TouchUpInside)
UICONTROL_EVENT(yj_touchUpOutside, TouchUpOutside)
UICONTROL_EVENT(yj_touchCancel, TouchCancel)
UICONTROL_EVENT(yj_valueChanged, ValueChanged)
UICONTROL_EVENT(yj_editingDidBegin, EditingDidBegin)
UICONTROL_EVENT(yj_editingChanged, EditingChanged)
UICONTROL_EVENT(yj_editingDidEnd, EditingDidEnd)
UICONTROL_EVENT(yj_editingDidEndOnExit, EditingDidEndOnExit)

@end

// Key for the dictionary of sounds for control events.
static char const * const yj_kSoundsKey = "yj_kSoundsKey";
@implementation UIControl (YJSound)

- (void)yj_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent
{
    // Remove the old UI sound.
    NSString *oldSoundKey = [NSString stringWithFormat:@"%zd", (unsigned long)controlEvent];
    AVAudioPlayer *oldSound = [self yj_sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
    
    // Set appropriate category for UI sounds.
    // Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    // Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;
    
    // Create and prepare the sound.
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    NSString *controlEventKey = [NSString stringWithFormat:@"%zd", (unsigned long)controlEvent];
    NSMutableDictionary *sounds = [self yj_sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    
    // Play the sound for the control event.
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setYj_sounds:(NSMutableDictionary *)sounds
{
    objc_setAssociatedObject(self, yj_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)yj_sounds
{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, yj_kSoundsKey);
    
    // If sounds is not yet created, create it.
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        // Save it for later.
        [self setYj_sounds:sounds];
    }
    
    return sounds;
}
@end
