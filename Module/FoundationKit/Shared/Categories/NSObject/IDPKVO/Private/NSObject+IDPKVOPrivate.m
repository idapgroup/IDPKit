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
#import "IDPKVOObject.h"

static NSString * const IDPKVOObjectProperty    = @"IDPKVOObjectProperty";

NSString *IDPKVONameOfClass(Class cls) {
    return [NSString stringWithFormat:@"NSKVONotifying_%@", NSStringFromClass(cls)];
}

@implementation NSObject (IDPKVOPrivate)

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

- (NSMutableArray *)KVOObjectsSet {
    return objc_getAssociatedObject(self,
                                    (__bridge const void *)(IDPKVOObjectProperty));
}

- (void)setKVOObjectsSet:(NSMutableSet *)KVOObjects {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(IDPKVOObjectProperty),
                             KVOObjects,
                             OBJC_ASSOCIATION_RETAIN);
}

- (void)addKVOObject:(IDPKVOObject *)object {
    NSMutableSet *objects = self.KVOObjectsSet;
    @synchronized (objects) {
        [objects addObject:object];
    }
}

- (void)removeKVOObject:(IDPKVOObject *)object {
    NSMutableSet *objects = self.KVOObjectsSet;
    @synchronized (objects) {
        [objects removeObject:object];
    }
}

- (NSUInteger)KVOObjectsCount {
    NSMutableSet *objects = self.KVOObjectsSet;
    @synchronized (objects) {
        return [objects count];
    }
}

- (NSSet *)copyKVOObjectsSet {
    NSMutableSet *objects = self.KVOObjectsSet;
    @synchronized (objects) {
        return [objects copy];
    }
}

@end
