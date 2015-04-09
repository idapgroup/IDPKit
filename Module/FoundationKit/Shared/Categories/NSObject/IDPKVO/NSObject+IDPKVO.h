//
//  NSObject+IDPKVO.h
//  iOS
//
//  Created by Oleksa Korin on 6/2/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPKVOObject.h"

@interface NSObject (IDPKVO)

+ (Class)KVOClass;

- (Class)KVOClass;

- (BOOL)isKVOClassObject;

- (IDPKVOObject *)observeKeyPath:(NSString *)keyPath
                         handler:(IDPKVONotificationBlock)block;

- (IDPKVOObject *)observeKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         handler:(IDPKVONotificationBlock)block;

- (IDPKVOObject *)observeKeyPaths:(NSArray *)keyPaths
                          handler:(IDPKVONotificationBlock)block;

- (IDPKVOObject *)observeKeyPaths:(NSArray *)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          handler:(IDPKVONotificationBlock)block;

@end
