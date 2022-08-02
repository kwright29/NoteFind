//
//  OfflineNote+CoreDataProperties.m
//  NoteFind
//
//  Created by Khloe Wright on 8/1/22.
//
//

#import "OfflineNote+CoreDataProperties.h"


@implementation OfflineNote (CoreDataProperties)

+ (NSFetchRequest<OfflineNote *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OfflineNote"];
}


@dynamic username;
@dynamic caption;
@dynamic title;
@dynamic addCount;
@dynamic note;

@end
