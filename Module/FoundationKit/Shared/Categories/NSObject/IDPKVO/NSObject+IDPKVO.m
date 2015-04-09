//
//  NSObject+IDPKVO.m
//  iOS
//
//  Created by Oleksa Korin on 6/2/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPKVO.h"

#import "IDPObjCRuntime.h"

#import "NSObject+IDPRuntime.h"

@implementation NSObject (IDPKVO)

+ (Class)KVOClass {
    NSString *className = IDPKVONameOfClass(self);
    
    return NSClassFromString(className);
}

- (Class)KVOClass {
    return [[self class] KVOClass];
}

- (BOOL)isKVOClassObject {
    return [self isa] == [self KVOClass];
}

- (IDPKVOObject *)observeKeyPath:(NSString *)keyPath
                         handler:(IDPKVONotificationBlock)block
{
    return [self observeKeyPaths:@[keyPath]
                         handler:block];
}

- (IDPKVOObject *)observeKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         handler:(IDPKVONotificationBlock)block
{
    return [self observeKeyPaths:@[keyPath]
                         options:options
                         handler:block];
}

- (IDPKVOObject *)observeKeyPaths:(NSArray *)keyPaths
                          handler:(IDPKVONotificationBlock)block
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew
    | NSKeyValueObservingOptionOld
    | NSKeyValueObservingOptionInitial;
    
    return [self observeKeyPaths:keyPaths
                         options:options
                         handler:block];
}

- (IDPKVOObject *)observeKeyPaths:(NSArray *)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          handler:(IDPKVONotificationBlock)block
{
    IDPKVOObject *result = [[IDPKVOObject alloc] initWithObject:self
                                                       keyPaths:keyPaths
                                                        options:options
                                                        handler:block];
    result.observing = YES;
    
    return result;
}

@end
