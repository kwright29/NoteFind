//
//  OfflineNote+CoreDataProperties.m
//  NoteFind
//
//  Created by Khloe Wright on 8/4/22.
//
//

#import "OfflineNote+CoreDataProperties.h"

@implementation OfflineNote (CoreDataProperties)

+ (NSFetchRequest<OfflineNote *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OfflineNote"];
}

@dynamic addCount;
@dynamic caption;
@dynamic noteFileData;
@dynamic noteFileName;
@dynamic noteID;
@dynamic title;
@dynamic username;

@end
