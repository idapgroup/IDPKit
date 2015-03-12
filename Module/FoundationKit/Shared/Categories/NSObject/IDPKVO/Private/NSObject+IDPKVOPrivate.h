//
//  NSObject+IDPKVOPrivate.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVOController;

extern
NSString *IDPKVONameOfClass(Class cls);

@interface NSObject (IDPKVOPrivate)
@property (atomic, strong)      NSMutableSet  *mutableKVOControllersSet;
@property (atomic, readonly)    NSSet         *KVOControllersSet;

+ (Class)KVOClass;

- (Class)isa;
- (Class)KVOClass;

- (BOOL)isKVOClassObject;

// Thread safe methods for accessing KVOControllers
- (void)addKVOController:(IDPKVOController *)object;
- (void)removeKVOController:(IDPKVOController *)object;
- (NSUInteger)KVOControllersCount;

@end
