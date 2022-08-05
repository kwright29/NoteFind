//
//  ProfileViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "AppDelegate.h"
#import "OfflineNote+CoreDataClass.h"
#import "OfflineDataManager.h"
#import "OfflineGridCell.h"
#import "OnlineGridCell.h"
#import "ErrorAlerts.h"
#import "Note.h"
#import "ProfileViewController.h"

#import <Parse/Parse.h>



@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *userFullName;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *userSchool;
@property (strong, nonatomic) IBOutlet UILabel *userMajor;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filterSegmentCtrl;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *onlineNotes;
@property (strong, nonatomic) NSMutableArray<OfflineNote *> *offlineNotes;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self setUpUserInfo];
    [self getOnlineNotes];
}

- (void)setUpUserInfo {
    PFUser *currentUser = PFUser.currentUser;
    self.userFullName.text = currentUser[@"fullName"];
    self.username.text = [NSString stringWithFormat:@"@%@",currentUser[@"username"]];
    self.userSchool.text = currentUser[@"school"];
    self.userMajor.text = currentUser[@"major"];
        
}

- (void)getOnlineNotes {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    [noteQuery includeKey:@"author"];
    
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
    OfflineDataManager *dataManager = [[OfflineDataManager alloc]init];
    self.offlineNotes = (NSMutableArray *)[dataManager getOfflineNotes];
    [self.collectionView reloadData];
}


- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.filterSegmentCtrl.selectedSegmentIndex == 0) {
        OnlineGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineGridCell" forIndexPath:indexPath];
        cell.gridNote = self.onlineNotes[indexPath.row];
        cell.notePost.file = cell.gridNote.note;
        [cell.notePost loadInBackground];
        
        return cell;
    }
    if (self.filterSegmentCtrl.selectedSegmentIndex == 1) {
        OfflineGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OfflineGridCell" forIndexPath:indexPath];
        OfflineNote *offlineNote = self.offlineNotes[indexPath.row];
        NSData *imageData = offlineNote.noteFileData;
        UIImage *img = [OfflineDataManager getImageFromData:imageData];
        [cell.notePost setImage:img];
        
        return cell;
        
    }
    
   
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.filterSegmentCtrl.selectedSegmentIndex == 0) {
        return self.onlineNotes.count;
    }
    return self.offlineNotes.count;
}

- (IBAction)didChangeSegment:(id)sender {
    if (self.filterSegmentCtrl.selectedSegmentIndex == 0) {
        [self getOnlineNotes];
    }
    if (self.filterSegmentCtrl.selectedSegmentIndex == 1) {
        [self getOfflineNotes];
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
