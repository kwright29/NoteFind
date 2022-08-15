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
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (nonatomic, strong) CameraImport *cameraImporter;
@property (strong, nonatomic) Note *latestNote;



@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addNoteButton.showsMenuAsPrimaryAction = YES;
    self.cameraImporter = [[CameraImport alloc]init];
    self.tags = [[NSMutableArray alloc]init];
    self.cameraImporter.delegate = self;
    [self setImportMenu:self.importMenu];
    [[self.descriptionTextField layer] setBorderColor:[[UIColor systemIndigoColor] CGColor]];
    [[self.descriptionTextField layer] setBorderWidth:3.0];
    
    //dismissing keyboard
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [tapRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapRecognizer];
    self.descriptionTextField.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
- (void)setImportMenu:(UIMenu *)importMenu {
    //setting options for menu
    NSMutableArray *options = [[NSMutableArray alloc] init];
    
    [options addObject:[UIAction actionWithTitle:@"take picture w/ camera" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showCamera:self];
    }]];
    
    [options addObject:[UIAction actionWithTitle:@"import from gallery" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.cameraImporter showGallery:self];
    }]];
    
    importMenu = [UIMenu menuWithChildren:options];
    
    //setting menu to button
    self.addNoteButton.menu = importMenu;
}

- (void)addTags:(nonnull NSMutableArray *)filteredTags {
    self.tags = filteredTags;
    }

- (void)addBooks:(nonnull NSMutableArray *)selectedBooks {
    self.books = selectedBooks;
}

- (void)getImageFromCamera:(nonnull UIImage *)img {
    [self.noteImageView setImage:img];
}

- (IBAction)didTapPost:(id)sender {
    
    [Note postUserNote:_noteImageView.image withDescription:self.descriptionTextField.text withTitle:self.titleTextField.text withTags:self.tags withBooks:self.books withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [Note addNewNoteToTags];
            [self.postDelegate didSharePost];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            [ErrorAlerts showAlertWithTitle:@"error posting note" withMessage:@"there was a problem trying to post your note to the feed. please try again." withVC:self];
        }
    }];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"tagSegue"]) {
        TagsViewController *tagsVC = [segue destinationViewController];
        tagsVC.transferDelegate = self;
        tagsVC.noteTags = self.tags;
        
    }
    if ([[segue identifier] isEqualToString:@"textbookSegue"]) {
        TextbookViewController *txtbkVC = [segue destinationViewController];
        txtbkVC.transferDelegate = self;
        
    }

}



@end
