//
//  NSObject+IDPKVOPrivate.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPKVOPrivate.h"

#import <objc/runtime.h>

#import "IDPKVOObject.h"

static NSString * const IDPKVOObjectProperty    = @"IDPKVOObjectProperty";

@implementation NSObject (IDPKVOPrivate)

@dynamic mutableKVOObjectsSet;
@dynamic KVOObjectsSet;

- (NSMutableSet *)mutableKVOObjectsSet {
    const void *key = (__bridge const void *)IDPKVOObjectProperty;
    
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
    const void *key = (__bridge const void *)IDPKVOObjectProperty;
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

- (void)addKVOObject:(IDPKVOObject *)object {
    NSMutableSet *objects = self.mutableKVOObjectsSet;
    @synchronized (objects) {
        [objects addObject:object];
    }
}

- (void)removeKVOObject:(IDPKVOObject *)object {
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
