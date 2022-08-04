//
//  LoginViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ErrorAlerts.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"

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
                [ErrorAlerts showAlertWithTitle:@"missing field(s) required" withMessage:@"one or more of the required fields are not complete. please enter your information and try again." withVC:self];
            } else {
                [ErrorAlerts showAlertWithTitle:@"login failed" withMessage:@"your email or password was entered incorrectly. please try again" withVC:self];
            }
            
        } else {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        
        }
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
