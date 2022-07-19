//
//  Tags.h
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import <Parse/Parse.h>
#import "PFObject.h"
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tags : PFObject <PFSubclassing>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *taggedNotes;
@end

NS_ASSUME_NONNULL_END
