//
//  NewNoteViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NoteDelegate

- (void)didShareNote;

@end

@interface NewNoteViewController : UIViewController


@end

NS_ASSUME_NONNULL_END
