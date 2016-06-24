//
//  IDPKVOKeyPathBindings.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/24/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPKVOKeyPathBindings.h"

#import "IDPKVOKeyPathBinding.h"
#import "IDPLocking.h"

@interface IDPKVOKeyPathBindings ()
@property (nonatomic, weak)     id              bridge;
@property (nonatomic, weak)     id              object;
@property (nonatomic, strong)   NSMutableSet    *bindings;
@property (nonatomic, strong)   id<IDPLocking>  lock;

- (IDPKVOKeyPathBinding *)bindingWithObjectKeyPath:(NSString *)objectKeyPath
                                     bridgeKeyPath:(NSString *)bridgeKeyPath
                                          observer:(NSObject *)observer
                                           options:(NSKeyValueObservingOptions)options
                                           context:(void *)context
                                             block:(IDPKVOKeyPathBindingBlock)block;

@end

@implementation IDPKVOKeyPathBindings

#pragma mark -
#pragma mark Class Methods

+ (instancetype)setWithBridge:(id)bridge object:(id)object {
    return [[self alloc] initWithBridge:bridge object:object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithBridge:nil object:nil];
}

- (instancetype)initWithBridge:(id)bridge object:(id)object {
    self = [super init];
    self.bindings = [NSMutableSet set];
    self.lock = [NSLock new];
    self.bridge = bridge;
    self.object = object;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)bindObjectKeyPath:(NSString *)objectKeyPath
          toBridgeKeyPath:(NSString *)bridgeKeyPath
              forObserver:(NSObject *)observer
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context
{
    id binding = [self bindingWithObjectKeyPath:objectKeyPath
                                  bridgeKeyPath:bridgeKeyPath
                                       observer:observer
                                        options:options
                                        context:context
                                          block:nil];
    
    [self.lock performBlock:^{
        [self.bindings addObject:binding];
    }];
}

- (void)unbindObjectKeyPath:(NSString *)objectKeyPath
            toBridgeKeyPath:(NSString *)bridgeKeyPath
                forObserver:(NSObject *)observer
{
    id binding = [self bindingWithObjectKeyPath:objectKeyPath
                                  bridgeKeyPath:bridgeKeyPath
                                       observer:observer
                                        options:0
                                        context:NULL
                                          block:nil];
    
    [self.lock performBlock:^{
        id predicate = [NSPredicate predicateWithBlock:^BOOL(IDPKVOKeyPathBinding *object, NSDictionary *bindings) {
            return ![object isEqualToBinding:binding];
        }];
        
        [self.bindings filterUsingPredicate:predicate];
    }];
}

- (void)unbindObjectKeyPath:(NSString *)objectKeyPath
            toBridgeKeyPath:(NSString *)bridgeKeyPath
                forObserver:(NSObject *)observer
                    context:(void *)context
{
    id binding = [self bindingWithObjectKeyPath:objectKeyPath
                                  bridgeKeyPath:bridgeKeyPath
                                       observer:observer
                                        options:0
                                        context:context
                                          block:nil];
    
    [self.lock performBlock:^{
        [self.bindings removeObject:binding];
    }];
}

#pragma mark -
#pragma mark Private

- (IDPKVOKeyPathBinding *)bindingWithObjectKeyPath:(NSString *)objectKeyPath
                                     bridgeKeyPath:(NSString *)bridgeKeyPath
                                          observer:(NSObject *)observer
                                           options:(NSKeyValueObservingOptions)options
                                           context:(void *)context
                                             block:(IDPKVOKeyPathBindingBlock)block
{
    return [[IDPKVOKeyPathBinding alloc] initWithObject:self.object
                                                 bridge:self.bridge
                                          objectKeyPath:objectKeyPath
                                          bridgeKeyPath:bridgeKeyPath
                                               observer:observer
                                                options:options
                                                context:context
                                                  block:block];
}

@end
