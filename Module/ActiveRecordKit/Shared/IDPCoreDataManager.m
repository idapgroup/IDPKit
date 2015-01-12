//
//  IDPCoreDataManager.m
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#import "IDPCoreDataManager.h"

#import "NSFileManager+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

static NSString * const kStore  = @"Store";


static IDPCoreDataManager *__sharedManager = nil;

@interface IDPCoreDataManager ()
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *momName;
@property (nonatomic, copy) NSString *storeType;

- (void)applicationWillTerminate:(NSNotification *)notification;
@end

@implementation IDPCoreDataManager

@synthesize storeName	= _storeName;
@synthesize momName		= _momName;
@synthesize storeType	= _storeType;

@dynamic managedObjectContext;
@dynamic managedObjectModel;
@dynamic persistentStoreCoordinator;

#pragma mark -
#pragma mark Singleton

+ (id)sharedManager {
    return __sharedManager;
}

+ (id)sharedManagerWithMomName:(NSString *)mom {
    NSString *storeName = [NSString stringWithFormat:@"%@%@", mom, kStore];
    
    return [self sharedManagerWithStoreName:storeName momName:mom];
}

+ (id)sharedManagerWithStoreName:(NSString *)store
                         momName:(NSString *)mom
{
	return [self sharedManagerWithStoreName:store
                                    momName:mom
                                  storeType:nil];
}

+ (id)sharedManagerWithStoreName:(NSString *)store
                         momName:(NSString *)mom
                       storeType:(NSString *)storeType
{
    static dispatch_once_t once;
    #warning TEMP decision
//    dispatch_once(&once, ^{
    if (!__sharedManager) {
        __sharedManager = [[self alloc] init];
        __sharedManager.storeName = store;
        __sharedManager.momName = mom;
        __sharedManager.storeType = storeType;
//    });

    }
	return __sharedManager;
}

#pragma mark -
#pragma mark Singleton Service

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t once;
    
    __block id result = __sharedManager;
    
#warning TEMP decision
//    dispatch_once(&once, ^{
    if (!__sharedManager) {
        result = [super allocWithZone:zone];
    }
//    });

    return result;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

#pragma mark -
#pragma mark Initialization

#ifndef IDPApplicationWillTerminate
    #if TARGET_OS_IPHONE
        #define IDPApplicationWillTerminateNotification UIApplicationWillTerminateNotification
    #else
        #define IDPApplicationWillTerminateNotification NSApplicationWillTerminateNotification
    #endif
#endif

- (id)init {
    static dispatch_once_t once;
    
    __block id result = self;
    
    #warning TEMP decision
//    dispatch_once(&once, ^{
    if (!__sharedManager) {
        result = [super init];
        if (nil != result) {
            [result subscribeSelector:@selector(applicationWillTerminate:)
                 onApplicationEvent:IDPApplicationWillTerminateNotification];

#if TARGET_OS_IPHONE
            [result subscribeSelector:@selector(applicationWillTerminate:)
                 onApplicationEvent:UIApplicationDidEnterBackgroundNotification];
#endif
        }
    }
//    });
    
    self = result;

	return self;
}

#undef IDPApplicationWillTerminate

#pragma mark -
#pragma mark UIApplicationDelegateNotifications

- (void)subscribeSelector:(SEL)selector onApplicationEvent:(NSString *)eventName {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:eventName
                                               object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
	NSError *error = nil;
	NSLog(@"Terminated from singleton");
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        } 
    }
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
	
	if (self.momName != nil) {
#warning TEST that shit carefully possible drawbacks for such a hack to find the main bundle
//		NSString *modelPath = [[NSBundle mainBundle] pathForResource:self.momName ofType:@"momd"];
		NSBundle *bundle = [NSBundle bundleForClass:[self class]];
		NSString *modelPath = [bundle pathForResource:self.momName ofType:@"momd"];
		if (modelPath == nil) {
			NSLog(@"momd %@ is nonexistent", self.momName);
			abort();
		}
		NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
	} else {
		NSLog(@"momd name was not specified");
		abort();
	}

	
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
	if (self.storeName == nil) {
		NSLog(@"store name was not specified");
		abort();
	}
	
    NSURL *storeURL = [NSURL fileURLWithPath: [[NSFileManager applicationDataPath]
											   stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", self.storeName, @".sqlite"]]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSString *storeType = ((nil == self.storeType)?NSSQLiteStoreType:self.storeType);
    if (![_persistentStoreCoordinator addPersistentStoreWithType:storeType 
												   configuration:nil 
															 URL:storeURL 
														 options:nil 
														   error:&error]) 
	{
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Public Functions

// Convenience method. Nonexistent in release build.
//#ifdef DEBUG
- (void)deleteCurrentStore {
	NSString *storePath = [[NSFileManager documentsDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", self.storeName, @".sqlite"]];
//    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    NSPersistentStore *persistensStore = [[self.persistentStoreCoordinator persistentStores] objectAtIndex:0];
    [self.persistentStoreCoordinator removePersistentStore:persistensStore error:nil];
    [[NSFileManager defaultManager] removeItemAtURL:persistensStore.URL error:nil];
//	[[NSFileManager defaultManager] removeItemAtPath:storePath error:nil];
	NSLog(@"Store at %@ was deleted", storePath);
    __sharedManager = nil;
}
//#endif

@end
