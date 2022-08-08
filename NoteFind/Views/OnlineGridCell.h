//
//  OnlineGridCell.h
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//

#import "Parse/PFImageView.h"
#import <UIKit/UIKit.h>

@class Note;

NS_ASSUME_NONNULL_BEGIN

@interface OnlineGridCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet PFImageView *notePostImage;
@property (strong, nonatomic) Note *gridNote;
@end

NS_ASSUME_NONNULL_END
