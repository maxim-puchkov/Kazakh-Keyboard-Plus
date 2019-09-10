//
//  SettingsTableViewController.m
//  Kazakh Keyboard
//
//  Created by admin on 2018-03-05.
//  Copyright © 2018 Maxim Puchkov. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController () <UITextFieldDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *empty = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = empty;
    
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:SUITE_NAME];
    [self.soundSwitch setOn:[self.defaults boolForKey:@"Sound"]];
    [self.latinSwitch setOn:[self.defaults boolForKey:@"Latin"]];
    
    //NSArray *test = @[@"✓", @"✗", @"÷",@"±", @"∩", @"∪", @"℃", @"👋", @"🇰🇿", @"👍",
    //                  @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    
    self.defaultSymbols = @[@"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™",
                            @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    
    [self resetDefeaults];
    
    int i = 0;
    for (UITextField *textField in self.symbols) {
        [textField setDelegate:self];
        NSArray<NSString *> *symbols = [self.defaults objectForKey:@"Symbols"];
        [textField setText:symbols[i++]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setEmptyToDefault];
    for (UITextField *textField in self.symbols) {
        [self adjustTextField:textField];
    }
    [self save];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setEmptyToDefault];
    [self adjustTextField:textField];
    [textField resignFirstResponder];
    [self save];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 20;
}

- (IBAction)changeSoundSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:@"Sound"];
    [self.defaults synchronize];
}

- (IBAction)changeTranslationSettings:(id)sender {
    [self.defaults setBool:[sender isOn] forKey:@"Latin"];
    [self.defaults synchronize];
}

- (void)save {
    int i = 0;
    NSMutableArray<NSString *> *symbols = [[NSMutableArray alloc] init];
    for (UITextField *textField in self.symbols) {
        symbols[i++] = textField.text;
    }
    [self.defaults setObject:[symbols copy] forKey:@"Symbols"];
    [self.defaults synchronize];
}

- (void)adjustTextField:(UITextField *)textField {
    if (textField.text.length > 1) {
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:0];
        NSString *firstCharacter = [textField.text substringWithRange:range];
        [textField setText:firstCharacter];
    }
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

- (void)resetDefeaults {
    if ([self.defaults objectForKey:@"Symbols"] == nil) {
        [self.defaults setObject:self.defaultSymbols forKey:@"Symbols"];
    }
    [self.defaults synchronize];
}

@end
