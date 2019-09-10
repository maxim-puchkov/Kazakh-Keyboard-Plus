//
//  KeyboardMainButtons.m
//  Kazakh Keyboard
//
//  Created by admin on 2016-01-02.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import "KeyboardMainButtons.h"

@implementation KeyboardMainButtons

+ (instancetype)keyboardMainButtons {
    return (KeyboardMainButtons *)[KeyboardMainButtons buttonWithType:UIButtonTypeCustom];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect relativeFrame = self.bounds;
    UIEdgeInsets hitTestEdgeInsets = UIEdgeInsetsMake(-6.5, -11.5, -6.5, -11.5);
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
