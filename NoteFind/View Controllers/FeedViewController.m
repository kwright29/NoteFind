//
//  FeedViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "ErrorAlerts.h"
#import "FeedViewController.h"
#import "LoginViewController.h"
#import "NewNoteViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import "SceneDelegate.h"

#import <Parse/Parse.h>


@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate, PostDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) Note *latestNote;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self getNotes];
    
}

- (IBAction)didTapPost:(id)sender {
    [self performSegueWithIdentifier:@"newPost" sender:nil];
}

- (void) getNotes {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    [noteQuery includeKey:@"author"];
    
    [noteQuery findObjectsInBackgroundWithBlock:^(NSArray<Note *> *notes, NSError *error) {
        if (notes) {
            self.notes = (NSMutableArray *)notes;
            [self.tableView reloadData];
        } else {
            [ErrorAlerts showAlertWithTitle:@"couldn't load notes" withMessage:@"failure loading notes. please refresh and try again." withVC:self];
        }
    }];

}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NoteCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    cell.note = self.notes[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            [ErrorAlerts showAlertWithTitle:@"logout failure" withMessage:@"user failed to logout. please try again" withVC:self];
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            sceneDelegate.window.rootViewController = loginVC;
        }
    }];

}

- (void)didSharePost {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    [noteQuery includeKey:@"author"];
    [noteQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        self.latestNote = (Note *)object;
        [self.notes insertObject:self.latestNote atIndex:0];
        [self.tableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }];
  
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"newPost"]) {
        NewNoteViewController *newNoteVC = [segue destinationViewController];
        newNoteVC.postDelegate = self;
    }
    if ([[segue identifier] isEqualToString:@"detailsView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        DetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.onlineNote = self.notes[indexPath.row];
        detailsVC.isOffline = NO;
    }
}

@end
