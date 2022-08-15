//
//  OfflineGridCell.m
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//
#import "AppDelegate.h"
#import "ErrorAlerts.h"
#import "OfflineGridCell.h"

@implementation OfflineGridCell
-(void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTappedCell:)];
    tapRecognizer.delegate = self;
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapRecognizer];
}


- (void)doubleTappedCell:(UITapGestureRecognizer *)tapRecognizer {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = [appDelegate getCurrentVC];
    [ErrorAlerts confirmingDeletion:vc withOfflineNote:_currentOfflineNote];
}
@end
