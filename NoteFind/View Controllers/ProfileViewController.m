//
//  ProfileViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (nonatomic) BOOL notion;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapLink:(id)sender {
   
    
}

- (void)selectApp {
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Third Party App" message:@"Please select the app you want to link to your NoteFind account" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *notion = [UIAlertAction actionWithTitle:@"Notion" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.notion = YES;
        }];
        // add the OK action to the alert controller
        [alert addAction:notion];
        
        [self presentViewController:alert animated:YES completion:^{
            /*optional code for what happens after the alert controller has finished presenting*/
        }];

}

- (void)notionLink {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://api.notion.com/v1/oauth/authorize?owner=user&client_id=463558a3-725e-4f37-b6d3-0889894f68de&redirect_uri=https%3A%2F%2Fexample.com%2Fauth%2Fnotion%2Fcallback&response_type=code"];
    
    [application openURL:url options:@{} completionHandler:<#^(BOOL success)completion#>]
    
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://api.notion.com/v1/oauth/authorize?owner=user&client_id=463558a3-725e-4f37-b6d3-0889894f68de&redirect_uri=https%3A%2F%2Fexample.com%2Fauth%2Fnotion%2Fcallback&response_type=code"]];

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
