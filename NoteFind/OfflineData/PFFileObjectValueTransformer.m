//
//  PFFileObjectValueTransformer.m
//  NoteFind
//
//  Created by Khloe Wright on 8/1/22.
//

#import <Parse/Parse.h>
#import "PFFileObjectValueTransformer.h"

@implementation PFFileObjectValueTransformer

+(Class)transformedValueClass {
    return [NSData class];
}

+ (BOOL) allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    return (value == nil) ? nil : NSStringFromClass([value class]);
}
@end
