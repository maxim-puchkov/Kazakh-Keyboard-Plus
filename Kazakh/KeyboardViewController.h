//
//  KeyboardViewController.h
//  Kazakh
//
//  Created by admin on 2016-01-05.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Keyboard.h"
#import "Constants.h"

@interface KeyboardViewController : UIInputViewController

@property (strong, nonatomic) Keyboard *keyboard;
@property (strong, nonatomic) NSTimer *deleting;
// @property (strong, nonatomic) NSTimer *holdSpace;

@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSArray *symbols;

@property (strong, nonatomic) NSUserDefaults *defaults;

@property BOOL enableSounds;
@property BOOL enableTranslation;
@property BOOL enableAutoCapitalization;
@property BOOL enableCapslock;
@property BOOL enableDotShortcut;



#pragma mark - Version 1.0
#pragma mark - View

- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)updateViewConstraints;

- (void)didReceiveMemoryWarning;



#pragma mark - Text editing

- (void)textWillChange:(id<UITextInput>)textInput;
- (void)textDidChange:(id<UITextInput>)textInput;
- (void)textFieldDidBeginEditing:(UITextField *)textField;



#pragma mark - Keyboard initialization

- (void)setUpKeyboardAppearance;
- (void)addKeyboardGestures;
- (void)setKeyValues;



#pragma mark - Keyboard keys

- (void)keyPressed:(UIButton *)sender;
- (void)keyButtonPress:(id)sender;
- (void)keyButtonRelease:(id)sender;


#pragma mark Caps lock
- (void)setCapslockImage;
- (void)adjustCapslock;
- (void)capslockTouchDownRepeat:(id)sender event:(UIEvent *)event;

- (void)turnOnCapital:(id)sender event:(UIEvent *)event;
- (void)invalidateCapital;


#pragma mark Symbols
- (void)showNumeric;
- (void)showSymbols;
- (void)showSpecialCharacters;
- (void)hideSpecialCharacters;


#pragma mark Space
- (void)spacePressed;


#pragma mark Return
- (void)returnPressed;


#pragma mark Delete
- (void)deleteCharacter;
- (void)deletePressed;
- (void)deleteReleased;


#pragma mark Globe
- (void)globePressed;



#pragma mark - Keyboard settings

- (void)dotShortcut;
- (void)autocapitalize;

- (void)__attribute__((deprecated))click;
- (void)__attribute__((deprecated))playKeyPressSound:(NSInteger)type;



#pragma mark - Animation

- (void)changeSpaceTitle;



#pragma mark - Version 2.0

- (void)playSound:(SystemSoundID)soundID;

- (void)playClickSound;

- (void)playDeleteSound;

- (void)playModifierSound;

- (void)readSettings;

- (NSArray<NSArray <NSString *> *> *)groupSymbols;

- (void)translatePreviousToLatin;

//- (void)spaceReleased;



#pragma mark - Version 2.1

- (void)invalidateTimers;

@end
