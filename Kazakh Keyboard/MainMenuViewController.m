//
//  MainMenuViewController.m
//  Kazakh Keyboard
//
//  Created by admin on 2016-01-17.
//  Copyright © 2016 Maxim Puchkov. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self resetDefeaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sharePressed:(id)sender {
    UIAlertController *alert =  [UIAlertController
                                 alertControllerWithTitle:@"Скопировать ссылку на приложение?"
                                 message:@"Ссылкой можно поделиться с друзьями!"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Да"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                             pasteboard.string = APP_STORE_URL;
                             [alert dismissViewControllerAnimated:YES completion:nil]; 
                         }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)gotoReviews:(id)sender {
    NSURL *url = [NSURL URLWithString: APP_STORE_REVIEWS_URL];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)resetDefeaults {
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName: APP_SUITE];
    if ([self.defaults objectForKey:@"Sound"] == nil) {
        [self.defaults setBool:YES forKey:@"Sound"];
        [self.defaults setBool:NO  forKey:@"Latin"];
    }
    [self.defaults synchronize];
}

@end
