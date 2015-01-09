//
//  IDPCoreDataManager.h
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface IDPCoreDataManager : NSObject {
@private
	
	NSString *_storeName;
	NSString *_momName;
	NSString *_storeType;
	
    NSManagedObjectContext			*_managedObjectContext;
    NSManagedObjectModel			*_managedObjectModel;
    NSPersistentStoreCoordinator	*_persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext			*managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel			*managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator	*persistentStoreCoordinator;

+ (id)sharedManager;

+ (id)sharedManagerWithMomName:(NSString *)mom;

+ (id)sharedManagerWithStoreName:(NSString *)store
                         momName:(NSString *)mom;

// if storeType is nil, the sqlite store is used
+ (id)sharedManagerWithStoreName:(NSString *)store
                         momName:(NSString *)mom
                       storeType:(NSString *)storeType;

- (void)deleteCurrentStore;

@end


