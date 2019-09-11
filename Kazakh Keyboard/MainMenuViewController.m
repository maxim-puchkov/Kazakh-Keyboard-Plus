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


#pragma mark - Sharing

- (IBAction)sharePressed:(id)sender {
    UIAlertController *alert =  [UIAlertController
                                 alertControllerWithTitle:@"Поделиться"
                                 message:@"Вы можете отправить ссылку на Казахскую Клавиатуру+ друзьям!"
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
                         actionWithTitle:@"Да"
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
                            NSURL *url = [NSURL URLWithString:[SUPPORT_EMAIL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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


//- (IBAction)gotoReviews:(id)sender {
//    NSURL *url = [NSURL URLWithString:APP_STORE_REVIEWS_URL];
//    [[UIApplication sharedApplication] openURL:url];
//}

- (void)resetDefeaults {
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_SUITE];
    if ([self.defaults objectForKey:@"Sound"] == nil) {
        [self.defaults setBool:YES forKey:@"Sound"];
        [self.defaults setBool:NO  forKey:@"Latin"];
    }
    [self.defaults synchronize];
}

@end
