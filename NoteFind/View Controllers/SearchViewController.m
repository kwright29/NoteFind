//
//  SearchViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "SearchViewController.h"
#import "SearchDetailsTableViewController.h"

@interface SearchViewController ()

@property (nonatomic, strong) NSArray *allTagTitles;
@property (nonatomic, strong) NSMutableArray *displayTagTitles;
@property (nonatomic, strong) NSMutableArray<Tags *> *allTags;
@property (nonatomic) BOOL isFiltered;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.isFiltered = NO;
    self.allTagTitles = [[NSMutableArray alloc] init];

    self.allTags = [[NSMutableArray alloc] init];
    [self getTags];
    
    
    
}

- (void) getTags {
    PFQuery *tagQuery = [Tags query];
    [tagQuery orderByAscending:@"title"];
    [tagQuery includeKey:@"title"];
    NSMutableArray *tagTitles = [[NSMutableArray alloc]init];
    
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray<Tags *> *tags, NSError *error) {
        if (tags) {
            // adding title to allTags for table view
            for (Tags *tag in tags) {
                NSString *title = tag.title;
                [tagTitles addObject:title];

                [self.allTags addObject:tag];
            }
            self.allTagTitles = (NSArray *)tagTitles;

           
        } else {
            // TODO: handle error
        }
        [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
    if (self.isFiltered) {

        cell.textLabel.text = self.displayTagTitles[indexPath.row];
    }
    
    else {
        cell.textLabel.text = self.allTagTitles[indexPath.row];


    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered) {

        return self.displayTagTitles.count;
    }
    
    return self.allTagTitles.count;

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isFiltered = NO;
    } else {
        self.isFiltered = YES;

        self.displayTagTitles = [[NSMutableArray alloc]init];
        for (NSString *tag in self.allTagTitles) {
            NSRange range = [tag rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.displayTagTitles addObject:tag];

            }
        }
    }
    [self.tableView reloadData];
    
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
