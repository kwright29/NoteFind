//
//  SearchViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "SearchViewController.h"
#import <Parse/Parse.h>
#import "Tags.h"


@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

<<<<<<< Updated upstream
=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered) {
        return self.displayTags.count;
    }
    
    return self.allTags.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isFiltered = NO;
    } else {
        self.isFiltered = YES;
        self.displayTags = [[NSMutableArray alloc]init];
        for (NSString *tag in self.allTags) {
            NSRange range = [tag rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.displayTags addObject:tag];
            }
        }
    }
    [self.tableView reloadData];
    
}
     
     
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}


>>>>>>> Stashed changes
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
