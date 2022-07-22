//
//  TagsViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "TagsViewController.h"
#import "TagCell.h"
#import "Tags.h"
#import <Parse/Parse.h>
#import "NewNoteViewController.h"
#import "ErrorAlerts.h"



@interface TagsViewController () <UITableViewDataSource, UITableViewDelegate, TagDelegate>

@property (strong, nonatomic) NSMutableArray *allTags;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *noteTags;



@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.noteTags = [[NSMutableArray alloc] init];
    [self getTags];
//    [self.tableView reloadData];
   
    
}


- (void) getTags {
    PFQuery *tagQuery = [Tags query];
    [tagQuery orderByAscending:@"title"];
    [tagQuery includeKey:@"title"];
    tagQuery.limit = 20;
    
    [tagQuery findObjectsInBackgroundWithBlock:^(NSArray<Tags *> * _Nullable tags, NSError * _Nullable error) {
        if (tags) {
            self.allTags = (NSMutableArray *)tags;
        }
        else {
            [ErrorAlerts retrieveTagsFailure:self];
            NSLog(@"Problem retrieving tags: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    TagCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    Tags *tag = self.allTags[indexPath.row];
    cell.tags = tag;
    cell.delegate = self;
    [cell setTag];
  
    
    return cell;

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTags.count;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addTags:(Tags *)tag {
    [self.noteTags insertObject:tag atIndex:0];
    
}

- (void)removeTags:(Tags *)tag {
    [self.noteTags removeObject:tag];

}
- (IBAction)didTapDone:(id)sender {
    [self.transferDelegate addTags:self.noteTags];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
