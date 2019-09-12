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
    self.defaultSymbols = @[@"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™",
                            @"π", @"√", @"∞",@"≈", @"≤", @"≥", @"±", @"≠", @"©", @"™"];
    [self setDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Sharing

- (IBAction)sharePressed:(id)sender {
    UIAlertController *alert =  [UIAlertController
                                 alertControllerWithTitle:@"Поделиться"
                                 message:[@"Поделитесь ссылкой на Казахскую Клавиатуру+ в App Store\n\n" stringByAppendingString: APP_STORE_URL]
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Скопировать ссылку"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                             pasteboard.string = APP_STORE_URL;
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



#pragma mark - Reviews

- (IBAction)ratePressed:(id)sender {
    UIAlertController *alert =  [UIAlertController
                                 alertControllerWithTitle:@"Оценить"
                                 message:@"Вам понравилась Казахская Клавиатура+?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction
                         actionWithTitle:@"Да, я хочу оставить отзыв"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             NSURL *url = [NSURL URLWithString:APP_STORE_REVIEWS_URL];
                             [[UIApplication sharedApplication] openURL:url];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction *no = [UIAlertAction
                         actionWithTitle:@"Нет, я хочу сообщить об ошибке"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                            NSURL *url = [NSURL URLWithString:[REVIEW_EMAIL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                             [[UIApplication sharedApplication] openURL:url];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:yes];
    [alert addAction:no];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - Settings

- (void)setDefaults {
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_SUITE];
    
    // Default extra symbols
    if ([self.defaults objectForKey:KEY_DEFAULT_SYMBOLS] == nil) {
        [self.defaults setObject:self.defaultSymbols forKey:KEY_DEFAULT_SYMBOLS];
    }
    if ([self.defaults objectForKey:KEY_SYMBOLS] == nil) {
        [self.defaults setObject:self.defaultSymbols forKey:KEY_SYMBOLS];
    }
    
    // Default configurable settings
    if ([self.defaults objectForKey:KEY_SOUND] == nil) {
        [self.defaults setBool:YES forKey:KEY_SOUND];
    }
    if ([self.defaults objectForKey:KEY_LATIN] == nil) {
        [self.defaults setBool:NO forKey:KEY_LATIN];
    }
    if ([self.defaults objectForKey:KEY_AUTO] == nil) {
        [self.defaults setBool:YES forKey:KEY_AUTO];
    }
    if ([self.defaults objectForKey:KEY_CAPS] == nil) {
        [self.defaults setBool:YES forKey:KEY_CAPS];
    }
    if ([self.defaults objectForKey:KEY_DOT] == nil) {
        [self.defaults setBool:YES forKey:KEY_DOT];
    }

    [self.defaults synchronize];
}

@end
