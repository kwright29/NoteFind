//
//  TagCell.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Tags.h"
#import "Parse/ParseUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tagTitle;
@property (strong, nonatomic) IBOutlet UIButton *checkbox;

@property (strong, nonatomic) Tags *tags;


- (void) setTag;

@end

NS_ASSUME_NONNULL_END
