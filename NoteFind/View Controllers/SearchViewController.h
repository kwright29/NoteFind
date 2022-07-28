//
//  SearchViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>




NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END
