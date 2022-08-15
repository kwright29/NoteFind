//
//  OfflineDataManager.h
//  NoteFind
//
//  Created by Khloe Wright on 8/3/22.
//

#import "Note.h"

#import <CoreData/CoreData.h>
#import "OfflineNote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@protocol DeleteDelegate
- (void)refreshAfterDeletion;
@end

@interface OfflineDataManager : NSObject
- (void)downloadNote:(Note *)note;
- (NSArray *)getOfflineNotes;
+ (UIImage *)getImageFromData:(NSData *)data;
- (void)deleteNote:(OfflineNote *)offlineNote;
@property (nonatomic, weak) id <DeleteDelegate> deleteDelegate;
@end

NS_ASSUME_NONNULL_END
