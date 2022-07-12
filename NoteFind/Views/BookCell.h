//
//  BookCell.h
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TextbookDelegate

- (void)addBook:(NSString *)bookTitle;
- (void)removeBook:(NSString *)bookTitle;

@end

@interface BookCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthors;
@property (strong, nonatomic) Book *book;
@property (nonatomic, weak) id <TextbookDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *checkbox;

-(void)setBook:(Book *)book;

@end

NS_ASSUME_NONNULL_END
