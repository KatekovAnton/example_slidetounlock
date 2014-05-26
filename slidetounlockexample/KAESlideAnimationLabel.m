//
//  KAESlideAnimationLabel.m
//  slidetounlockexample
//
//  Created by Katekov Anton on 27.05.14.
//  Copyright (c) 2014 katekovanton. All rights reserved.
//

#import "KAESlideAnimationLabel.h"

@implementation KAESlideAnimationLabel

- (void)didMoveToWindow
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEnterForeground:) name:NOTIFY_APPLICATION_WILL_ENTER_FOREGROUND object:nil];
    
    [self startAnimation];
}

- (void)onEnterForeground:(NSNotification *)notify
{
    [self startAnimation];
}

- (void)startAnimation
{
    
    [self.layer.mask removeAnimationForKey:@"position"];
    
    float y = self.frame.size.height - 10;
    y /= 2;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, y, 640 ,40);
    maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"exampleGradient"] CGImage];
    self.layer.mask = maskLayer;
    
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    frameAnimation.duration = 2.5;
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    frameAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, y)];
    frameAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320, y)];
    frameAnimation.repeatCount = HUGE_VALF;
    [maskLayer addAnimation:frameAnimation forKey:@"position"];

}

@end
