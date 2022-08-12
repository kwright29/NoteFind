//
//  APIManager.m
//  NoteFind
//
//  Created by Khloe Wright on 7/7/22.
//

#import "APIManager.h"
#import "Book.h"

@interface APIManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation APIManager

- (id)init {
    self = [super init];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    return self;
}

- (void)getTextbooksWithSearchText:(NSString *)searchText withStartIndex:(NSInteger)startIndex withCompletion: (void(^)(NSArray *books, NSError *error))completion{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%ld", @"https://www.googleapis.com/books/v1/volumes?q=textbook+intitle:" , searchText, @"&key=AIzaSyCIdqm294VSsSXMxeP-xAudVh2oOGn2zV0&maxResults=40&startIndex=", (long)startIndex]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"items"];
            NSMutableArray *books = [Book booksWithDictionaries:dictionaries];
            completion(books, nil);
        }
    }];
    [task resume];
}

@end
