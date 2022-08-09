//
//  DetailsViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 8/8/22.
//

#import "DetailsViewController.h"
#import "OfflineDataManager.h"
#import "OfflineNote+CoreDataClass.h"

@interface DetailsViewController () <UIGestureRecognizerDelegate>

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isOffline) {
        [self setUpOfflineNote];
    } else {
        [self setUpOnlineNote];
    }
}

- (void)setUpOfflineNote {
    [self.detailsNoteImage setImage:[OfflineDataManager getImageFromData:self.offlineNote.noteFileData]];
    self.detailsNoteTitle.text = self.offlineNote.title;
    self.detailsNoteDescription.text = self.offlineNote.caption;
    self.detailsNoteUsername.text = [NSString stringWithFormat:@"uploaded by: @%@", self.offlineNote.username];
}

- (void)setUpOnlineNote {
    NSData *imageData = [self.onlineNote.note getData];
    [self.detailsNoteImage setImage:[OfflineDataManager getImageFromData:imageData]];
    self.detailsNoteTitle.text = self.onlineNote.title;
    self.detailsNoteDescription.text = self.onlineNote.noteDescription;
    self.detailsNoteUsername.text = [NSString stringWithFormat:@"uploaded by: @%@", self.onlineNote.author.username];

}

@end
