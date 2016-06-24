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
@property (nonatomic, readonly, weak) id      bridge;

// actual object being KVOed
@property (nonatomic, readonly, weak) id      object;

+ (instancetype)setWithBridge:(id)bridge object:(id)object;

- (instancetype)initWithBridge:(id)bridge object:(id)object NS_DESIGNATED_INITIALIZER;

- (void)bindObjectKeyPath:(NSString *)objectKeyPath
          toBridgeKeyPath:(NSString *)bridgeKeyPath
              forObserver:(NSObject *)observer
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context;

- (void)bindObjectKeyPath:(NSString *)objectKeyPath
          toBridgeKeyPath:(NSString *)bridgeKeyPath
              forObserver:(NSObject *)observer
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context
                    block:(IDPKVOKeyPathBindingBlock)block;

- (void)unbindObjectKeyPath:(NSString *)objectKeyPath
            toBridgeKeyPath:(NSString *)bridgeKeyPath
                forObserver:(NSObject *)observer;

- (void)unbindObjectKeyPath:(NSString *)objectKeyPath
            toBridgeKeyPath:(NSString *)bridgeKeyPath
                forObserver:(NSObject *)observer
                    context:(void *)context;

@end
