//
//  ErrorAlerts.h
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LoginViewController;
@class FeedViewController;
@class RegisterViewController;
@class NewNoteViewController;

NS_ASSUME_NONNULL_BEGIN

@interface ErrorAlerts : NSObject
+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
