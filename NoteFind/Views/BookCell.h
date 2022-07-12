//
//  BookCell.h
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthors;
@property (strong, nonatomic) Book *book;

-(void)setBook:(Book *)book;

@end

NS_ASSUME_NONNULL_END
