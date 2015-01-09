//
//  RSLCoreDataWorkerTemplate.m
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import "NSManagedObject+IDPExtensions.h"

#import "IDPCoreDataManager.h"

#import "NSManagedObjectContext+IDPExtensions.h"

@interface NSManagedObject (RSLAdditionsPrivate)
+ (NSManagedObjectContext *)context;
@end

@implementation NSManagedObject (RSLAdditions)

#pragma mark -
#pragma mark Private

+ (NSManagedObjectContext *)context {
	return [[IDPCoreDataManager sharedManager] managedObjectContext];
}

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)fetchEntityWithSortDescriptors:(NSArray *)sortDescriptorsArray 
								  predicate:(NSPredicate *)predicate 
							  prefetchPaths:(NSArray *)prefetchPathes
{
	return [NSManagedObjectContext fetchEntity:NSStringFromClass([self class]) 
						   withSortDescriptors:sortDescriptorsArray 
									 predicate:predicate 
								 prefetchPaths:prefetchPathes];
}

+ (id)managedObject {
	return [NSManagedObjectContext managedObjectWithEntity:NSStringFromClass([self class])];
}

#pragma mark -
#pragma mark Public Methods

- (void)deleteManagedObject {
	[NSManagedObjectContext deleteManagedObject:self];
}

- (void)saveManagedObject {
	[NSManagedObjectContext saveManagedObjectContext];
}
								  
- (void)setCustomValue:(id)value forKey:(NSString *)key {
	[self willChangeValueForKey:key];
	[self setPrimitiveValue:value forKey:key];
	[self didChangeValueForKey:key];
}

- (id)customValueForKey:(NSString *)key {
	[self willAccessValueForKey:key];
	id result = [self primitiveValueForKey:key];
	[self didAccessValueForKey:key];
	
	return result;
}

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	
    [self willChangeValueForKey:key
				withSetMutation:NSKeyValueUnionSetMutation
				   usingObjects:changedObjects];
    
	NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet unionSet:changedObjects];
    
    [self didChangeValueForKey:key
			   withSetMutation:NSKeyValueUnionSetMutation
				  usingObjects:changedObjects];
	
    [changedObjects release];
}

- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key {
	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
	
    [self willChangeValueForKey:key
				withSetMutation:NSKeyValueMinusSetMutation
				   usingObjects:changedObjects];
	
	NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet minusSet:changedObjects];
    
	[self didChangeValueForKey:key
			   withSetMutation:NSKeyValueMinusSetMutation
				  usingObjects:changedObjects];
	
    [changedObjects release];	
}

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {
    [self willChangeValueForKey:key
				withSetMutation:NSKeyValueUnionSetMutation
				   usingObjects:values];
	
	NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet unionSet:values];
    
	[self didChangeValueForKey:key
			   withSetMutation:NSKeyValueUnionSetMutation
				  usingObjects:values];
}

- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key {
	[self willChangeValueForKey:key
				withSetMutation:NSKeyValueMinusSetMutation
				   usingObjects:values];
	
	NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet minusSet:values];
    
	[self didChangeValueForKey:key
			   withSetMutation:NSKeyValueMinusSetMutation
				  usingObjects:values];
}

- (void)rollback {
	NSDictionary *changedValues = [self changedValues];
    NSDictionary *committedValues = [self committedValuesForKeys:[changedValues allKeys]];
	
	for (id key in changedValues) {
		[self setValue:[committedValues objectForKey:key]
				forKey:key];
	}
}

- (void)refresh {
    [self refreshWithMerge:YES];
}

- (void)refreshWithMerge:(BOOL)shouldMerge {
    [[[self class] context] refreshObject:self mergeChanges:shouldMerge];
}

- (void)addCustomValues:(NSOrderedSet *)values inMutableOrderedSetForKey:(NSString *)key {
	
	NSMutableOrderedSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet addObject:values];
    
}

- (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key {
    NSMutableOrderedSet *primitiveSet = [self primitiveValueForKey:key];
	[primitiveSet addObject:value];
}

@end
