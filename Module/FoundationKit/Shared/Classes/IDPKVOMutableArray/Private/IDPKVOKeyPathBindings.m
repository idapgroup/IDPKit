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
@property (nonatomic, strong)   NSDictionary    *keyPathBindings;

@end

@implementation IDPKVOKeyPathBindings

#pragma mark -
#pragma mark Class Methods

+ (instancetype)bindingsWithBridge:(id)bridge
                            object:(id)object
                   keyPathBindings:(NSDictionary *)keyPathBindings
{
    return [[self alloc] initWithBridge:bridge object:object keyPathBindings:keyPathBindings];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithBridge:nil object:nil keyPathBindings:nil];
}

- (instancetype)initWithBridge:(id)bridge
                        object:(id)object
               keyPathBindings:(NSDictionary *)keyPathBindings
{
    self = [super init];
    self.bindings = [NSMutableSet set];
    self.lock = [NSLock new];
    self.bridge = bridge;
    self.object = object;
    self.keyPathBindings = keyPathBindings;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (IDPKVOKeyPathBinding *)bindKeyPath:(NSString *)keyPath
                          forObserver:(NSObject *)observer
                              options:(NSKeyValueObservingOptions)options
                              context:(void *)context
{
    [self unbindKeyPath:keyPath forObserver:observer context:context];
    
    id binding = [[IDPKVOKeyPathBinding alloc] initWithBindings:self
                                                        keyPath:keyPath
                                                       observer:observer
                                                        options:options
                                                        context:context];
    
    [self.lock performBlock:^{
        [self.bindings addObject:binding];
    }];
}

- (void)unbindKeyPath:(NSString *)keyPath forObserver:(NSObject *)observer {
    [self.lock performBlock:^{
        id predicate = [NSPredicate predicateWithBlock:^BOOL(IDPKVOKeyPathBinding *object, NSDictionary *bindings) {
            return !([object.keyPath isEqualToString:keyPath] && object.observer == observer);
        }];
        
        [self.bindings filterUsingPredicate:predicate];
    }];
}

- (void)unbindKeyPath:(NSString *)objectKeyPath
          forObserver:(NSObject *)observer
              context:(void *)context
{
    id binding = [[IDPKVOKeyPathBinding alloc] initWithBindings:self
                                                        keyPath:keyPath
                                                       observer:observer
                                                        options:0
                                                        context:context];
    
    [self.lock performBlock:^{
        [self.bindings removeObject:binding];
    }];
}

@end
