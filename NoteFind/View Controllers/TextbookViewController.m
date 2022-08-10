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

@interface TextbookViewController () <UITableViewDataSource, UITableViewDelegate, TextbookDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allBooks;
@property (strong, nonatomic) NSMutableArray *associatedTextbooks;

@end

@implementation TextbookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.allBooks = [NSMutableArray array];
    self.associatedTextbooks = [NSMutableArray array];
    [self loadBooks];

}

- (void)loadBooks {
    APIManager *manager = [APIManager new];
    [manager getTextbooks:^(NSArray * _Nonnull books, NSError * _Nonnull error) {
        if (books) {
            self.allBooks = (NSMutableArray *)books;
        }
        else {
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



@end
