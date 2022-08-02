//
//  NoteCell.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "NoteCell.h"


@interface NoteCell () {
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@end

@implementation NoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNote:(Note *)note {
    _note = note;
    _postTitle.text = _note.title;
    _postCaption.text = _note.noteDescription;
    _postUsername.text = _note.author.username;
    _postNote.file = _note.note;
    [_postNote loadInBackground];
    
    // TODO: add addCount
}
- (IBAction)didTapDownload:(id)sender {
    NSManagedObject *newOfflineNote = [NSEntityDescription insertNewObjectForEntityForName:@"OfflineNote" inManagedObjectContext:context];
    NSData *fileData = [_postNote.file getData];
    if (fileData == nil) {
        [self.delegate showErrorMessage];
    } else {
        [newOfflineNote setValue:_postUsername.text forKey:@"username"];
        [newOfflineNote setValue:_postTitle.text forKey:@"title"];
        [newOfflineNote setValue:_postCaption.text forKey:@"caption"];
        [newOfflineNote setValue:fileData forKey:@"noteFileData"];
        [newOfflineNote setValue:_postNote.file.name forKey:@"noteFileName"];
        [appDelegate saveContext];
        
    }
 
    
 
    // TODO: add addCount
    
    // TODO: fetch data
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OfflineNote"];
    NSArray *results = [context executeFetchRequest:request error:nil];
    NSLog(@"results: %@", results);
}

@end
