//
//  TagsViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "TagsViewController.h"
#import "TagCell.h"

#import <Parse/Parse.h>
#import "NewNoteViewController.h"
#import "ErrorAlerts.h"



@interface TagsViewController () <UITableViewDataSource, UITableViewDelegate, TagDelegate>

@property (strong, nonatomic) NSMutableArray<Tags *> *allTags;
@property (strong, nonatomic) IBOutlet UITableView *tableView;




@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
            [ErrorAlerts showAlertWithTitle:@"couldn't load tags" withMessage:@"failure loading tags. please refresh and try again." withVC:self];
           
        }
        [self.tableView reloadData];
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    TagCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    Tags *tag = self.allTags[indexPath.row];
    cell.tags = tag;
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setTag];
    
    if ([self.noteTags containsObject:tag]) {
        [cell.checkbox setSelected:YES];
    } else {
        [cell.checkbox setSelected:NO];
    }
  
    
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


- (void)didTapTag:(nonnull NSIndexPath *)indexPath {
    Tags *tag = self.allTags[indexPath.row];
    
    if([self.noteTags containsObject:tag]) {
        [self.noteTags removeObject:tag];
    } else {
        [self.noteTags addObject:tag];
    }
    [self.transferDelegate addTags:self.noteTags];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
