//
//  NSManagedObjectContext+RSLAdditions.h
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import <CoreData/CoreData.h>

#define BATCH_SIZE 0

@interface NSManagedObjectContext (IDPExtensions)

+ (id)managedObjectWithEntity:(NSString *)entityName;

+ (NSArray *)fetchEntity:(NSString *)entityName 
	 withSortDescriptors:(NSArray *)sortDescriptorsArray 
			   predicate:(NSPredicate *)predicate 
		   prefetchPaths:(NSArray *)prefetchPathes;

+ (id)getObjectWithName:(NSString *)name 
			   forValue:(NSString *)valueName 
			   ofEntity:(NSString *)entityName;

+ (id)getObjectWithProperty:(id)property 
				   forValue:(NSString *)valueName 
				   ofEntity:(NSString *)entityName;

+ (id)managedObjectWithManagedObjectIDURI:(NSURL *)uri;
+ (id)managedObjectWithManagedObjectID:(NSManagedObjectID *)objectID;


+ (void)deleteManagedObject:(NSManagedObject *)object;
+ (void)resetManagedObjectContext;
+ (void)saveManagedObjectContext;

@end
