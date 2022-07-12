//
//  BookCell.m
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import "BookCell.h"
#import "UIImageView+AFNetworking.h"

@interface BookCell ()

@property (nonatomic) BOOL checked;

@end

@implementation BookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBook:(Book *)book {
    _book = book;
    self.checked = NO;
    self.bookTitle.text = self.book.title;
    
    NSArray *authors = self.book.authors;
    NSString *authorsList = [[authors valueForKey:@"description"] componentsJoinedByString:@", "];

    self.bookAuthors.text = authorsList;
    
    self.coverImageView.image = nil;
    if (self.book.bookCoverURL != nil) {
        [self.coverImageView setImageWithURL:self.book.bookCoverURL];
    }
    
}
- (IBAction)didTapBook:(id)sender {
    if (self.checked) {
        self.checked = NO;
        [self.checkbox setSelected:NO];
        [self.delegate removeBook:self.bookTitle.text];
    } else {
        self.checked = YES;
        [self.checkbox setSelected:YES];
        [self.delegate addBook:self.bookTitle.text];
    }
}

@end
