//
//  AppDelegate.h
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import <UIKit/UIKit.h>

@class NSPersistentContainer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext; // saves entities to core data model
- (UIViewController *)getCurrentVC; // gets current VC for case of showing alerts while not in VC file
@end

