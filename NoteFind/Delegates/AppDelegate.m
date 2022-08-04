//
//  AppDelegate.m
//  NoteFind
//
//  Created by Khloe Wright on 7/5/22.
//

#import "AppDelegate.h"
#import "ErrorAlerts.h"
#import "FeedViewController.h"
#import "SceneDelegate.h"

#import <CoreData/CoreData.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

            configuration.applicationId = @"ii2Qd79QJOe6iU9GVHeoLRpY2UkoXFTj1A7oVqbe"; // <- UPDATE
            configuration.clientKey = @"P06wrDVCdTMDXbvsbORPsKq7nnAEjO4j9FFs30oj"; // <- UPDATE
            configuration.server = @"https://parseapi.back4app.com";
        }];

        [Parse initializeWithConfiguration:config];

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"OfflineData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    UIViewController *vc = [self getCurrentVC];
                    [ErrorAlerts showAlertWithTitle:@"problem loading local data" withMessage:@"there was a problem retrieving your datastore. please exit and try again." withVC:vc];
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    UIViewController *vc = [self getCurrentVC];
    
    if ([context hasChanges] && ![context save:&error]) {
        [ErrorAlerts showAlertWithTitle:@"error downloading note" withMessage:@"there was a problem trying download your note. please try again" withVC:vc];
    }
    else {
        [ErrorAlerts showAlertWithTitle:@"success!" withMessage:@"this note was successfully downloaded! check your profile for all of your downloaded notes." withVC:vc];
    
    }
}

- (UIViewController *)getCurrentVC {
    //getting current window to present alert
    NSSet<UIScene *> * sceneArr = [[UIApplication sharedApplication] connectedScenes];
    UIScene * scene = [[sceneArr allObjects] firstObject];
    NSObject * sceneDelegate = (NSObject *)scene.delegate;
    UIWindow *currentKeyWindow = [sceneDelegate valueForKey: @"window"];
    UIViewController *vc = currentKeyWindow.rootViewController;
    
    return vc;
}
@end
