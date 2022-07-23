//
//  ImportDelegate.h
//  NoteFind
//
//  Created by Khloe Wright on 7/15/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImportDelegate <NSObject>

- (void)getImageFromCamera:(UIImage *)img;

@end


NS_ASSUME_NONNULL_END
