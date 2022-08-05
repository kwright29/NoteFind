//
//  OfflineDataManager.h
//  NoteFind
//
//  Created by Khloe Wright on 8/3/22.
//

#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface OfflineDataManager : NSObject
- (void)downloadNote:(Note *)note;
- (NSArray *)getOfflineNotes;
+ (UIImage *)getImageFromData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
