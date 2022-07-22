//
//  LoginViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import "LoginViewController.h"
<<<<<<< Updated upstream
#import "Parse/Parse.h"
=======
#import "ErrorAlerts.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
>>>>>>> Stashed changes

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            if ([username isEqual:@""] || [password isEqual:@""]) {
                [ErrorAlerts alertVoidRequiredFields:self];
            } else {
                [ErrorAlerts loginFailure:self];
            }
            
        } else {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        
        }
    }];
    
    
    
}


- (void)incorrectLoginInfo {
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"incorrect username/password" message:@"the username/password you entered is incorrect. please try again." preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
