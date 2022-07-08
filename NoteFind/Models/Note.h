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

@property (strong, nonatomic) NSString *noteID;
@property (strong, nonatomic) NSString *userID;

@property (strong, nonatomic) PFFileObject *note;
@property (strong, nonatomic) PFUser *author;
@property (strong, nonatomic) NSString *caption;

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *textbook;

@property (strong, nonatomic) NSNumber *addCount;
@property (nonatomic) BOOL uploaded;

@end

NS_ASSUME_NONNULL_END
