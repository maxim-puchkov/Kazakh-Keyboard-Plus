//
//  TableViewController.m
//  Kazakh Keyboard
//
//  Created by admin on 2016-01-16.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                // App webiste
                url = [NSURL URLWithString:APP_URL];
                break;
            case 1:
                // Facebook
                url = [NSURL URLWithString:SUPPORT_FACEBOOK];
                break;
            case 2:
                // Instagram
                url = [NSURL URLWithString:SUPPORT_INSTAGRAM];
                break;
            case 3:
                // Support email 
                url = [NSURL URLWithString:[SUPPORT_EMAIL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                break;
        }
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
