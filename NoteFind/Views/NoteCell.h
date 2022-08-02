//
//  NoteCell.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import <Parse/Parse.h>
#import <Parse/ParseUIConstants.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DataFailureDelegate
- (void)showErrorMessage;
@end

@interface NoteCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *postUsername;
@property (strong, nonatomic) IBOutlet PFImageView *postNote;
@property (strong, nonatomic) IBOutlet UILabel *postCaption;
@property (strong, nonatomic) IBOutlet UILabel *postTitle;
@property (strong, nonatomic) Note *note;
@property (nonatomic, weak) id <DataFailureDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
