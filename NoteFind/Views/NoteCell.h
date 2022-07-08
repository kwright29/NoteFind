//
//  NoteCell.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *postUsername;
@property (strong, nonatomic) IBOutlet UIImageView *postNote;
@property (strong, nonatomic) IBOutlet UILabel *postCaption;

@end

NS_ASSUME_NONNULL_END
