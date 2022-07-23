//
//  ErrorAlerts.h
//  NoteFind
//
//  Created by Khloe Wright on 7/22/22.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "RegisterViewController.h"
#import "NewNoteViewController.h"
#import <UIKit/UIKit.h>

@class LoginViewController;
@class FeedViewController;
@class RegisterViewController;
@class NewNoteViewController;

NS_ASSUME_NONNULL_BEGIN

@interface ErrorAlerts : NSObject
+ (void)loginFailure:(LoginViewController *)loginVC;
+ (void)alertVoidRequiredFields:(LoginViewController *)loginVC;
+ (void)logoutFailure:(FeedViewController *)feedVC;
+ (void)passwordNotConfirmed:(RegisterViewController *)regVC;
+ (void)retrieveNotesFailure:(FeedViewController *)feedVC;
+ (void)retrieveTagsFailure:(UIViewController *)vc;
+ (void)retrieveBooksFailure:(UIViewController *)vc;
+ (void)errorPostingNote:(NewNoteViewController *)newNoteVC;
@end

NS_ASSUME_NONNULL_END
