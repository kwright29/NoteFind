//
//  NewNoteViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Tags.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TagDelegate

- (void)addTags:(Tags *)tag;

@end

@interface NewNoteViewController : UIViewController


@end

NS_ASSUME_NONNULL_END
