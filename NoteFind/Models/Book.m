//
//  Book.m
//  NoteFind
//
//  Created by Khloe Wright on 7/11/22.
//

#import "Book.h"

@implementation Book

- (id)initWithDictionary:(NSDictionary *)dictionary {
    //getting unique ID
    self.identifier = dictionary[@"id"];
    NSDictionary *volumeInfo = dictionary[@"volumeInfo"];
    
    self.title = volumeInfo[@"title"];
    NSString *urlString = volumeInfo[@"imageLinks"][@"smallThumbnail"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    self.bookCoverURL = url;
    self.synposis = volumeInfo[@"description"];
    self.authors = volumeInfo[@"authors"];
    
    return self;
}

+ (NSMutableArray *)booksWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *books = [NSMutableArray array];
    
    for (NSDictionary *dictionary in dictionaries) {
        Book *book = [[Book alloc] initWithDictionary:dictionary];
        [books addObject:book];
    }
    
    return books;
}

@end
