//
//  FeedViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "FeedViewController.h"
#import "NewNoteViewController.h"
<<<<<<< Updated upstream
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
=======
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import "ErrorAlerts.h"
>>>>>>> Stashed changes

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
 */

<<<<<<< Updated upstream
- (IBAction)didTapAdd:(id)sender {
=======
- (void) getNotes {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    [noteQuery includeKey:@"author"];
    
    [noteQuery findObjectsInBackgroundWithBlock:^(NSArray<Note *> *notes, NSError *error) {
        if (notes) {
            self.notes = (NSMutableArray *)notes;
            [self.tableView reloadData];
        } else {
            [ErrorAlerts retrieveNotesFailure:self];
        }
    }];
>>>>>>> Stashed changes
}

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (void)didShareNote {
    
    
}
- (IBAction)newPost:(id)sender {
    [self performSegueWithIdentifier:@"newPost" sender:nil];
}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            [ErrorAlerts logoutFailure:self];
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            sceneDelegate.window.rootViewController = loginVC;
        }
    }];

}

@end
