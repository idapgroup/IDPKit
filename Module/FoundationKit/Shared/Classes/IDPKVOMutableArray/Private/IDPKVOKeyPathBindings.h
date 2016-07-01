//
//  IDPKVOKeyPathBindings.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/24/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPKVOKeyPathBinding.h"

@interface IDPKVOKeyPathBindings : NSObject

// object, that delegates the KVO
@property (nonatomic, readonly, weak)   id      bridge;

// actual object being KVOed
@property (nonatomic, readonly, weak)   id      object;

@property (nonatomic, readonly) NSDictionary    *keyPathBindings;

+ (instancetype)bindingsWithBridge:(id)bridge
                            object:(id)object
                   keyPathBindings:(NSDictionary *)keyPathBindings;

- (instancetype)initWithBridge:(id)bridge
                        object:(id)object
               keyPathBindings:(NSDictionary *)keyPathBindings NS_DESIGNATED_INITIALIZER;

- (IDPKVOKeyPathBinding *)bindKeyPath:(NSString *)keyPath
                          forObserver:(NSObject *)observer
                              options:(NSKeyValueObservingOptions)options
                              context:(void *)context;

- (void)unbindKeyPath:(NSString *)keyPath
          forObserver:(NSObject *)observer;

- (void)unbindKeyPath:(NSString *)keyPath
          forObserver:(NSObject *)observer
              context:(void *)context;

@end
