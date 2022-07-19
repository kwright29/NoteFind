//
//  Tags.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "Tags.h"

@implementation Tags
@dynamic title;
@dynamic taggedNotes;

+ (nonnull NSString *)parseClassName {
    return @"Tags";
}


+ (void)addNoteToTags:(Note *)note {
    NSArray *noteTags = note.tags;
    
    for (Tags *tag in noteTags) {
        [tag.taggedNotes addObject:note.objectId];
    }
}

@end
