//
//  KeyboardViewController.m
//  Kazakh
//
//  Created by admin on 2016-01-05.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController


#pragma mark - View Controller Methods

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readSettings];
    
    // Perform custom UI setup here
    self.keyboard.set = 0;
    self.keys = @[
                  // alphabetic
                  @[
                      @[
                          // row 1
                          @[@"Ә", @"ә"],
                          @[@"I", @"i"],
                          @[@"Ң", @"ң"],
                          @[@"Ғ", @"ғ"],
                          @[@"Ү", @"ү"],
                          @[@"Ұ", @"ұ"],
                          @[@"Қ", @"қ"],
                          @[@"Ө", @"ө"],
                          @[@"Һ", @"һ"],
                          @[@"Ъ", @"ъ"],
                          @[@"Ё", @"ё"]
                          ],
                      
                      @[
                          // row 2
                          @[@"Й", @"й"],
                          @[@"Ц", @"ц"],
                          @[@"У", @"у"],
                          @[@"К", @"к"],
                          @[@"Е", @"е"],
                          @[@"Н", @"н"],
                          @[@"Г", @"г"],
                          @[@"Ш", @"ш"],
                          @[@"Щ", @"щ"],
                          @[@"З", @"з"],
                          @[@"Х", @"х"]
                          ],
                      
                      @[
                          // row 3
                          @[@"Ф", @"ф"],
                          @[@"Ы", @"ы"],
                          @[@"В", @"в"],
                          @[@"А", @"а"],
                          @[@"П", @"п"],
                          @[@"Р", @"р"],
                          @[@"О", @"о"],
                          @[@"Л", @"л"],
                          @[@"Д", @"д"],
                          @[@"Ж", @"ж"],
                          @[@"Э", @"э"]
                          ],
                      
                      @[
                          // row 4
                          @[@"Я", @"я"],
                          @[@"Ч", @"ч"],
                          @[@"С", @"с"],
                          @[@"М", @"м"],
                          @[@"И", @"и"],
                          @[@"Т", @"т"],
                          @[@"Ь", @"ь"],
                          @[@"Б", @"б"],
                          @[@"Ю", @"ю"],
                          ]
                      ],
                  
                  
                  // numeric
                  @[
                      /*
                      @[
                          // row 1
                          @[@"π", @"π"],
                          @[@"√", @"√"],
                          @[@"∞", @"∞"],
                          @[@"≈", @"≈"],
                          @[@"≤", @"≤"],
                          @[@"≥", @"≥"],
                          @[@"±", @"±"],
                          @[@"≠", @"≠"],
                          @[@"©", @"©"],
                          @[@"™", @"™"],
                          ],
                      */
                      
                      [self symbolsFormatted],
                      
                      @[
                          // row 2
                          @[@"1", @"["],
                          @[@"2", @"]"],
                          @[@"3", @"{"],
                          @[@"4", @"}"],
                          @[@"5", @"#"],
                          @[@"6", @"%"],
                          @[@"7", @"^"],
                          @[@"8", @"*"],
                          @[@"9", @"+"],
                          @[@"0", @"="],
                          ],
                      
                      @[
                          // row 3
                          @[@"-", @"_"],
                          @[@"/", @"\\"],
                          @[@":", @"|"],
                          @[@";", @"~"],
                          @[@"(", @"<"],
                          @[@")", @">"],
                          @[@"$", @"€"],
                          @[@"&", @"£"],
                          @[@"@", @"¥"],
                          @[@"\"", @"•"],
                          ]
                      ]
                  ];
    
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"Keyboard" owner:nil options:nil] objectAtIndex:0];
    
    self.view = self.keyboard;
    self.keyboard.capslockButton.adjustsImageWhenHighlighted = NO;
    
    [self addKeyboardGestures];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat _expandedHeight = 259;
    NSLayoutConstraint *_heightConstraint =
    [NSLayoutConstraint constraintWithItem: self.view
                                 attribute: NSLayoutAttributeHeight
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: nil
                                 attribute: NSLayoutAttributeNotAnAttribute
                                multiplier: 0.0
                                  constant: _expandedHeight];
    [self.view addConstraint: _heightConstraint];
    
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    before = [before substringWithRange:NSMakeRange(([before length] - 1), 1)];
    
    if (before == nil) {
        self.keyboard.capital = YES;
        [self adjustCapslock];
    } else {
        [self autocapitalize];
    }
    self.keyboard.capslock = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:SPACE_ANIMATION_DELAY
                                     target:self
                                   selector:@selector(changeSpaceTitle)
                                   userInfo:nil
                                    repeats:NO];
    
    [self setUpKeyboardAppearance];
    [self setKeyValues];
    [self adjustCapslock];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self invalidateTimers];
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
    
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    before = [before substringWithRange:NSMakeRange(([before length] - 1), 1)];
    
    if (before == nil) {
        self.keyboard.capital = YES;
        [self adjustCapslock];
    }
    
    self.keyboard.set = 0;
    [self setKeyValues];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // Keyboard is visbile
}

#pragma mark - Keyboard Buttons


/**
 Add keyboard gesture recognizers.
 */
- (void)addKeyboardGestures {
    [self.keyboard.capslockButton addTarget:self action:@selector(turnOnCapital:event:) forControlEvents:UIControlEventTouchDown];
    [self.keyboard.capslockButton addTarget:self action:@selector(capslockTouchDownRepeat:event:) forControlEvents:UIControlEventTouchDownRepeat];
    
    [self.keyboard.symbolsButton addTarget:self action:@selector(showSymbols) forControlEvents:UIControlEventTouchUpInside];

    [self.keyboard.setButton addTarget:self action:@selector(showNumeric) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.globeButton addTarget:self action:@selector(globePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.globeButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.keyboard.spaceButton addTarget:self action:@selector(spacePressed) forControlEvents:UIControlEventTouchDown];
    [self.keyboard.spaceButton addTarget:self action:@selector(spaceReleased) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.returnButton addTarget:self action:@selector(returnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.deleteButton addTarget:self action:@selector(deletePressed) forControlEvents:UIControlEventTouchDown];
    [self.keyboard.deleteButton addTarget:self action:@selector(deleteReleased) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.adjustedDeleteButton addTarget:self action:@selector(deletePressed) forControlEvents:UIControlEventTouchDown];
    [self.keyboard.adjustedDeleteButton addTarget:self action:@selector(deleteReleased) forControlEvents:UIControlEventTouchUpInside];
    
    for (UIButton *key in self.keyboard.keyButtons) {
        [key addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (UIButton *key in self.keyboard.specialCharacters) {
        [key addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

/**
 Perform actions when a key is pressed.
 */
- (void)keyPressed:(UIButton *)sender {
    //[self playKeyPressSound:0];
    [self playClickSound];
    NSString *currentTitle = sender.currentTitle;
    if (self.tranlsateToLatin) {
        currentTitle = [self toLatin:currentTitle];
    }
    [self.textDocumentProxy insertText:currentTitle];
    if ([currentTitle isEqual: @"'"] && self.keyboard.set != 0) {
        [self showNumeric];
    }
    [self invalidateCapital];
    [self invalidateTimers];
}

/**
 Set keyboard values depending on the current set of characters.
 */
- (void)setKeyValues {
    NSString *title;
    if (self.keyboard.set == 0) {
        for (int r = 0; r < 4; r++) {
            for (int i = 0; i < [self.keys[0][r] count]; i++) {
                if (self.keyboard.capital || self.keyboard.capslock) {
                    title = self.keys[0][r][i][0];
                } else {
                    title = self.keys[0][r][i][1];
                }
                UIButton *key = self.keyboard.keyButtons[i+r*11];
                [key setTitle:title forState:UIControlStateNormal];
            }
        }
    } else {
        for (int r = 0; r < 3; r++) {
            for (int i = 0; i < [self.keys[1][r] count]; i++) {
                title = self.keys[1][r][i][self.keyboard.set-1];
                UIButton *key = self.keyboard.specialCharacters[i + r * 10];
                [key setTitle:title forState:UIControlStateNormal];
            }
        }
        [self showSpecialCharacters];
    }
}

#pragma mark Capslock

/**
 Turn on capital letter.
    
 @param sender Unknown parameter.
 
 @param event Unknown parameter.
 */
- (void)turnOnCapital:(id)sender event:(UIEvent *)event {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    if (!self.keyboard.capital && !self.keyboard.capslock) {
        self.keyboard.capital = YES;
    } else if (self.keyboard.capital || self.keyboard.capslock) {
        self.keyboard.capital = NO;
        self.keyboard.capslock = NO;
    }
    [self adjustCapslock];
}

/**
 Turn on capslock when capslock button was pressed twice.
 
 @param sender Unknown parameter.
 
 @param event Unknown parameter.
 */
- (void)capslockTouchDownRepeat:(id)sender event:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.tapCount == 2) {
        if (!self.keyboard.capslock) {
            self.keyboard.capslock = YES;
        }
    }
    [self adjustCapslock];
}

/**
 Set capslock image depending on its status.
 */
- (void)setCapslockImage {
    UIImage *lowercase;
    UIImage *capital;
    UIImage *capslock;
    UIImage *active;
    UIImage *inactive;
    UIImage *currentState;
    UIImage *currentStateBackground;
    
    if (self.keyboard.darkAppearance) {
        active = [UIImage imageNamed:@"button_black_key"];
        inactive = [UIImage imageNamed:@"button_black_system"];
        capslock = [UIImage imageNamed:@"capslock_white"];
        capital = [UIImage imageNamed:@"capital_white"];
        lowercase  = [UIImage imageNamed:@"lowercase_white"];
    } else {
        active = [UIImage imageNamed:@"button_white_key"];
        inactive = [UIImage imageNamed:@"button_white_system"];
        capslock = [UIImage imageNamed:@"capslock_black"];
        capital = [UIImage imageNamed:@"capital_black"];
        lowercase  = [UIImage imageNamed:@"lowercase_black"];
    }

    if (self.keyboard.capslock) {
        currentState = capslock;
        currentStateBackground = active;
    } else if (self.keyboard.capital) {
        currentState = capital;
        currentStateBackground = active;
    } else {
        currentState = lowercase;
        currentStateBackground = inactive;
    }
    [self.keyboard.capslockButton setImage:currentState forState:UIControlStateNormal];
    [self.keyboard.capslockButton setBackgroundImage:currentStateBackground forState:UIControlStateNormal];
}

/**
 Check capslock status and adjust it for this status.
 */
- (void)adjustCapslock {
    [self setKeyValues];
    [self setCapslockImage];
}

/**
 Invalidate next capital letter.
 */
- (void)invalidateCapital {
    if (self.keyboard.capital) {
        self.keyboard.capital = NO;
        [self adjustCapslock];
    }
}

#pragma mark Symbols

/**
 Show numeric layout on the keyboard.
 */
- (void)showNumeric {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    if (self.keyboard.set == 0) {
        self.keyboard.set = 1;
        [self.keyboard.setButton setTitle:@"AӘБ" forState:UIControlStateNormal];
        [self.keyboard.symbolsButton setTitle:@"+=#" forState:UIControlStateNormal];
        self.keyboard.capslockButton.hidden = YES;
        self.keyboard.deleteButton.hidden = YES;
        self.keyboard.adjustedDeleteButton.hidden = NO;
        self.keyboard.capslock = NO;
        //self.keyboard.capital = NO;
        self.keyboard.symbolsButton.hidden = NO;
        [self adjustCapslock];
        [self showSpecialCharacters];
    } else {
        self.keyboard.set = 0;
        [self.keyboard.setButton setTitle:@"123" forState:UIControlStateNormal];
        self.keyboard.capslockButton.hidden = NO;
        self.keyboard.symbolsButton.hidden = YES;
        self.keyboard.adjustedDeleteButton.hidden = YES;
        self.keyboard.deleteButton.hidden = NO;
        [self hideSpecialCharacters];
    }
    [self setKeyValues];
    [self invalidateTimers];
}

/**
 Show symbols layout on the keyboard.
 */
- (void)showSymbols {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    if (self.keyboard.set == 1) {
        self.keyboard.set = 2;
        [self.keyboard.symbolsButton setTitle:@"123" forState:UIControlStateNormal];
    } else {
        self.keyboard.set = 1;
        [self.keyboard.symbolsButton setTitle:@"#+=" forState:UIControlStateNormal];
    }
    [self setKeyValues];
}

/**
 Show special characters layout on the keyboard.
 */
- (void)showSpecialCharacters {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    for (UIButton *key in self.keyboard.keyButtons) {
        key.hidden = YES;
    }
    for (UIButton *key in self.keyboard.specialCharacters) {
        key.hidden = NO;
    }
}

/**
 Hide special characters layout from the keyboard.
 */
- (void)hideSpecialCharacters {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    for (UIButton *key in self.keyboard.keyButtons) {
        key.hidden = NO;
    }
    for (UIButton *key in self.keyboard.specialCharacters) {
        key.hidden = YES;
    }
}

#pragma mark Space

/**
 Insert one space into textDocumentProxy.
 */
- (void)spacePressed {
    [self playModifierSound];
    [self invalidateCapital];
    [self dotShortcut];
    [self autocapitalize];
    
    [self.textDocumentProxy insertText:@" "];
    if (self.keyboard.set != 0) {
        [self showNumeric];
    }
    
    self.holdSpace = [NSTimer scheduledTimerWithTimeInterval:1.950 target:self selector:@selector(translatePreviousToLatin) userInfo:nil repeats:NO];
    
    if (self.deleting) {
        [self deleteReleased];
    }
}

#pragma mark Return

/**
 Insert new line character into textDocumentProxy.
 */
- (void)returnPressed {
    //[self click];
    //[self playKeyPressSound:2];
    [self playModifierSound];
    [self.textDocumentProxy insertText:@"\n"];
    if (!self.keyboard.capital) {
        self.keyboard.capital = YES;
        [self adjustCapslock];
    }
    [self invalidateTimers];
}

#pragma mark Delete

/**
 Delete one character from textDocumentProxy.
 */
- (void)deleteCharacter {
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    [self playDeleteSound];
    [self.textDocumentProxy deleteBackward];
    before = [before substringWithRange:NSMakeRange(([before length] - 1), 1)];

    if (before == nil) {
        self.keyboard.capital = YES;
        [self adjustCapslock];
    }
}

/**
 Delete multiple characters from textDocumentProxy. Deletes with increased speed
 compared to -deleteCharacter().
 */
- (void)deletePressed {
    //[self click];
    //[self playKeyPressSound:1];
    [self playDeleteSound];
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    before = [before substringWithRange:NSMakeRange(([before length] - 1), 1)];
    for (int r = 0; r < 4; r++) {
        for (int i = 0; i < [self.keys[0][r] count]; i++) {
            if ([before isEqual: self.keys[0][r][i][0]]) {
                self.keyboard.capital = YES;
                [self adjustCapslock];
            }
        }
    }
    [self deleteCharacter];
    if (!self.deleting) {
        self.deleting = [NSTimer scheduledTimerWithTimeInterval:DELETE_CHARACTER_INTERVAL
                                                         target:self
                                                       selector:@selector(deleteCharacter)
                                                       userInfo:nil
                                                        repeats:YES];
    }
}

/**
 Stop deleting characters when user releases delete button.
 */
- (void)deleteReleased {
    [self.deleting invalidate];
    self.deleting = nil;
}

#pragma mark Globe

/**
 Play sound when user attempts to switch keyboards.
 */
- (void)globePressed {
    //[self playKeyPressSound:2];
    [self playModifierSound];
}

#pragma mark - Keyboard Settings

/**
 Apply keyboard appearance to dark or light
 */
- (void)setUpKeyboardAppearance {
    self.keyboard.darkAppearance = (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) ? YES : NO;
    UIColor *textColor;
    UIColor *backgroundColor;
    UIImage *globeImage;
    UIImage *buttonAppearance;
    UIImage *buttonActive;
    UIImage *systemButtonAppearance;
    UIImage *systemButtonActive;
    UIImage *spaceAppearance;
    UIImage *spaceActive;
    UIImage *returnAppearance;
    UIImage *returnActive;
    UIImage *deleteAppearance;
    
    // 2.2
    //NSString *color = self.keyboard.darkAppearance ? @"black" : @"white";
    
    if (self.keyboard.darkAppearance) {
        textColor = [UIColor whiteColor];
        globeImage = [UIImage imageNamed:@"globe_white"];
        backgroundColor = [UIColor colorWithRed:0.078 green:0.078 blue:0.078 alpha:0.2];
        buttonAppearance = [UIImage imageNamed:@"button_black_key"];
        buttonActive = [UIImage imageNamed:@"button_black_key_pressed"];
        systemButtonAppearance = [UIImage imageNamed:@"button_black_system"];
        systemButtonActive = [UIImage imageNamed:@"button_black_system_pressed"];
        spaceAppearance = [UIImage imageNamed:@"button_black_big"];
        spaceActive = [UIImage imageNamed:@"button_white_big_pressed"];
        returnAppearance = [UIImage imageNamed:@"button_black_system_big"];
        returnActive = [UIImage imageNamed:@"button_black_system_big_pressed"];
        deleteAppearance = [UIImage imageNamed:@"delete_white"];
    } else {
        textColor = [UIColor blackColor];
        globeImage = [UIImage imageNamed:@"globe_black"];
        backgroundColor = [UIColor colorWithRed:0.824 green:0.835 blue:0.859 alpha:1];
        buttonAppearance = [UIImage imageNamed:@"button_white_key"];
        buttonActive = [UIImage imageNamed:@"button_white_key_pressed"];
        systemButtonAppearance = [UIImage imageNamed:@"button_white_system"];
        systemButtonActive = [UIImage imageNamed:@"button_white_system_pressed"];
        spaceAppearance = [UIImage imageNamed:@"button_white_big"];
        spaceActive = [UIImage imageNamed:@"button_white_big_pressed"];
        returnAppearance = [UIImage imageNamed:@"button_white_system_big"];
        returnActive = [UIImage imageNamed:@"button_white_system_big_pressed"];
        deleteAppearance = [UIImage imageNamed:@"delete_black"];
    }
    
    for (UIButton *key in self.keyboard.keyButtons) {
        [key setTitleColor:textColor forState:UIControlStateNormal];
        [key setBackgroundImage:buttonAppearance forState:UIControlStateNormal];
        [key setBackgroundImage:buttonActive forState:UIControlStateHighlighted];
        [key addTarget:self action:@selector(keyButtonPress:) forControlEvents:UIControlEventTouchDown];
    }
    for (UIButton *key in self.keyboard.specialCharacters) {
        [key setTitleColor:textColor forState:UIControlStateNormal];
        [key setBackgroundImage:buttonAppearance forState:UIControlStateNormal];
        [key setBackgroundImage:buttonActive forState:UIControlStateHighlighted];
        [key addTarget:self action:@selector(keyButtonPress:) forControlEvents:UIControlEventTouchDown];
    }
    [self.keyboard.spaceButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.keyboard.spaceButton setBackgroundImage:spaceAppearance forState:UIControlStateNormal];
    [self.keyboard.spaceButton setBackgroundImage:spaceActive forState:UIControlStateHighlighted];
    [self.keyboard.returnButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.keyboard.returnButton setBackgroundImage:returnAppearance forState:UIControlStateNormal];
    [self.keyboard.returnButton setBackgroundImage:returnActive forState:UIControlStateHighlighted];
    [self.keyboard.setButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.keyboard.setButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.setButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    [self.keyboard.symbolsButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.keyboard.symbolsButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.symbolsButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    [self.keyboard.globeButton setImage:globeImage forState:UIControlStateNormal];
    [self.keyboard.globeButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.globeButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    [self.keyboard.capslockButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.capslockButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    [self.keyboard.deleteButton setImage:deleteAppearance forState:UIControlStateNormal];
    [self.keyboard.deleteButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.deleteButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    [self.keyboard.adjustedDeleteButton setImage:deleteAppearance forState:UIControlStateNormal];
    [self.keyboard.adjustedDeleteButton setBackgroundImage:systemButtonAppearance forState:UIControlStateNormal];
    [self.keyboard.adjustedDeleteButton setBackgroundImage:systemButtonActive forState:UIControlStateHighlighted];
    
    self.keyboard.backgroundColor = backgroundColor;
}

/**
 Change background image of a button when it is pressed.
 
 @param sender Button that was pressed.
 */
- (void)keyButtonPress:(id)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"button_white_key_pressed"] forState:UIControlStateApplication];
    [sender setBackgroundImage:[UIImage imageNamed:@"button_white_key_pressed"] forState:UIControlStateFocused];
    [sender setBackgroundImage:[UIImage imageNamed:@"button_white_key_pressed"] forState:UIControlStateHighlighted];
    [sender setBackgroundImage:[UIImage imageNamed:@"button_white_key_pressed"] forState:UIControlStateReserved];
}

/**
 Change background image of a button back to default.
 
 @param sender Button that was released.
 */
- (void)keyButtonRelease:(id)sender {
    UIImage *buttonAppearance;
    if (self.keyboard.darkAppearance) {
        buttonAppearance = [UIImage imageNamed:@"button_black_key"];
    } else {
        buttonAppearance = [UIImage imageNamed:@"button_white_key"];
    }
    [sender setBackgroundImage:buttonAppearance forState:UIControlStateNormal];
}

/**
 Add a dot when user presses Space twice if the character after which a dot 
 should be added is not a restricted symbol.
 */
- (void)dotShortcut {
    NSArray *restrictedCharacters = @[@"-", @":", @";", @".", @",", @"?", @"!", @" "];
    BOOL containsRestrictedCharacters = NO;
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    if ([before length] > 2) {
        before = [before substringWithRange:NSMakeRange(([before length] - 2), 2)];
        if ([[before substringWithRange:NSMakeRange(1, 1)] isEqual: @" "]) {
            for (int i=0; i<[restrictedCharacters count]; i++) {
                if ([[before substringWithRange:NSMakeRange(0, 1)] isEqual: [restrictedCharacters objectAtIndex:i]]) {
                    containsRestrictedCharacters = YES;
                    break;
                }
            }
            if (!containsRestrictedCharacters) {
                [self deleteCharacter];
                [self.textDocumentProxy insertText:@"."];
            }
        }
    }
}

/**
 Automaticaly turn on capital letter if textDocumentProxy ends with a set of
 characters ".", "!", or "?".
 */
- (void)autocapitalize {
    NSArray *allowedCharacters = @[@".", @"!", @"?"];
    BOOL endsWithAllowedCharacter = NO;
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    before = [before substringWithRange:NSMakeRange(([before length] - 1), 1)];
    for (int i = 0; i < [allowedCharacters count]; i++) {
        if ([before isEqual: [allowedCharacters objectAtIndex:i]]) {
            endsWithAllowedCharacter = YES;
            break;
        }
    }
    if (endsWithAllowedCharacter) {
        self.keyboard.capital = YES;
        [self adjustCapslock];
    }
}

#pragma mark - Customization
#pragma mark Sound 1.0 (obsolete)

/**
 Play click sound.
 */

- (void)click {
    AudioServicesPlaySystemSound(SYSTEM_SOUND_ID_CLICK);
}

/**
 Play system sound of a keyboard.
 
 @param type Type of the sound to play.
 */
- (void)playKeyPressSound:(NSInteger)type {
    NSURL *url;
    NSString *path;
    
    switch (type) {
        case 0:
            path = @"file:///System/Library/Audio/UISounds/key_press_click.caf";
            break;
        case 1:
            path = @"file:///System/Library/Audio/UISounds/key_press_delete.caf";
            break;
        case 2:
            path = @"file:///System/Library/Audio/UISounds/key_press_modifier.caf";
            break;
    }
    
    
    url = [NSURL URLWithString:path];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[url path]]) {
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
    } else {
        [self click];
    }
    
}

#pragma mark Sound 2.0

- (void)playSound:(SystemSoundID)soundID {
    if (self.soundEnabled) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            AudioServicesPlaySystemSound(soundID);
        });
    }
}

- (void)playClickSound {
    [self playSound:SYSTEM_SOUND_CLICK];
}

- (void)playDeleteSound {
    [self playSound:SYSTEM_SOUND_DELETE];
}

- (void)playModifierSound {
    [self playSound:SYSTEM_SOUND_MODIFIER];
}

#pragma mark Animation

/**
 Animate space title from keyboard name to a set title.
 */
- (void)changeSpaceTitle {
    CATransition *animation = [CATransition animation];
    animation.duration = SPACE_ANIMATION_DURATION;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.keyboard.spaceButton.layer addAnimation:animation forKey:@"changeTextTransition"];
    [self.keyboard.spaceButton setTitle:@"Бос орын" forState:UIControlStateNormal];
}

#pragma mark - Settings

- (void)readSettings {
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:SUITE_NAME];
    [self.defaults synchronize];
    self.soundEnabled = [self.defaults boolForKey:@"Sound"];
    self.tranlsateToLatin = [self.defaults boolForKey:@"Latin"];
    NSArray *arr = @[@"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™",
                     @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    self.symbols = [self.defaults arrayForKey:@"Symbols"];
    if (!self.symbols) self.symbols = arr;
}

- (NSArray<NSArray<NSString *> *> *)symbolsFormatted {
    const int ROW_SIZE = 10;
    NSMutableArray<NSArray<NSString *> *> *res = [[NSMutableArray alloc] init];
    NSArray *arr = self.symbols;
    for (int i = 0; i < [arr count] / 2; i++) {
        NSArray<NSString *> *group = @[arr[i], arr[i + ROW_SIZE]];
        [res addObject:group];
    }
    return [res copy];
}

- (NSString *)toLatin:(NSString *)str {
    NSString *res = str;
    BOOL capital = [[res uppercaseString] isEqualToString:res];
    res = [res lowercaseString];
    NSDictionary<NSString *, NSString *> *letters = @{
          @"а": @"a",
          @"б": @"b",
          @"ц": @"c",
          @"д": @"d",
          @"е": @"e",
          @"ф": @"f",
          @"г": @"g",
          @"һ": @"h",
          @"х": @"h",
          @"и": @"ı",
          @"i": @"i",
          @"й": @"ı",
          @"ж": @"j",
          @"к": @"k",
          @"л": @"l",
          @"м": @"m",
          @"н": @"n",
          @"о": @"o",
          @"п": @"p",
          @"қ": @"q",
          @"р": @"r",
          @"с": @"s",
          @"т": @"t",
          @"ұ": @"u",
          @"в": @"v",
          @"у": @"ý",
          @"ы": @"y",
          @"з": @"z",
          
          @"ә": @"á",
          @"ө": @"ó",
          @"ү": @"ú",
          @"ң": @"ń",
          @"ғ": @"ǵ",
          @"ч": @"ch",
          @"ш": @"sh",
          @"щ": @"sch",
          
          @"ц": @"ts",
          @"ь": @"'",
          @"э": @"e",
          @"ю": @"ıú",
          @"я": @"ıa"
    };
    res = [letters objectForKey:res];
    if (!res) return str;
    return capital ? [res capitalizedString] : res;
}

- (void)translatePreviousToLatin {
    NSString *before = [self.textDocumentProxy documentContextBeforeInput];
    NSString *new = @"";
    for (int i = 0; i < before.length; i++) {
        NSString *next = [before substringWithRange:NSMakeRange(i, 1)];
        next = [self toLatin:next];
        new = [new stringByAppendingString:next];
        [self.textDocumentProxy deleteBackward];
    }
    [self.textDocumentProxy insertText:new];
}

- (void)spaceReleased {
    [self.holdSpace invalidate];
    self.holdSpace = nil;
}

- (void)invalidateTimers {
    if (self.deleting) {
        [self deleteReleased];
    }
    if (self.holdSpace) {
        [self spaceReleased];
    }
}

@end
