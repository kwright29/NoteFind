//
//  NewNoteViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "NewNoteViewController.h"
#import "TagsViewController.h"
#import "Note.h"
#import "TagCell.h"
#import "TransferDelegate.h"
#import "TextbookViewController.h"

@interface NewNoteViewController ()  <TransferDelegate>
@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *books;

@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Check the segue
    if ([[segue identifier] isEqualToString:@"tagSegue"]) {
        UINavigationController *navController = [segue destinationViewController];
        TagsViewController *tagsVC = (TagsViewController *)navController.topViewController;
        tagsVC.transferDelegate = self;
    }
    if ([[segue identifier] isEqualToString:@"textbookSegue"]) {
        TextbookViewController *txtbkVC = [segue destinationViewController];
        txtbkVC.transferDelegate = self;
        
    }

    
}

- (void)addTags:(nonnull NSMutableArray *)filteredTags {
    self.tags = filteredTags;
    NSLog(@"tags added: %@", self.tags);
}

- (void)addBooks:(nonnull NSMutableArray *)selectedBooks {
    self.books = selectedBooks;
    NSLog(@"books added: %@", self.tags);
}


@end
