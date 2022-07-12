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

//static NSString * const baseURLString = @"https://api.notion.com";

@implementation APIManager

//- (instancetype)init {
//    NSString *path = [ [NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//
//    //NSString *identification = [dict objectForKey:@"client_ID"];
//    NSString *secret = [dict objectForKey:@"client_Secret"];
//
//    self.client = [NotionClient clientWithToken:[NSString stringWithFormat:@"%@", secret]];
//
//    return self;
//}




- (id)init {
    self = [super init];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    return self;
}



- (void)getTextbooks:(void(^)(NSArray *books, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/books/v1/volumes?q=textbook&key=AIzaSyCIdqm294VSsSXMxeP-xAudVh2oOGn2zV0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);

            // The network request has completed, but failed.
            // Invoke the completion block with an error.
            // Think of invoking a block like calling a function with parameters
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"items"];
            NSMutableArray *books = [Book booksWithDictionaries:dictionaries];

            // The network request has completed, and succeeded.
            // Invoke the completion block with the movies array.
            // Think of invoking a block like calling a function with parameters
            completion(books, nil);
        }
    }];
    [task resume];
}

@end
