//
//  Note.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "Note.h"

@implementation Note

@dynamic userID;
@dynamic note;
@dynamic author;
@dynamic tags;
@dynamic textbooks;
@dynamic addCount;
@dynamic noteDescription;
@dynamic uploaded;
@dynamic title;


+ (nonnull NSString *)parseClassName {
    return @"Note";
}

+ (void) postUserNote: (UIImage * _Nullable)image withDescription: (NSString * _Nullable)description withTitle: (NSString * _Nullable)title withTags: (NSMutableArray *)tags withBooks: (NSMutableArray *)textbooks withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Note *newNote = [Note new];
    
    //backend data
    newNote.userID = newNote.author.objectId;
    newNote.tags = tags;
    newNote.textbooks = textbooks;
    
    newNote.note = [self getPFFileFromImage:image];
    newNote.author = [PFUser currentUser];
    newNote.noteDescription = description;
    newNote.addCount = @(0);
    newNote.title = title;
    
    [newNote saveInBackgroundWithBlock:completion];
   
    
    
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    //check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    
    if (!imageData) {
        return nil;
    } else {
        CGSize size = CGSizeMake(300.0, 300.0);
        image = [self resizeImage:image withSize:size];
    }
    imageData = UIImagePNGRepresentation(image);
    return [PFFileObject fileObjectWithName:@"image" data:imageData];
    
}

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (void)addNewNoteToTags {
    PFQuery *noteQuery = [Note query];
    [noteQuery orderByDescending:@"createdAt"];
    noteQuery.limit = 1;
    __block Note *latestNote = nil;
    
    [noteQuery findObjectsInBackgroundWithBlock:^(NSArray<Note *> *notes, NSError *error) {
        if (notes) {
            latestNote = notes[0];
            NSArray *noteTags = latestNote.tags;
            
            for (Tags *tag in noteTags) {
                [tag addObject:latestNote.objectId forKey:@"taggedNotes"];
                [tag saveInBackground];
            }
        }
    }];
}


@end
