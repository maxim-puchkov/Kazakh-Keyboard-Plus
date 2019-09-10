//
//  SettingsTableViewController.h
//  Kazakh Keyboard
//
//  Created by admin on 2018-03-05.
//  Copyright © 2018 Maxim Puchkov. All rights reserved.
//

#import "TableViewController.h"

#define SUITE_NAME @"group.com.maximpuchkov.Kazakh-Keyboard"

@interface SettingsTableViewController : TableViewController

@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *latinSwitch;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *symbols;

@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSArray<NSString *> *defaultSymbols;

@end
