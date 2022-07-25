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
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<NSString *> *taggedNotes;


@end

NS_ASSUME_NONNULL_END
