//
//  Book.h
//  NoteFind
//
//  Created by Khloe Wright on 7/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *bookCoverURL;
@property (strong, nonatomic) NSString *synposis;
@property (strong, nonatomic) NSArray *authors;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)booksWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END

