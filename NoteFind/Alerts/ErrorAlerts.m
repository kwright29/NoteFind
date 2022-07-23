//
//  ErrorAlerts.m
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import "ErrorAlerts.h"

@implementation ErrorAlerts

+ (void)loginFailure:(LoginViewController *)loginVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"login failed" message:@"your email or password was entered incorrectly. please try again" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
    [alert addAction:okAction];
    
    [loginVC presentViewController:alert animated:YES completion:^{

    }];
    
}

+ (void)alertVoidRequiredFields:(LoginViewController *)loginVC {
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"missing field(s) required" message:@"one or more of the required fields are not complete. please enter your information and try again." preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [loginVC presentViewController:alert animated:YES completion:^{
        
    }];

}

+ (void)logoutFailure:(FeedViewController *)feedVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"logout failure" message:@"user failed to logout. please try again" preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [feedVC presentViewController:alert animated:YES completion:^{
        
    }];
}

+ (void)passwordNotConfirmed:(RegisterViewController *)regVC {
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"passwords don't match"
                                                                                   message:@"your passwords do not match. please try again"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        [alert addAction:okAction];
        
        [regVC presentViewController:alert animated:YES completion:^{
    
        }];

}
+ (void)retrieveNotesFailure:(FeedViewController *)feedVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"couldn't load notes" message:@"failure loading notes. please refresh and try again." preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [feedVC presentViewController:alert animated:YES completion:^{
        
    }];
}

+ (void)retrieveTagsFailure:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"couldn't load tags" message:@"failure loading tags. please refresh and try again." preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [vc presentViewController:alert animated:YES completion:^{
        
    }];
}

+ (void)retrieveBooksFailure:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"couldn't load books" message:@"failure loading books. please refresh and try again." preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [vc presentViewController:alert animated:YES completion:^{
        
    }];
}

+ (void)errorPostingNote:(NewNoteViewController *)newNoteVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error posting note" message:@"there was a problem trying to post your note to the feed. please try again." preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { /*handle response here */ }];
    [alert addAction:okAction];
    
    [newNoteVC presentViewController:alert animated:YES completion:^{
        
    }];
}
@end
