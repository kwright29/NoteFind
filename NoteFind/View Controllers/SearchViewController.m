//
//  SearchViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "ErrorAlerts.h"
#import "InfiniteScrollActivityView.h"
#import "SearchViewController.h"
#import "SearchDetailsTableViewController.h"
#import "Tags.h"

@interface SearchViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Tags *> *displayTags;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (assign, nonatomic) int setsLoaded;
@property (nonatomic, copy) NSString *textToSearch;
@end

@implementation SearchViewController

bool isMoreDataLoading = false;
InfiniteScrollActivityView *loadingMoreView;
static int kTagsSearchDisplayLimit = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.setsLoaded = 0;
    
    //dismissing keyboard
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [tapRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapRecognizer];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    loadingMoreView.hidden = true;
    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.tableView.contentInset = insets;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.displayTags.count > indexPath.row){
        Tags *tag = self.displayTags[indexPath.row];
        cell.textLabel.text = tag.title;
    }
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayTags.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //removing white space
    self.textToSearch = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.setsLoaded = 0;
    [self loadTags:self.textToSearch];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!isMoreDataLoading) {
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;

        if (scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            isMoreDataLoading = true;
            self.setsLoaded += 1;
            // Update position of loadingMoreView, and start loading indicator
            CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
            loadingMoreView.frame = frame;
            [loadingMoreView startAnimating];
            
            [self loadTags:self.textToSearch];
        }
    }
}

- (void)loadTags:(NSString *)searchText {
    PFQuery *tagQuery = [Tags query];
    tagQuery.limit = kTagsSearchDisplayLimit;
    tagQuery.skip = self.setsLoaded * kTagsSearchDisplayLimit;
    [tagQuery whereKey:@"title" matchesRegex:searchText modifiers:@"i"];
    [tagQuery orderByAscending:@"title"];
    if (self.setsLoaded == 0) {
        self.displayTags = [[NSMutableArray alloc] init];
    }
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray<Tags *>*tags , NSError *error) {
        if (error) {
            [ErrorAlerts showAlertWithTitle:@"couldn't load tags" withMessage:@"failure loading tags. please refresh and try again." withVC:self];
        } else {
            isMoreDataLoading = false;

            [loadingMoreView stopAnimating];
            
            for (Tags *tag in tags) {
                [self.displayTags addObject:tag];
            }
            
            [self.tableView reloadData];
        }
        
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
