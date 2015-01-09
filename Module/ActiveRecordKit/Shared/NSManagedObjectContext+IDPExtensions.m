//
//  NSManagedObjectContext+RSLAdditions.m
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import "NSManagedObjectContext+IDPExtensions.h"

#import "IDPCoreDataManager.h"

#import "NSObject+IDPExtensions.h"

@interface NSManagedObjectContext (IDPExtensionsPrivate)
+ (NSManagedObjectContext *)context;
@end

@implementation NSManagedObjectContext (IDPExtensionsPrivate)

+ (NSManagedObjectContext *)context {
	return [[IDPCoreDataManager sharedManager] managedObjectContext];
}

@end

@implementation NSManagedObjectContext (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)fetchEntity:(NSString *)entityName 
	 withSortDescriptors:(NSArray *)sortDescriptorsArray 
			   predicate:(NSPredicate *)predicate 
		   prefetchPaths:(NSArray *)prefetchPathes 
{
    // Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self context]];
    fetchRequest.entity = entity;
    
    // Set the batch size to a suitable number.
    fetchRequest.fetchBatchSize = BATCH_SIZE;
	
	fetchRequest.returnsObjectsAsFaults = NO;
	fetchRequest.includesSubentities = YES;
	
	// Set fetch sort descriptors and predicate
    fetchRequest.sortDescriptors = sortDescriptorsArray;
	fetchRequest.predicate = predicate;
	fetchRequest.relationshipKeyPathsForPrefetching = prefetchPathes;
    
    // fetch data
	NSError *error = nil;
	NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedObjects;
	
}

+ (id)managedObjectWithEntity:(NSString *)entityName {
	// Create and return a new instance of the entity.
	return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self context]];
}

+ (void)deleteManagedObject:(NSManagedObject *)object {
	[[self context] deleteObject:object];
	[self saveManagedObjectContext];
}

+ (void)resetManagedObjectContext {
	[[self context] reset];
}

+ (void)saveManagedObjectContext {
	NSError *error = nil;
    if ([[self context] hasChanges])
		if (![[self context] save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
}

+ (NSManagedObject *)getObjectWithName:(NSString *)name 
							  forValue:(NSString *)valueName 
							  ofEntity:(NSString *)entityName 
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@", valueName, name];
	NSArray *result = [self fetchEntity:entityName withSortDescriptors:nil predicate:predicate prefetchPaths:nil];
	
	if ([result count] > 0) {
		return [result objectAtIndex:0];
	}
	
	return nil;
}

+ (NSManagedObject *)getObjectWithProperty:(id)property 
								  forValue:(NSString *)valueName 
								  ofEntity:(NSString *)entityName 
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@", valueName, property];
	NSArray *result = [self fetchEntity:entityName withSortDescriptors:nil predicate:predicate prefetchPaths:nil];
	
	if ([result count] > 0) {
		return [result objectAtIndex:0];
	}
	
	return nil;	
}

+ (NSManagedObject *)managedObjectWithManagedObjectIDURI:(NSURL *)uri {
	IDPCoreDataManager *ston = [IDPCoreDataManager sharedManager];
	
    NSManagedObjectID *objectID = [ston.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
	
    if (!objectID) {
        return nil;
    }
	
	return [self managedObjectWithManagedObjectID:objectID];
}

+ (NSManagedObject *)managedObjectWithManagedObjectID:(NSManagedObjectID *)objectID {
	NSManagedObject *objectForID = [[self context] objectWithID:objectID];
    if (![objectForID isFault]) {
        return objectForID;
    }
	
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = %@", objectForID];
	
    NSArray *results = [self fetchEntity:NSStringFromClass([objectForID class]) 
					 withSortDescriptors:nil 
							   predicate:predicate 
						   prefetchPaths:nil];
	
	if ([results count] > 0 ) {
        return [results objectAtIndex:0];
    }
	
    return nil;
}


@end
