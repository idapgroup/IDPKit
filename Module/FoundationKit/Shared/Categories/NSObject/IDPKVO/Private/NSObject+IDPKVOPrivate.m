//
//  NSObject+IDPKVOPrivate.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPKVOPrivate.h"

#import <objc/runtime.h>

#import "IDPObjCRuntime.h"
#import "IDPKVOController.h"

static NSString * const IDPKVOControllerProperty    = @"IDPKVOControllerProperty";

NSString *IDPKVONameOfClass(Class cls) {
    return [NSString stringWithFormat:@"NSKVONotifying_%@", NSStringFromClass(cls)];
}

@implementation NSObject (IDPKVOPrivate)

@dynamic mutableKVOObjectsSet;
@dynamic KVOObjectsSet;

+ (Class)KVOClass {
    NSString *className = IDPKVONameOfClass(self);
    
    return NSClassFromString(className);
}

- (Class)isa {
    return object_getClass(self);
}

- (Class)KVOClass {
    return [[self class] KVOClass];
}

- (BOOL)isKVOClassObject {
    return [self isa] == [self KVOClass];
}

- (NSMutableSet *)mutableKVOObjectsSet {
    const void *key = (__bridge const void *)IDPKVOControllerProperty;
    
    volatile NSMutableSet *objects = objc_getAssociatedObject(self, key);
    if (!objects) {
        @synchronized (self) {
            if (!objects) {
                objects = [NSMutableSet new];
                self.mutableKVOObjectsSet = (NSMutableSet *)objects;
            }
        }
    }
    
    return (NSMutableSet *)objects;
}

- (void)setMutableKVOObjectsSet:(NSMutableSet *)objects {
    const void *key = (__bridge const void *)IDPKVOControllerProperty;
    objc_setAssociatedObject(self,
                             key,
                             objects,
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSSet *)KVOObjectsSet {
    NSMutableSet *objects = self.mutableKVOObjectsSet;
    @synchronized (objects) {
        return [objects copy];
    }
}

- (void)addKVOObject:(IDPKVOController *)object {
    NSMutableSet *objects = self.mutableKVOObjectsSet;
    @synchronized (objects) {
        [objects addObject:object];
    }
}

- (void)removeKVOObject:(IDPKVOController *)object {
    NSMutableSet *objects = self.mutableKVOObjectsSet;
    @synchronized (objects) {
        [objects removeObject:object];
    }
}

- (NSUInteger)KVOObjectsCount {
    NSMutableSet *objects = self.mutableKVOObjectsSet;
    @synchronized (objects) {
        return [objects count];
    }
}

@end
