//
//  KeyboardViewController.h
//  Kazakh
//
//  Created by admin on 2016-01-05.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Keyboard.h"
#import <AudioToolbox/AudioToolbox.h>

#define SYSTEM_SOUND_ID_CLICK 1104
#define DELETE_CHARACTER_INTERVAL 0.155
#define SPACE_ANIMATION_DELAY 1.210
#define SPACE_ANIMATION_DURATION 0.877

#define SYSTEM_SOUND_CLICK 1123
#define SYSTEM_SOUND_DELETE 1155
#define SYSTEM_SOUND_MODIFIER 1156
#define SUITE_NAME @"group.com.maximpuchkov.Kazakh-Keyboard"

@interface KeyboardViewController : UIInputViewController

@property (strong, nonatomic) Keyboard *keyboard;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSTimer *deleting;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSArray *symbols;
@property (strong, nonatomic) NSTimer *holdSpace;

@property BOOL soundEnabled;
@property BOOL tranlsateToLatin;

#pragma mark - Versions 1.0+ -

- (void)updateViewConstraints;

- (void)viewDidLoad;

- (void)didReceiveMemoryWarning;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)textWillChange:(id<UITextInput>)textInput;

- (void)textDidChange:(id<UITextInput>)textInput;

- (void)textFieldDidBeginEditing:(UITextField *)textField;

- (void)addKeyboardGestures;

- (void)keyPressed:(UIButton *)sender;

- (void)setKeyValues;

- (void)turnOnCapital:(id)sender event:(UIEvent *)event;

- (void)capslockTouchDownRepeat:(id)sender event:(UIEvent *)event;

- (void)setCapslockImage;

- (void)adjustCapslock;

- (void)invalidateCapital;

- (void)showNumeric;

- (void)showSymbols;

- (void)showSpecialCharacters;

- (void)hideSpecialCharacters;

- (void)spacePressed;

- (void)returnPressed;

- (void)deleteCharacter;

- (void)deletePressed;

- (void)deleteReleased;

- (void)globePressed;

- (void)setUpKeyboardAppearance;

- (void)keyButtonPress:(id)sender;

- (void)keyButtonRelease:(id)sender;

- (void)dotShortcut;

- (void)autocapitalize;

- (void)__attribute__((deprecated))click; 

- (void)__attribute__((deprecated))playKeyPressSound:(NSInteger)type;

- (void)changeSpaceTitle;

#pragma mark - Version 2.0 -

- (void)playSound:(SystemSoundID)soundID;

- (void)playClickSound;

- (void)playDeleteSound;

- (void)playModifierSound;

- (void)readSettings;

- (NSArray<NSArray <NSString *> *> *)symbolsFormatted;

- (void)translatePreviousToLatin;

- (void)spaceReleased;

#pragma mark - Version 2.1 -

- (void)invalidateTimers;

@end
