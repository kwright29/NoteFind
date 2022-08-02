//
//  OfflineNote+CoreDataProperties.h
//  NoteFind
//
//  Created by Khloe Wright on 8/1/22.
//
//

#import "OfflineNote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OfflineNote (CoreDataProperties)

+ (NSFetchRequest<OfflineNote *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *caption;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int64_t addCount;
@property (nullable, nonatomic, retain) PFFileObject *note;

@end

NS_ASSUME_NONNULL_END
