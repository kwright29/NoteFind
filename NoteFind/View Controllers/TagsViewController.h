//
//  TagsViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TagsViewControllerDelegate

- (void)addTagsToPost:(NSString *)tag;

@end


@interface TagsViewController : UIViewController

@property (nonatomic, weak) id <TagsViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
