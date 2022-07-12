//
//  TagsViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Tags.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TransferDelegate

- (void) addTags:(NSMutableArray *)filteredTags;

@end

@interface TagsViewController : UIViewController

@property (nonatomic, weak) id <TransferDelegate> transferDelegate;

@end

NS_ASSUME_NONNULL_END
