//
//  AppDelegate.h
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

