//
//  RegisterViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//
#import "CameraImport.h"
#import "ErrorAlerts.h"
#import "ImportDelegate.h"
#import "Note.h"
#import "RegisterViewController.h"

#import <Parse/Parse.h>


@interface RegisterViewController () <ImportDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassField;
@property (strong, nonatomic) IBOutlet UITextField *schoolField;
@property (strong, nonatomic) IBOutlet UITextField *majorField;
@property (strong, nonatomic) IBOutlet UIButton *choosePicButton;
@property (strong, nonatomic) UIMenu *importMenu;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (strong, nonatomic) CameraImport *cameraImporter;
@property (strong, nonatomic) PFFileObject *profilePicFile;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.choosePicButton.showsMenuAsPrimaryAction = YES;
    self.cameraImporter = [[CameraImport alloc]init];
    self.cameraImporter.delegate = self;
    [self setImportMenu:self.importMenu];
}
- (void)setImportMenu:(UIMenu *)importMenu {
    //setting options for menu
    NSMutableArray *options = [[NSMutableArray alloc] init];
    
    [options addObject:[UIAction actionWithTitle:@"take picture w/ camera" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showCamera:self];
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"import from gallery" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showGallery:self];
    }]];
    
    importMenu = [UIMenu menuWithChildren:options];
    
    //setting menu to button
    self.choosePicButton.menu = importMenu;
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
        newUser[@"profilePicture"] = self.profilePicFile;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
              if (error != nil) {
                [ErrorAlerts showAlertWithTitle:@"sign up failed" withMessage:@"there was a problem with our server signing you up. please resubmit!" withVC:self];
              }
              else {
                [self performSegueWithIdentifier:@"registerSegue" sender:nil];
              }
          }];
        
    } else {
        [ErrorAlerts showAlertWithTitle:@"passwords don't match" withMessage:@"your passwords do not match. please try again" withVC:self];
    }
        
}

- (void)getImageFromCamera:(nonnull UIImage *)img {
    [self.profilePicImageView setImage:img];
    self.profilePicFile = [Note getPFFileFromImage:img];
}


@end
