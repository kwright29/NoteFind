//
//  SearchDetailsTableViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/25/22.
//

#import "SearchDetailsTableViewController.h"
#import "Note.h"
#import <Parse/Parse.h>
#import "NoteCell.h"

@interface SearchDetailsTableViewController ()

@property (strong, nonatomic) NSArray *notesWithTag;
@property (strong, nonatomic) NSMutableArray<Note *> *taggedNoteObjects;

@end

@implementation SearchDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taggedNoteObjects = [[NSMutableArray alloc] init];
    self.notesWithTag = [[NSArray alloc] initWithArray:self.selectedTag.taggedNotes];
    [self getAllNotes];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notesWithTag.count;
}

- (void)getNoteFromID:(NSString *)noteID{
    PFQuery *query = [Note query];
    [query getObjectInBackgroundWithId:noteID block:^(PFObject *theNote, NSError *error) {
        if (theNote) {
            Note *note = (Note *)theNote;
            [self.taggedNoteObjects addObject:note];
            
        }
    }];
}

- (void)getAllNotes {
    for (NSString *noteID in self.notesWithTag) {
        [self getNoteFromID:noteID];
    }
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    
    cell.note = self.taggedNoteObjects[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
