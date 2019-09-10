//
//  Keyboard.h
//  Kazakh Keyboard
//
//  Created by admin on 2016-01-02.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardMainButtons.h"

@interface Keyboard : UIView

@property (strong, nonatomic) IBOutletCollection(KeyboardMainButtons) NSArray *keyButtons;
@property (strong, nonatomic) IBOutletCollection(KeyboardMainButtons) NSArray *specialCharacters;

@property (weak, nonatomic) IBOutlet UIButton *capslockButton;
@property (weak, nonatomic) IBOutlet UIButton *symbolsButton;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIButton *globeButton;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *adjustedDeleteButton;

@property (nonatomic) BOOL capslock;
@property (nonatomic) BOOL capital;
@property (nonatomic) BOOL darkAppearance;
@property (nonatomic) int set;

@end