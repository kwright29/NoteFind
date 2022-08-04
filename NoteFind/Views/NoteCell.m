//
//  NoteCell.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "AppDelegate.h"
#import "OfflineDataManager.h"
#import "NoteCell.h"

@implementation NoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNote:(Note *)note {
    _note = note;
    _postTitle.text = _note.title;
    _postCaption.text = _note.noteDescription;
    _postUsername.text = _note.author.username;
    _postNote.file = _note.note;
    [_postNote loadInBackground];
    
    // TODO: add addCount
}

- (IBAction)didTapDownload:(id)sender {
    
    OfflineDataManager *dataManager = [[OfflineDataManager alloc] init];
    [dataManager downloadNote:_note];
}

@end
