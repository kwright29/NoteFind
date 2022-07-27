//
//  CameraImport.h
//  NoteFind
//
//  Created by Khloe Wright on 7/15/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImportDelegate.h"
#import "NewNoteViewController.h"

@class NewNoteViewController;

NS_ASSUME_NONNULL_BEGIN


@interface CameraImport : NSObject


@property (nonatomic, weak) id <ImportDelegate> delegate;

- (void)showCamera:(NewNoteViewController *)vc;

- (void)showGallery:(NewNoteViewController *)vc;


@end

NS_ASSUME_NONNULL_END
