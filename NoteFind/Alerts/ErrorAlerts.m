//
//  ErrorAlerts.m
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import "ErrorAlerts.h"

@implementation ErrorAlerts

+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withVC:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:okAction];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
