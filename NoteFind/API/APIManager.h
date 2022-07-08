//
//  APIManager.h
//  NoteFind
//
//  Created by Khloe Wright on 7/7/22.
//

#import <Foundation/Foundation.h>
#import <NotionClient/Notion.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

@property (strong, nonatomic) NotionClient *client;

@end

NS_ASSUME_NONNULL_END
