//
//  APIManager.h
//  NoteFind
//
//  Created by Khloe Wright on 7/7/22.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

- (void)getTextbooksWithSearchText:(NSString *)searchText withStartIndex:(NSInteger)startIndex withCompletion: (void(^)(NSArray *books, NSError *error))completion;
- (id)init;

@end

NS_ASSUME_NONNULL_END
