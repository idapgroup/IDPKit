//
//  IDPSafeKVOContext.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPSafeKVOContext.h"

#import <objc/runtime.h>

#import "IDPKVOObject.h"
#import "IDPObjCRuntime.h"

#import "NSObject+IDPKVO.h"
#import "NSObject+IDPKVOPrivate.h"

@interface IDPSafeKVOContext ()
@property (nonatomic, strong)   NSObject    *object;
@property (nonatomic, readonly) NSHashTable *safeClasses;

+ (NSHashTable *)safeClasses;

- (void)invoke;
- (void)setupDeallocImplementation;

// Thread safe methods for accessing safe classes
- (void)addClassToSafeClasses:(Class)cls;
- (void)removeClassFromSafeClasses:(Class)cls;
- (BOOL)containsClassInSafeClasses:(Class)cls;
- (NSUInteger)safeClassesCount;

@end

@implementation IDPSafeKVOContext

@dynamic safeClasses;

#pragma mark -
#pragma mark Class Methods

+ (NSHashTable *)safeClasses {
    static dispatch_once_t onceToken;
    static NSHashTable *safeKVOClasses = nil;
    dispatch_once(&onceToken, ^{
        NSPointerFunctionsOptions options = NSHashTableObjectPointerPersonality
                                            | NSHashTableWeakMemory;

        safeKVOClasses = [NSHashTable hashTableWithOptions:options];
    });
    
    return safeKVOClasses;
}

+ (void)makeObjectSafe:(NSObject *)object {
    IDPSafeKVOContext *context = [IDPSafeKVOContext new];
    context.object = object;
    
    [context invoke];
}

#pragma mark -
#pragma mark Accessors

- (NSHashTable *)safeClasses {
    return [[self class] safeClasses];
}

#pragma mark -
#pragma mark Collection Accessors

- (void)addClassToSafeClasses:(Class)class {
    NSHashTable *classes = [self safeClasses];
    @synchronized (classes) {
        [classes addObject:class];
    }
}

- (void)removeClassFromSafeClasses:(Class)class {
    NSHashTable *classes = [self safeClasses];
    @synchronized (classes) {
        [classes removeObject:class];
    }
}

- (BOOL)containsClassInSafeClasses:(Class)class {
    NSHashTable *classes = [self safeClasses];
    @synchronized (classes) {
        return [classes containsObject:class];
    }
}

- (NSUInteger)safeClassesCount {
    NSHashTable *classes = [self safeClasses];
    @synchronized (classes) {
        return [classes count];
    }
}

#pragma mark -
#pragma mark Private

- (void)invoke {
    NSObject *object = self.object;
    if (![object isKVOClassObject]) {
        return;
    }
    
    // Only add the implementation, if it wasn't added previously
    if (![self containsClassInSafeClasses:[object class]]) {
        [self setupDeallocImplementation];
    }
}

- (void)setupDeallocImplementation {
    NSObject *target = self.object;
    Class class = [target class];
    
    @synchronized (class) {
        SEL	deallocSEL = NSSelectorFromString(@"dealloc");
        Method dealloc = class_getInstanceMethod(class, deallocSEL);
        IMP	previousIMP = method_getImplementation(dealloc);
        
        void (^deallocBlock)(__assign NSObject *object) = ^(__assign NSObject *object) {
            @autoreleasepool {
                NSSet *objects = object.KVOObjectsSet;
                for (IDPKVOObject *object in objects) {
                    [object invalidate];
                }
            }
            
            ((void (*)(__assign NSObject *, SEL))previousIMP)(object, deallocSEL);
        };
        
        IMP implementation = imp_implementationWithBlock(deallocBlock);
        
        class_replaceMethod(class,
                            deallocSEL,
                            implementation,
                            method_getTypeEncoding(dealloc));
        
        [self addClassToSafeClasses:class];
    }
}

@end
