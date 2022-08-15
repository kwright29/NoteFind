//
//  ErrorAlerts.h
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Note;
@class OfflineNote;

NS_ASSUME_NONNULL_BEGIN

@interface ErrorAlerts : NSObject
+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withVC:(UIViewController *)vc;
+ (void)confirmingDownload:(UIViewController *)vc withNote:(Note *)note;
+ (void)confirmingDeletion:(UIViewController *)vc withOfflineNote:(OfflineNote *)offlineNote;
@end

NS_ASSUME_NONNULL_END
