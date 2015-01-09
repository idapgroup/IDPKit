//
//  RSLCoreDataWorkerTemplate.h
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (IDPExtensions)

+ (NSArray *)fetchEntityWithSortDescriptors:(NSArray *)sortDescriptorsArray 
								  predicate:(NSPredicate *)predicate 
							  prefetchPaths:(NSArray *)prefetchPathes; 
	 

+ (id)managedObject;

- (void)deleteManagedObject;
- (void)saveManagedObject;

- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customValueForKey:(NSString *)key;

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key;
- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;
- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;

// rolls back the changes to the last commited state for just one object,
// unlike NSManagedObjectContext rollback, which rolls back entire context
- (void)rollback;

// Merges changes
- (void)refresh;
- (void)refreshWithMerge:(BOOL)shouldMerge;

- (void)addCustomValues:(NSOrderedSet *)values inMutableOrderedSetForKey:(NSString *)key;
- (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key;

@end
