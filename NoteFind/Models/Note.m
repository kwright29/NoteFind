//
//  Note.m
//  NoteFind
//
//  Created by Khloe Wright on 7/8/22.
//

#import "Note.h"

@implementation Note

@dynamic noteID;
@dynamic userID;
@dynamic note;
@dynamic author;
@dynamic tags;
@dynamic textbook;
@dynamic addCount;
@dynamic caption;
@dynamic uploaded;


+ (nonnull NSString *)parseClassName {
    return @"Note";
}

+ (void) postUserNote: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Note *newPost = [Note new];
    newPost.note = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.addCount = @(0);

    
    [newPost saveInBackgroundWithBlock: completion];
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


@end
