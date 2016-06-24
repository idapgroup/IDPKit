//
//  IDPKVOKeyPathBinding.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPKVOKeyPathBinding.h"

#import "IDPComparison.h"

#import "NSObject+IDPKVO.h"

#import "IDPOwnershipMacros.h"

@interface IDPKVOKeyPathBinding ()
@property (nonatomic, weak)     NSObject                    *object;
@property (nonatomic, weak)     NSObject                    *bridge;
@property (nonatomic, weak)     NSObject                    *observer;
@property (nonatomic, copy)     NSString                    *objectKeyPath;
@property (nonatomic, copy)     NSString                    *bridgeKeyPath;
@property (nonatomic, assign)   NSKeyValueObservingOptions  options;
@property (nonatomic, assign)   void                        *context;
@property (nonatomic, strong)   IDPKVOController            *kvoController;

- (IDPKVOController *)kvoControllerForBindingBlock:(IDPKVOKeyPathBindingBlock)block;

@end

@implementation IDPKVOKeyPathBinding

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObject:nil
                         bridge:nil
                  objectKeyPath:nil
                  bridgeKeyPath:nil
                       observer:nil
                        options:0
                        context:NULL];
}

- (instancetype)initWithObject:(NSObject *)object
                        bridge:(NSObject *)bridge
                 objectKeyPath:(NSString *)objectKeyPath
                 bridgeKeyPath:(NSString *)bridgeKeyPath
                      observer:(NSObject *)observer
                       options:(NSKeyValueObservingOptions)options
                       context:(void *)context
{
    return [self initWithObject:object
                         bridge:bridge
                  objectKeyPath:objectKeyPath
                  bridgeKeyPath:bridgeKeyPath
                       observer:observer
                        options:options
                        context:context
                          block:nil];
}

- (instancetype)initWithObject:(NSObject *)object
                        bridge:(NSObject *)bridge
                 objectKeyPath:(NSString *)objectKeyPath
                 bridgeKeyPath:(NSString *)bridgeKeyPath
                      observer:(NSObject *)observer
                       options:(NSKeyValueObservingOptions)options
                       context:(void *)context
                         block:(IDPKVOKeyPathBindingBlock)block
{
    self = [super init];
    self.object = object;
    self.bridge = bridge;
    self.objectKeyPath = objectKeyPath;
    self.bridgeKeyPath = bridgeKeyPath;
    self.observer = observer;
    self.options = options;
    self.context = context;
    self.kvoController = [self kvoControllerForBindingBlock:block];
    
    return self;
}

#pragma mark -
#pragma mark Comparison

- (NSUInteger)hash {
    return [self.observer hash]
            ^ NSUIntegerBitRotate([self.objectKeyPath hash], 1)
            ^ NSUIntegerBitRotate([self.bridgeKeyPath hash], 2)
            ^ NSUIntegerBitRotate([self.object hash], 3)
            ^ NSUIntegerBitRotate([self.bridge hash], 4)
            ^ NSUIntegerBitRotate([self.observer hash], 5);
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (!object || ![self isMemberOfClass:[object class]]) {
        return NO;
    }

    return [self isEqualToBinding:object];
}

- (BOOL)isEqualToBindingWithoutContext:(IDPKVOKeyPathBinding *)object {
    return self.object == object.object
            && self.bridge == object.bridge
            && self.observer == object.observer
            && [self.objectKeyPath isEqualToString:object.objectKeyPath]
            && [self.bridgeKeyPath isEqualToString:object.bridgeKeyPath]
            && (self.context == object.context || self.context == NULL || object.context == NULL)
            && (self.options == object.options || self.options == 0 || object.options == 0);
}

- (BOOL)isEqualToBinding:(IDPKVOKeyPathBinding *)object {
    return [self isEqualToBindingWithoutContext:object] && self.context == object.context;
}

#pragma mark -
#pragma mark Private

- (IDPKVOController *)kvoControllerForBindingBlock:(IDPKVOKeyPathBindingBlock)block {
    block = block ? block : [self defaultBinding];
    
    IDPWeakify(self);
    
    return [self.object observeKeyPath:self.objectKeyPath handler:^(IDPKVONotification *notification) {
        IDPStrongifyAndReturnIfNil(self);
        
        block(self, notification);
    }];
}

- (IDPKVOKeyPathBindingBlock)defaultBinding {
    return ^(IDPKVOKeyPathBinding *binding, IDPKVONotification *notification) {
        [binding.observer observeValueForKeyPath:binding.bridgeKeyPath
                                        ofObject:binding.bridge
                                          change:notification.changesDictionary
                                         context:binding.context];
    };
}

@end
