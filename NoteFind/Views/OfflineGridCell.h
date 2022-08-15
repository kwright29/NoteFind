//
//  OfflineGridCell.h
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class OfflineNote;

@interface OfflineGridCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *notePostImage;
@property (strong, nonatomic) OfflineNote *currentOfflineNote;
@end

NS_ASSUME_NONNULL_END
