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

@dynamic KVOObjects;

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

- (NSMutableArray *)KVOObjects {
    return objc_getAssociatedObject(self,
                                    (__bridge const void *)(IDPKVOObjectProperty));
}

- (void)setKVOObjects:(NSMutableArray *)KVOObjects {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(IDPKVOObjectProperty),
                             KVOObjects,
                             OBJC_ASSOCIATION_RETAIN);
}

- (void)addKVOObject:(IDPKVOObject *)object {
    NSMutableArray *objects = self.KVOObjects;
    @synchronized (objects) {
        [objects addObject:object];
    }
}

- (void)removeKVOObject:(IDPKVOObject *)object {
    NSMutableArray *objects = self.KVOObjects;
    @synchronized (objects) {
        [objects removeObject:object];
    }
}

- (NSUInteger)KVOObjectsCount {
    NSMutableArray *objects = self.KVOObjects;
    @synchronized (objects) {
        return [objects count];
    }
}

- (NSArray *)copyKVOObjects {
    NSMutableArray *objects = self.KVOObjects;
    @synchronized (objects) {
        return [objects copy];
    }
}

@end
