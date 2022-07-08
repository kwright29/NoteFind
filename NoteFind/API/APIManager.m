//
//  APIManager.m
//  NoteFind
//
//  Created by Khloe Wright on 7/7/22.
//

#import "APIManager.h"


static NSString * const baseURLString = @"https://api.notion.com";

@implementation APIManager

- (instancetype)init {
    NSString *path = [ [NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //NSString *identification = [dict objectForKey:@"client_ID"];
    NSString *secret = [dict objectForKey:@"client_Secret"];
    
    self.client = [NotionClient clientWithToken:[NSString stringWithFormat:@"%@", secret]];
    
    return self;
}
@end
