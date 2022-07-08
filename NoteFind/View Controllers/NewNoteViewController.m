//
//  NewNoteViewController.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "NewNoteViewController.h"
#import "TagsViewController.h"
#import "Note.h"
#import "TagCell.h"

@interface NewNoteViewController ()  <TagDelegate>
@property (strong, nonatomic) NSMutableArray *tags;

@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    [self performSegueWithIdentifier:@"tagSegue" sender:nil];
    TagCell *cell = [[TagCell alloc] init];
    cell.delegate = self;
    
    
}





- (void)addTags:(nonnull Tags *)tag {
    [self.tags insertObject:tag.title atIndex:0];
    NSLog(@"%@ variable added", self.tags);
}

- (void)removeTags:(Tags *)tag {
    [self.tags removeObject:tag.title];
    NSLog(@"%@ variable removed", self.tags);

}

@end
