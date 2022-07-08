//
//  FeedViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import "FeedViewController.h"
#import "NewNoteViewController.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
 */

- (IBAction)didTapAdd:(id)sender {
}

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (void)didShareNote {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)newPost:(id)sender {
    [self performSegueWithIdentifier:@"newPost" sender:nil];
}

@end
