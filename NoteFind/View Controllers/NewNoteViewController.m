//
//  NewNoteViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "NewNoteViewController.h"

@interface NewNoteViewController ()  <TransferDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImportDelegate>
@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) NSURL *selectedFileURL;
@property (strong, nonatomic) IBOutlet UIButton *addNoteButton;
@property (strong, nonatomic) UIMenu *importMenu;
@property (strong, nonatomic) IBOutlet UIImageView *noteImageView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;

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
        
        NSArray<UTType *> *types = @[UTTypeText];
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:types];
        documentPicker.delegate = self;
        documentPicker.allowsMultipleSelection = NO;
        [self presentViewController:documentPicker animated:YES completion:nil];
        
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"take picture w/ camera" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        NSLog(@"button was tapped successfully!");
        CameraImport *cameraImport = [[CameraImport alloc]init];
        [cameraImport showCamera:self];
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"import from gallery" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self showGallery];
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



- (void)showGallery {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}



- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    self.selectedFileURL = urls.firstObject;
    NSLog(@"%@", self.selectedFileURL);
    
}

- (void)getImageFromCamera:(nonnull UIImage *)img {
    self.noteImageView.image = img;
}

- (IBAction)didTapPost:(id)sender {
    
    [Note postUserNote:_noteImageView.image withDescription:self.descriptionTextField.text withTitle:self.titleTextField.text withTags:self.tags withBooks:self.books withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"note successfully posted!");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
       
    
    }];

}




@end
