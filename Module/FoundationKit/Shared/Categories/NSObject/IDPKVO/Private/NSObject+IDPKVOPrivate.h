//
//  NSObject+IDPKVOPrivate.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVOObject;

extern
NSString *IDPKVONameOfClass(Class cls);

@interface NSObject (IDPKVOPrivate)
@property (atomic, retain)  NSMutableSet  *KVOObjectsSet;

+ (Class)KVOClass;

- (Class)isa;
- (Class)KVOClass;

- (BOOL)isKVOClassObject;

// Thread safe methods for accessing KVOObjects
- (void)addKVOObject:(IDPKVOObject *)object;
- (void)removeKVOObject:(IDPKVOObject *)object;
- (NSUInteger)KVOObjectsCount;
- (NSSet *)copyKVOObjectsSet;

@end
