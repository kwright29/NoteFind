//
//  ProfileViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import <Parse/Parse.h>
#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *userFullName;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *userSchool;
@property (strong, nonatomic) IBOutlet UILabel *userMajor;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterSegmentCtrl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUserInfo];
}

- (void)setUpUserInfo {
    PFUser *currentUser = PFUser.currentUser;
    self.userFullName.text = currentUser[@"fullName"];
    self.username.text = [NSString stringWithFormat:@"@%@",currentUser[@"username"]];
    self.userSchool.text = currentUser[@"school"];
    self.userMajor.text = currentUser[@"major"];
        
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
