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

- (IBAction)didTapTag:(id)sender {
    
    if (!self.checked) {
        self.checked = YES;
        [self.tagButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        
    } else {
        self.checked = NO;
        [self.tagButton setImage:nil forState:UIControlStateNormal];
    }
    
}





@end
