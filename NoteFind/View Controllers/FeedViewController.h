//
//  FeedViewController.h
//  NoteFind
//
//  Created by Khloe Wright on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "NewNoteViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController

@property (nonatomic, strong) NSPersistentContainer *container;

@end

NS_ASSUME_NONNULL_END
