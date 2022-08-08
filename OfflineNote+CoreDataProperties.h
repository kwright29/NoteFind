//
//  OfflineNote+CoreDataProperties.h
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//
//

#import "OfflineNote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OfflineNote (CoreDataProperties)

+ (NSFetchRequest<OfflineNote *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) int64_t addCount;
@property (nullable, nonatomic, copy) NSString *caption;
@property (nullable, nonatomic, retain) NSData *noteFileData;
@property (nullable, nonatomic, copy) NSString *noteFileName;
@property (nullable, nonatomic, copy) NSString *noteID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
