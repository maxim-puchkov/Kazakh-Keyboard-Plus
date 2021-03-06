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
                // main webiste
                url = [NSURL URLWithString:@"http://youenjoy.ru/m/ru/kk/"];
                break;
            case 1:
                // Facebook
                url = [NSURL URLWithString:@"https://www.facebook.com/profile.php?id=100006394095303"];
                break;
            case 2:
                // Instagram
                url = [NSURL URLWithString:@"https://www.instagram.com/kazakh_keyboard"];
                break;
            case 3:
                // Email to support@youenjoy.ru
                url = [NSURL URLWithString:[@"mailto:support@youenjoy.ru?subject=Казахская Клавиатура: Сообщение об ошибке" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                break;
        }
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
