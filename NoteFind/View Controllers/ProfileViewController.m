//
//  ProfileViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "ErrorAlerts.h"
#import "Note.h"
#import "OfflineNote+CoreDataClass.h"
#import "OfflineDataManager.h"
#import "OfflineGridCell.h"
#import "OnlineGridCell.h"
#import "ProfileViewController.h"

#import <Parse/Parse.h>



@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, DeleteDelegate>
@property (strong, nonatomic) IBOutlet PFImageView *userProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *userFullName;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *userSchool;
@property (strong, nonatomic) IBOutlet UILabel *userMajor;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterSegmentCtrl;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *onlineNotes;
@property (strong, nonatomic) NSMutableArray<OfflineNote *> *offlineNotes;
@property (strong, nonatomic) OfflineDataManager *dataManager;

@end

@implementation ProfileViewController
static int kOnlineNoteIndex = 0;
static int kOfflineNoteIndex = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.dataManager = [[OfflineDataManager alloc]init];
    self.dataManager.deleteDelegate = self;
    [self setUpUserInfo];
    [self getOnlineNotes];
}

- (void)setUpUserInfo {
    PFUser *currentUser = PFUser.currentUser;
    self.userFullName.text = currentUser[@"fullName"];
    self.username.text = [NSString stringWithFormat:@"@%@",currentUser[@"username"]];
    self.userSchool.text = currentUser[@"school"];
    self.userMajor.text = currentUser[@"major"];
    self.userProfilePic.file = currentUser[@"profilePicture"];
    [self.userProfilePic loadInBackground];
}

- (void)getOnlineNotes {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    [noteQuery includeKey:@"author"];
    [noteQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    
    [noteQuery findObjectsInBackgroundWithBlock:^(NSArray<Note *> *notes, NSError *error) {
        if (notes) {
            self.onlineNotes = (NSMutableArray *)notes;
            [self.collectionView reloadData];
        } else {
            [ErrorAlerts showAlertWithTitle:@"couldn't load notes" withMessage:@"failure loading notes. please refresh and try again." withVC:self];
        }
    }];
}

- (void)getOfflineNotes {
    self.offlineNotes = (NSMutableArray *)[self.dataManager getOfflineNotes];
    [self.collectionView reloadData];
}


- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.filterSegmentCtrl.selectedSegmentIndex == kOnlineNoteIndex) {
        OnlineGridCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineGridCell" forIndexPath:indexPath];
        cell.gridNote = self.onlineNotes[indexPath.row];
        cell.notePostImage.file = cell.gridNote.note;
        [cell.notePostImage loadInBackground];
        
        return cell;
    }
    if (self.filterSegmentCtrl.selectedSegmentIndex == kOfflineNoteIndex) {
        OfflineGridCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"OfflineGridCell" forIndexPath:indexPath];
        cell.currentOfflineNote = self.offlineNotes[indexPath.row];
        NSData *imageData = cell.currentOfflineNote.noteFileData;
        UIImage *img = [OfflineDataManager getImageFromData:imageData];
        [cell.notePostImage setImage:img];
        
        return cell;
        
    }
    
   
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.filterSegmentCtrl.selectedSegmentIndex == kOnlineNoteIndex) {
        return self.onlineNotes.count;
    }
    return self.offlineNotes.count;
}

- (IBAction)didChangeSegment:(id)sender {
    if (self.filterSegmentCtrl.selectedSegmentIndex == kOnlineNoteIndex) {
        [self getOnlineNotes];
    }
    if (self.filterSegmentCtrl.selectedSegmentIndex == kOfflineNoteIndex) {
        [self getOfflineNotes];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *detailsVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    if ([sender isKindOfClass:[OfflineGridCell class]]) {
        OfflineNote *offlineNoteExpand = self.offlineNotes[indexPath.row];
        detailsVC.offlineNote = offlineNoteExpand;
        detailsVC.isOffline = YES;
    } else {
        Note *onlineNoteExpand = self.onlineNotes[indexPath.row];
        detailsVC.onlineNote = onlineNoteExpand;
        detailsVC.isOffline = NO;
    }
}


- (void)refreshAfterDeletion {
    [self getOfflineNotes];
}


@end
