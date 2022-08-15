//
//  SearchDetailsTableViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/25/22.
//
#import "OfflineDataManager.h"
#import "SearchDetailsTableViewController.h"
#import "Note.h"
#import <Parse/Parse.h>
#import "NoteCell.h"

@interface SearchDetailsTableViewController ()

@property (strong, nonatomic) NSArray *notesWithTag;
@property (strong, nonatomic) NSMutableArray<Note *> *taggedNoteObjects;
@property (nonatomic) NSUInteger noteCounter;

@end

@implementation SearchDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taggedNoteObjects = [[NSMutableArray alloc] init];
    self.notesWithTag = [[NSArray alloc] initWithArray:self.selectedTag.taggedNotes];
    self.noteCounter = 0;
    [self getAllNotes];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taggedNoteObjects.count;
}

- (void)getNoteFromID:(NSString *)noteID{
    PFQuery *query = [Note query];
    [query includeKey:@"author"];
    [query getObjectInBackgroundWithId:noteID block:^(PFObject *theNote, NSError *error) {
        if (theNote) {
            Note *note = (Note *)theNote;
            [self.taggedNoteObjects addObject:note];
            self.noteCounter += 1;
            
            if (self.noteCounter == self.notesWithTag.count) {
                [self.tableView reloadData];
            }
     
            
        }
    }];
}

- (void)getAllNotes {
    for (NSString *noteID in self.notesWithTag) {
        [self getNoteFromID:noteID];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    
    cell.note = self.taggedNoteObjects[indexPath.row];
    
    [cell setNote:cell.note];
    
    return cell;
}



@end
