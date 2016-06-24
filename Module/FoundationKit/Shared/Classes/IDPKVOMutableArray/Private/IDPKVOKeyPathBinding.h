//
//  IDPKVOKeyPathBinding.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVONotification;
@class IDPKVOKeyPathBinding;

typedef void(^IDPKVOKeyPathBindingBlock)(IDPKVOKeyPathBinding *binding, IDPKVONotification *notification);

@interface IDPKVOKeyPathBinding : NSObject
@property (nonatomic, weak, readonly)   NSObject                    *object;
@property (nonatomic, weak, readonly)   NSObject                    *bridge;
@property (nonatomic, weak, readonly)   NSObject                    *observer;
@property (nonatomic, copy, readonly)   NSString                    *objectKeyPath;
@property (nonatomic, copy, readonly)   NSString                    *bridgeKeyPath;
@property (nonatomic, readonly)         NSKeyValueObservingOptions  options;
@property (nonatomic, readonly)         void                        *context;

- (instancetype)initWithObject:(NSObject *)object
                        bridge:(NSObject *)bridge
                 objectKeyPath:(NSString *)objectKeyPath
                 bridgeKeyPath:(NSString *)bridgeKeyPath
                      observer:(NSObject *)observer
                       options:(NSKeyValueObservingOptions)options
                       context:(void *)context;

// if block == nil it forwards all notifications from object to bridge replacing the keypaths,
// you can setup processing of notifications in block,
// you are responsible for the notifications delivery to observer in block call.
- (instancetype)initWithObject:(NSObject *)object
                        bridge:(NSObject *)bridge
                 objectKeyPath:(NSString *)objectKeyPath
                 bridgeKeyPath:(NSString *)bridgeKeyPath
                      observer:(NSObject *)observer
                       options:(NSKeyValueObservingOptions)options
                       context:(void *)context
                         block:(IDPKVOKeyPathBindingBlock)block NS_DESIGNATED_INITIALIZER;


- (BOOL)isEqual:(id)object;
- (BOOL)isEqualToBinding:(IDPKVOKeyPathBinding *)object;

- (IDPKVOKeyPathBindingBlock)defaultBinding;

@end
