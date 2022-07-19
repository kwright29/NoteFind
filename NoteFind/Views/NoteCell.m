//
//  NoteCell.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "NoteCell.h"

@implementation NoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNote:(Note *)note {
    _note = note;
    self.postTitle.text = self.note.title;
    self.postCaption.text = self.note.noteDescription;
    self.postUsername.text = self.note.author.username;
    self.postNote.file = self.note.note;
    [self.postNote loadInBackground];
    
    
}
- (IBAction)didTapAdd:(id)sender {
   
}

@end
