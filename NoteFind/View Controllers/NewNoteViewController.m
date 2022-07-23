//
//  NewNoteViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "NewNoteViewController.h"
#import "Tags.h"
#import "TagsViewController.h"
#import "Note.h"
#import "TagCell.h"
#import "TransferDelegate.h"
#import "TextbookViewController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "CameraImport.h"
#import "ErrorAlerts.h"
#import "ImportDelegate.h"

@interface NewNoteViewController ()  <TransferDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImportDelegate>
@property (strong, nonatomic) NSMutableArray<Tags *> *tags;
@property (strong, nonatomic) NSMutableArray<NSString *> *books;
@property (strong, nonatomic) NSURL *selectedFileURL;
@property (strong, nonatomic) IBOutlet UIButton *addNoteButton;
@property (strong, nonatomic) UIMenu *importMenu;
@property (strong, nonatomic) IBOutlet UIImageView *noteImageView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (nonatomic) CameraImport *cameraImporter;


@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNoteButton.showsMenuAsPrimaryAction = YES;
    self.cameraImporter = [[CameraImport alloc]init];
    self.cameraImporter.delegate = self;
    [self setImportMenu:self.importMenu];
    // Do any additional setup after loading the view.

}
- (void)setImportMenu:(UIMenu *)importMenu {
    //setting options for menu
    NSMutableArray *options = [[NSMutableArray alloc] init];
    [options addObject:[UIAction actionWithTitle:@"import from files" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[UTTypeText]];
        documentPicker.delegate = self;
        documentPicker.allowsMultipleSelection = NO;
        [self presentViewController:documentPicker animated:YES completion:nil];
        
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"take picture w/ camera" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showCamera:self];
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"import from gallery" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showGallery:self];
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
    }

- (void)addBooks:(nonnull NSMutableArray *)selectedBooks {
    self.books = selectedBooks;
}


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    self.selectedFileURL = urls.firstObject;
}

- (void)getImageFromCamera:(nonnull UIImage *)img {
    [self.noteImageView setImage:img];
}

- (IBAction)didTapPost:(id)sender {
    
    [Note postUserNote:_noteImageView.image withDescription:self.descriptionTextField.text withTitle:self.titleTextField.text withTags:self.tags withBooks:self.books withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [ErrorAlerts errorPostingNote:self];
        }
    }];

}




@end
