//
//  TagsViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "TransferDelegate.h"
#import "Tags.h"

NS_ASSUME_NONNULL_BEGIN



@interface TagsViewController : UIViewController

@property (nonatomic, weak) id <TransferDelegate> transferDelegate;
@property (strong, nonatomic) NSMutableArray<Tags *> *noteTags;

@end

NS_ASSUME_NONNULL_END
