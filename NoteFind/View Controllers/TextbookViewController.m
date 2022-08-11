//
//  TextbookViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import "TextbookViewController.h"
#import "APIManager.h"
#import "BookCell.h"
#import "ErrorAlerts.h"

@interface TextbookViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, TextbookDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allBooks;
@property (strong, nonatomic) NSMutableArray *associatedTextbooks;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (copy, nonatomic) NSString *textToSearch;
@property (assign, nonatomic) int setsLoaded;
@property (assign, nonatomic) int startIndex;

@end

@implementation TextbookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.setsLoaded = 0;
    self.startIndex = 0;
    self.allBooks = [NSMutableArray array];
    self.associatedTextbooks = [NSMutableArray array];

}

- (void)loadBooks {
    APIManager *manager = [APIManager new];
    [manager getTextbooksWithSearchText:self.textToSearch withStartIndex:self.startIndex withCompletion:^(NSArray * _Nonnull books, NSError * _Nonnull error) {
        if (books) {
            self.allBooks = (NSMutableArray *)books;
        } else {
            [ErrorAlerts showAlertWithTitle:@"couldn't load books" withMessage:@"failure loading books. please refresh and try again." withVC:self];
        }
        [self.tableView reloadData];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    
    Book *book = self.allBooks[indexPath.row];
    cell.delegate = self;
    [cell setBook:book];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allBooks.count;
}

- (void)addBook:(nonnull NSString *)bookID {
    [self.associatedTextbooks insertObject:bookID atIndex:0];
    [self.transferDelegate addBooks:self.associatedTextbooks];
}

- (void)removeBook:(nonnull NSString *)bookID {
    [self.associatedTextbooks removeObject:bookID];
    [self.transferDelegate addBooks:self.associatedTextbooks];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.textToSearch = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.setsLoaded = 0;
    [self loadBooks];
}

@end
