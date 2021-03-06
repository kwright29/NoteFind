//
//  RegisterViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import "RegisterViewController.h"
#import "Parse/Parse.h"

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
                  NSLog(@"Error: %@", error.localizedDescription);
                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error.localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  // handle response here.
                  }];
                  // add the OK action to the alert controller
                  [alert addAction:okAction];
                  
                  [self presentViewController:alert animated:YES completion:^{
                      // optional code for what happens after the alert controller has finished presenting
                  }];              } else {
                  NSLog(@"User registered successfully");
                  // TODO: manually segue to logged in view
                      [self performSegueWithIdentifier:@"registerSegue" sender:nil];
              }
          }];
        
    }   else   {
        
        [self passwordNotConfirmed];
    }
    
    
    
}

- (void)passwordNotConfirmed {
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"passwords don't match"
                                                                                   message:@"your passwords do not match. please try again"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
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
