//
//  Book.h
//  NoteFind
//
//  Created by Khloe Wright on 7/11/22.
//


#import <Foundation/Foundation.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *bookCoverURL;
@property (copy, nonatomic) NSString *synposis;
@property (strong, nonatomic) NSArray *authors;
@property (copy, nonatomic) NSString *identifier;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)booksWithDictionaries:(NSArray *)dictionaries;


@end

NS_ASSUME_NONNULL_END

