//
//  TransferDelegate.h
//  NoteFind
//
//  Created by Khloe Wright on 7/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TransferDelegate <NSObject>

- (void) addTags:(NSMutableArray *)filteredTags;
- (void) addBooks:(NSMutableArray *)selectedBooks;

@end

NS_ASSUME_NONNULL_END
