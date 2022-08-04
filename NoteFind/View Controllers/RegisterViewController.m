//
//  RegisterViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import "ErrorAlerts.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassField;
@property (strong, nonatomic) IBOutlet UITextField *schoolField;
@property (strong, nonatomic) IBOutlet UITextField *majorField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapRegister:(id)sender {
    NSString *madePassword = self.passwordField.text;
    NSString *confirmPassword = self.confirmPassField.text;
    
    
    if ([madePassword isEqual:confirmPassword]) {
        PFUser *newUser = [PFUser user];
        
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        newUser.email = self.emailField.text;
        newUser[@"fullName"] = self.nameField.text;
        newUser[@"school"] = self.schoolField.text;
        newUser[@"major"] = self.majorField.text;
        
        //TODO: set up where profile picture is finalized.
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
              if (error != nil) {
                  [ErrorAlerts showAlertWithTitle:@"sign up failed" withMessage:@"there was a problem with our server signing you up. please resubmit!" withVC:self];
                  
              }
              else {
                      [self performSegueWithIdentifier:@"registerSegue" sender:nil];
              }
          }];
        
    }   else   {
        
        [ErrorAlerts showAlertWithTitle:@"passwords don't match" withMessage:@"your passwords do not match. please try again" withVC:self];
    }
    
    
    
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
