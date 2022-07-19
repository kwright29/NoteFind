//
//  Note.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : PFObject <PFSubclassing>


@property (strong, nonatomic) NSString *userID;

@property (strong, nonatomic) PFFileObject *note;
@property (strong, nonatomic) PFUser *author;
@property (strong, nonatomic) NSString *noteDescription;

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSArray *textbooks;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSNumber *addCount;
@property (nonatomic) BOOL uploaded;

+ (void) postUserNote: (UIImage * _Nullable)image withDescription: (NSString * _Nullable)description withTitle: (NSString * _Nullable)title withTags: (NSMutableArray *)tags withBooks: (NSMutableArray *)textbooks withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
