//
//  OnlineGridCell.h
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//

#import "Parse/PFImageView.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface OnlineGridCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet PFImageView *notePost;

@end

NS_ASSUME_NONNULL_END
