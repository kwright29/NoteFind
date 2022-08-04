//
//  OfflineDataManager.m
//  NoteFind
//
//  Created by Khloe Wright on 8/3/22.
//
#import "AppDelegate.h"
#import "ErrorAlerts.h"
#import "OfflineDataManager.h"

#import <CoreData/CoreData.h>
#import <Parse/Parse.h>

@interface OfflineDataManager()

@property (nonatomic, weak) NSManagedObjectContext *context;

@end

@implementation OfflineDataManager

- (BOOL)isNoteDownloaded:(Note *)note {
    NSString *currentNoteID = note.objectId;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OfflineNote"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"noteID = %@", currentNoteID];
    [request setPredicate:predicate];
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    
    if (results.count > 0) {
        return YES;
    }
    
    return NO;
}

- (void)downloadNote:(Note *)note {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.context = appDelegate.persistentContainer.viewContext;
    NSData *fileData = [note.note getData];
    UIViewController *currentVC = [appDelegate getCurrentVC];
    if (fileData == nil) {
        [ErrorAlerts showAlertWithTitle:@"error downloading note" withMessage:@"there was a problem trying download your note. please try again" withVC:currentVC];
    } else if ([self isNoteDownloaded:note]) {
        [ErrorAlerts showAlertWithTitle:@"duplicate!" withMessage:@"this note is already downloaded locally!" withVC:currentVC];
    }
    else {
        NSManagedObject *newOfflineNote = [NSEntityDescription insertNewObjectForEntityForName:@"OfflineNote" inManagedObjectContext:self.context];
        [newOfflineNote setValue:note.author.username forKey:@"username"];
        [newOfflineNote setValue:note.title forKey:@"title"];
        [newOfflineNote setValue:note.noteDescription forKey:@"caption"];
        [newOfflineNote setValue:fileData forKey:@"noteFileData"];
        [newOfflineNote setValue:note.note.name forKey:@"noteFileName"];
        [newOfflineNote setValue:note.objectId forKey:@"noteID"];
        [appDelegate saveContext];
        
    }
}

@end
