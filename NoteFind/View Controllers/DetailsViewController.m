//
//  DetailsViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 8/8/22.
//

#import "DetailsViewController.h"
#import "OfflineDataManager.h"
#import "OfflineNote+CoreDataClass.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isOffline) {
        [self setUpOfflineNote];
    }
}

- (void)setUpOfflineNote {
    [self.detailsNoteImage setImage:[OfflineDataManager getImageFromData:self.offlineNote.noteFileData]];
    self.detailsNoteTitle.text = self.offlineNote.title;
    self.detailsNoteDescription.text = self.offlineNote.caption;
    self.detailsNoteUsername.text = [NSString stringWithFormat:@"updated by: @%@", self.offlineNote.username];
}



@end
