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
#import <MobileCoreServices/MobileCoreServices.h>


@interface NewNoteViewController ()  <TransferDelegate, UIDocumentPickerDelegate>
@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) NSURL *selectedFileURL;
@property (strong, nonatomic) IBOutlet UIButton *addNoteButton;
@property (strong, nonatomic) UIMenu *importMenu;

@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNoteButton.showsMenuAsPrimaryAction = YES;
    [self setImportMenu:self.importMenu];
    // Do any additional setup after loading the view.

}
- (void)setImportMenu:(UIMenu *)importMenu {
    //setting options for menu
    NSMutableArray *options = [[NSMutableArray alloc] init];
    [options addObject:[UIAction actionWithTitle:@"import from files" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        UTType *const UTTypePDF;
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[UTTypePDF]];
        documentPicker.delegate = self;
        documentPicker.allowsMultipleSelection = NO;
        [self presentViewController:documentPicker animated:YES completion:nil];
        
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"take picture w/ camera" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        NSLog(@"button was tapped successfully!");
    }]];
    [options addObject:[UIAction actionWithTitle:@"import from gallery" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
    
    }]];
    [options addObject:[UIAction actionWithTitle:@"import from notion" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
    
    }]];
    
    importMenu = [UIMenu menuWithChildren:options];
    
    //setting menu to button
    self.addNoteButton.menu = importMenu;
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

- (IBAction)importNote:(id)sender {

    
    
    
  
}


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    self.selectedFileURL = urls.firstObject;
    NSLog(@"%@", self.selectedFileURL);
    
}

@end
