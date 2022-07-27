//
//  SearchViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "SearchViewController.h"
#import "SearchDetailsTableViewController.h"
#import "ErrorAlerts.h"

@interface SearchViewController ()

@property (nonatomic, strong) NSMutableArray *displayTagTitles;
@property (nonatomic, strong) NSMutableArray<Tags *> *allTags;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
    cell.textLabel.text = self.displayTagTitles[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.displayTagTitles.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //removing white space
    searchText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    PFQuery *tagQuery = [Tags query];
    [tagQuery whereKey:@"title" matchesRegex:searchText modifiers:@"i"];
    [tagQuery orderByAscending:@"title"];
    self.displayTagTitles = [[NSMutableArray alloc] init];
    self.allTags = [[NSMutableArray alloc] init];
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray<Tags *>*tags , NSError *error) {
        if (tags) {
            for (Tags *tag in tags) {
                if (![self.displayTagTitles containsObject:tag.title]) {
                    [self.displayTagTitles addObject:tag.title];
                    [self.allTags addObject:tag];
                }
            }
            [self.tableView reloadData];
        }
        else {
            [ErrorAlerts retrieveTagsFailure:self];
        }
    }];
}



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Tags *tagToPass = self.allTags[indexPath.row];
    SearchDetailsTableViewController *searchDetailsVC = [segue destinationViewController];
    searchDetailsVC.selectedTag = tagToPass;
    
}
 
 

@end
