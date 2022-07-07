//
//  APIManager.m
//  NoteFind
//
//  Created by Khloe Wright on 7/7/22.
//

#import "APIManager.h"
#import <NotionClient/Notion.h>

static NSString * const baseURLString = @"https://api.notion.com";

@implementation APIManager

- (instancetype)init {
    NotionClient *client = [NotionClient clientWithToken:@"secret_76uPdqP1AlAANu2yiL7yOCrhcScufx6hlF91fztMRUs"];
    
    return self;
}
@end
