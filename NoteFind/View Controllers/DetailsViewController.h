//
//  DetailsViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 8/8/22.
//

#import <UIKit/UIKit.h>
@class OfflineNote;
@class Note;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *detailsNoteImage;
@property (strong, nonatomic) IBOutlet UILabel *detailsNoteTitle;
@property (strong, nonatomic) IBOutlet UILabel *detailsNoteDescription;
@property (strong, nonatomic) IBOutlet UILabel *detailsNoteUsername;
@property (strong, nonatomic) OfflineNote *offlineNote;
@property (strong, nonatomic) Note *onlineNote;
@property (nonatomic) BOOL isOffline;
@end

NS_ASSUME_NONNULL_END
