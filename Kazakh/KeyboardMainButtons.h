//
//  KeyboardMainButtons.h
//  Kazakh Keyboard
//
//  Created by admin on 2016-01-02.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardMainButtons : UIButton

+ (instancetype)keyboardMainButtons;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@end
