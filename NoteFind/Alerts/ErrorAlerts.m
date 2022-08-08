//
//  ErrorAlerts.m
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import "ErrorAlerts.h"
#import "OfflineDataManager.h"

@implementation ErrorAlerts

+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withVC:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:okAction];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)confirmingDownload:(UIViewController *)vc withNote:(Note *)note {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"downloading your note locally" message:@"are you sure you want to download this note?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"no" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OfflineDataManager *dataManager = [[OfflineDataManager alloc] init];
        [dataManager downloadNote:note];
    }];
    
    [alert addAction:no];
    [alert addAction:yes];
    
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
