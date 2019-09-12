//
//  SettingsTableViewController.m
//  Kazakh Keyboard
//
//  Created by admin on 2018-03-05.
//  Copyright © 2018 Maxim Puchkov. All rights reserved.
//

#import "SettingsTableViewController.h"

const int SECTION_COUNT = 3;
const int SECTION_SIZE[3] = {5, 20, 1};


@interface SettingsTableViewController () <UITextFieldDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Application settings
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_SUITE];
    self.defaultSymbols = [self.defaults objectForKey:KEY_DEFAULT_SYMBOLS];
    
    // Refresh view to display saved settings
    [self refreshAllViews];
    
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
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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



#pragma mark - Settings reset

- (IBAction)resetPressed:(id)sender {
    UIAlertController *alert =  [UIAlertController
                                 alertControllerWithTitle:@"Сбросить настройки"
                                 message:@"Все настройки и сохраненные дополнительные символы будут сброшены. Это действие нельзя отменить."
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction
                          actionWithTitle:@"Подтвердить"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction *action) {
                              [self reset];
                              [self refreshAllViews];
                              [alert dismissViewControllerAnimated:YES completion:nil];
                          }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)reset {
    [self.defaults setObject:self.defaultSymbols forKey:KEY_DEFAULT_SYMBOLS];
    [self.defaults setObject:self.defaultSymbols forKey:KEY_SYMBOLS];
    [self.defaults setBool:YES forKey:KEY_SOUND];
    [self.defaults setBool:NO forKey:KEY_LATIN];
    [self.defaults setBool:YES forKey:KEY_AUTO];
    [self.defaults setBool:YES forKey:KEY_CAPS];
    [self.defaults setBool:YES forKey:KEY_DOT];
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
    NSArray<NSString *> *defaultSymbols = [self.defaults objectForKey:KEY_DEFAULT_SYMBOLS];
    int i = 0;
    for (UITextField *textField in self.symbols) {
        if (textField.text.length < 1) {
            [textField setText:defaultSymbols[i]];
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



#pragma mark - Views

- (void)refreshAllViews {
    [self refreshSwitches];
    [self refreshSymbols];
}

- (void)refreshSwitches {
    [self.soundSwitch setOn:[self.defaults boolForKey:KEY_SOUND]];
    [self.latinSwitch setOn:[self.defaults boolForKey:KEY_LATIN]];
    [self.autoSwitch setOn:[self.defaults boolForKey:KEY_AUTO]];
    [self.capslockSwitch setOn:[self.defaults boolForKey:KEY_CAPS]];
    [self.dotSwitch setOn:[self.defaults boolForKey:KEY_DOT]];
}

- (void)refreshSymbols {
    NSArray<NSString *> *savedSymbols = [self.defaults objectForKey:KEY_SYMBOLS];
    int i = 0;
    for (UITextField *textField in self.symbols) {
        [textField setDelegate:self];
        [textField setText:savedSymbols[i]];
        i++;
    }
}

@end
