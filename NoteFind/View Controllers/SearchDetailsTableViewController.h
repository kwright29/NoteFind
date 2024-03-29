//
//  SearchDetailsTableViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/25/22.
//

#import <UIKit/UIKit.h>
#import "Tags.h"


NS_ASSUME_NONNULL_BEGIN

@interface SearchDetailsTableViewController : UITableViewController

@property (strong, nonatomic) Tags *selectedTag;

@end

NS_ASSUME_NONNULL_END
