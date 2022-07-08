//
//  TagsViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "TagsViewController.h"
#import "TagCell.h"



@interface TagsViewController () <UITableViewDataSource>

@property NSMutableArray *allTags;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.allTags = [[NSMutableArray alloc] initWithObjects:@"calculus", @"discrete math", @"english", @"psychology", @"biology", @"chemistry", @"physics", @"computer science", @"writing", @"history", nil];
   
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {


    TagCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    NSString *tagTitle = self.allTags[indexPath.row];
    
    [cell.tagButton setTitle:tagTitle forState:UIControlStateNormal];
    
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

@end
