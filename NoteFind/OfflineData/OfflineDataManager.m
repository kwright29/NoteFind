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
@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation OfflineDataManager

- (instancetype)init {
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.context = self.appDelegate.persistentContainer.viewContext;
    
    return self;
}

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
    NSData *fileData = [note.note getData];
    UIViewController *currentVC = [self.appDelegate getCurrentVC];
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
        [self.appDelegate saveContext];
        
    }
}

- (NSArray *)getOfflineNotes {
    NSFetchRequest *offlineRequest = [NSFetchRequest fetchRequestWithEntityName:@"OfflineNote"];
    NSArray *results = [self.context executeFetchRequest:offlineRequest error:nil];
    
    return results;
    
}

+ (UIImage *)getImageFromData:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
