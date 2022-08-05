//
//  NewNoteViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PostDelegate
- (void)didSharePost;
@end

@interface NewNoteViewController : UIViewController
@property (nonatomic, weak) id <PostDelegate> postDelegate;
@end

NS_ASSUME_NONNULL_END
