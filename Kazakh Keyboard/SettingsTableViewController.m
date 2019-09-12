//
//  SettingsTableViewController.m
//  Kazakh Keyboard
//
//  Created by admin on 2018-03-05.
//  Copyright © 2018 Maxim Puchkov. All rights reserved.
//

#import "SettingsTableViewController.h"

const int N = 3;
const int SECTION_SIZE[3] = {5, 20, 1};


@interface SettingsTableViewController () <UITextFieldDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Application settings
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_SUITE];
    
    // Set symbols to default if they are not saved yet
    self.defaultSymbols = @[@"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™",
                            @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    // NSArray *test = @[@"✓", @"✗", @"÷",@"±", @"∩", @"∪", @"℃", @"👋", @"🇰🇿", @"👍", @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    [self resetDefeaults];
    
    // Update switches
    [self updateSwitches];
    [self updateSymbols];
    
    // Remove table footer
    [self setEmptyTableViewFooter];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setEmptyToDefault];
    for (UITextField *textField in self.symbols) {
        [self removeExcess:textField];
    }
    [self saveSymbols];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return N;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return section == 0 ? 5 : 20;
    return SECTION_SIZE[section];
}

- (void)setEmptyTableViewFooter {
    UIView *empty = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = empty;
}



#pragma mark - Setting options

- (IBAction)changeSoundSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:KEY_SOUND];
    [self.defaults synchronize];
}

- (IBAction)changeTranslationSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:KEY_LATIN];
    [self.defaults synchronize];
}

- (IBAction)changeAutoSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:KEY_AUTO];
    [self.defaults synchronize];
}

- (IBAction)changeCapslockSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:KEY_CAPS];
    [self.defaults synchronize];
}

- (IBAction)changeDotSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:KEY_DOT];
    [self.defaults synchronize];
}



#pragma mark - Symbol settings

- (void)saveSymbols {
    NSMutableArray<NSString *> *temp = [[NSMutableArray alloc] init];
    int i = 0;
    for (UITextField *textField in self.symbols) {
        temp[i] = textField.text;
        i++;
    }
    [self.defaults setObject:[temp copy] forKey:KEY_SYMBOLS];
    [self.defaults synchronize];
}

- (void)resetDefeaults {
    if ([self.defaults objectForKey:KEY_SYMBOLS] == nil) {
        [self.defaults setObject:self.defaultSymbols forKey:KEY_SYMBOLS];
    }
    [self.defaults synchronize];
}



#pragma mark - Text fields

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setEmptyToDefault];
    [self removeExcess:textField];
    [textField resignFirstResponder];
    [self saveSymbols];
    return YES;
}

- (void)setEmptyToDefault {
    int i = 0;
    for (UITextField *textField in self.symbols) {
        if (textField.text.length < 1) {
            [textField setText:self.defaultSymbols[i]];
        }
        i++;
    }
}

- (void)removeExcess:(UITextField *)textField {
    if (textField.text.length > 1) {
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:0];
        NSString *firstCharacter = [textField.text substringWithRange:range];
        [textField setText:firstCharacter];
    }
}



#pragma mark - View updates

- (void)updateSwitches {
    [self.soundSwitch setOn:[self.defaults boolForKey:KEY_SOUND]];
    [self.latinSwitch setOn:[self.defaults boolForKey:KEY_LATIN]];
    [self.autoSwitch setOn:[self.defaults boolForKey:KEY_AUTO]];
    [self.capslockSwitch setOn:[self.defaults boolForKey:KEY_CAPS]];
    [self.dotSwitch setOn:[self.defaults boolForKey:KEY_DOT]];
}

- (void)updateSymbols {
    NSArray<NSString *> *savedSymbols = [self.defaults objectForKey:KEY_SYMBOLS];
    int i = 0;
    for (UITextField *textField in self.symbols) {
        [textField setDelegate:self];
        [textField setText:savedSymbols[i]];
        i++;
    }
}

@end
