//
//  SettingsTableViewController.h
//  Kazakh Keyboard
//
//  Created by admin on 2018-03-05.
//  Copyright © 2018 Maxim Puchkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

const int SECTION_COUNT;
const int SECTION_SIZE[3];


@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *latinSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *capslockSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *dotSwitch;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *symbols;

@property (strong, nonatomic) NSArray<NSString *> *defaultSymbols;

@property (strong, nonatomic) NSUserDefaults *defaults;

@end
