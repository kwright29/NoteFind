//
//  SearchViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "ErrorAlerts.h"
#import "SearchViewController.h"
#import "SearchDetailsTableViewController.h"
#import "Tags.h"

@interface SearchViewController ()
@property (nonatomic, strong) NSMutableArray<Tags *> *displayTags;

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
    Tags *tag = self.displayTags[indexPath.row];
    cell.textLabel.text = tag.title;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayTags.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //removing white space
    searchText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    PFQuery *tagQuery = [Tags query];
    [tagQuery whereKey:@"title" matchesRegex:searchText modifiers:@"i"];
    [tagQuery orderByAscending:@"title"];
    self.displayTags = [[NSMutableArray alloc] init];
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray<Tags *>*tags , NSError *error) {
        if (error) {
            [ErrorAlerts retrieveTagsFailure:self];
        }
        for (Tags *tag in tags) {
            [self.displayTags addObject:tag];
        }
        [self.tableView reloadData];
        
    }];
}



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Tags *tagToPass = self.displayTags[indexPath.row];
    SearchDetailsTableViewController *searchDetailsVC = [segue destinationViewController];
    searchDetailsVC.selectedTag = tagToPass;
    
}
 
 

@end
