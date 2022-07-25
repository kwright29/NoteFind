//
//  TagCell.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "TagCell.h"
#import "TagsViewController.h"

@interface TagCell ()

@property (nonatomic) BOOL checked;

@end

@implementation TagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTag {
    self.tagTitle.text = self.tags.title;
}

- (IBAction)didTapTag:(id)sender {
    [self.delegate didTapTag:self.indexPath];
}





@end
