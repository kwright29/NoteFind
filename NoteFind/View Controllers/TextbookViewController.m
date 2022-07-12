//
//  TextbookViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import "TextbookViewController.h"
#import "APIManager.h"
#import "BookCell.h"

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
   
    // Do any additional setup after loading the view.
}

- (void)loadBooks {
    APIManager *manager = [APIManager new];
    [manager getTextbooks:^(NSArray * _Nonnull books, NSError * _Nonnull error) {
        if (books) {
            NSLog(@"Successfully loaded books");
            self.allBooks = (NSMutableArray *)books;
            
        }
        else {
            NSLog(@"Failure getting books");
        }
        [self.tableView reloadData];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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



- (void)addBook:(nonnull NSString *)bookTitle {
    [self.associatedTextbooks insertObject:bookTitle atIndex:0];
    NSLog(@"textbook added!");
}

- (void)removeBook:(nonnull NSString *)bookTitle {
    [self.associatedTextbooks removeObject:bookTitle];
    NSLog(@"textbook removed");
}



@end
