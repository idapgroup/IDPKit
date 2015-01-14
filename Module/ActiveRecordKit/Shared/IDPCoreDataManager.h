//
//  IDPCoreDataManager.h
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface IDPCoreDataManager : NSObject
@property (nonatomic, readonly) NSManagedObjectContext			*managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel			*managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*persistentStoreCoordinator;

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


