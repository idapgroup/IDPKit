//
//  IDPKVOKeyPathBinding.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPKVOKeyPathBinding.h"

#import "IDPComparison.h"
#import "IDPKVOKeyPathBindings.h"

#import "NSObject+IDPKVO.h"

#import "IDPOwnershipMacros.h"

@interface IDPKVOKeyPathBinding ()
@property (nonatomic, weak)     IDPKVOKeyPathBindings       *bindings;
@property (nonatomic, weak)     NSObject                    *observer;
@property (nonatomic, copy)     NSString                    *keyPath;
@property (nonatomic, assign)   NSKeyValueObservingOptions  options;
@property (nonatomic, assign)   void                        *context;
@property (nonatomic, strong)   IDPKVOController            *kvoController;

- (IDPKVOController *)bindingKvoController;

@end

@implementation IDPKVOKeyPathBinding

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithBindings:(IDPKVOKeyPathBindings *)bindings
                         keyPath:(NSString *)keyPath
                        observer:(NSObject *)observer
                         options:(NSKeyValueObservingOptions)options
                         context:(void *)context
{
    self = [super init];
    self.bindings = bindings;
    self.keyPath = keyPath;
    self.observer = observer;
    self.options = options;
    self.context = context;
    self.kvoController = [self bindingKvoController];
    
    return self;
}

- (instancetype)init {
    return [self initWithBindings:nil keyPath:nil observer:nil options:0 context:NULL];
}

#pragma mark -
#pragma mark Comparison

- (NSUInteger)hash {
    return (NSUInteger)self.bindings.object
            ^ NSUIntegerBitRotate([self.keyPath hash], 1)
            ^ NSUIntegerBitRotate((NSUInteger)self.observer, 2);
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

- (BOOL)isEqualToBinding:(IDPKVOKeyPathBinding *)object {
    return self.bindings == object.bindings
            && self.observer == object.observer
            && [self.keyPath isEqualToString:object.keyPath]
            && (self.context == object.context || self.context == NULL || object.context == NULL)
            && (self.options == object.options || self.options == 0 || object.options == 0);
}

#pragma mark -
#pragma mark Private

- (IDPKVOController *)bindingKvoController {
    IDPKVOKeyPathBindings *bindings = self.bindings;
    
    NSString *keyPath = self.keyPath;
    NSString *bindingKeyPath = bindings.keyPathBindings[keyPath];
    
    IDPWeakify(bindings);
    
    return [bindings.object observeKeyPath:bindingKeyPath ? bindingKeyPath : keyPath
                                   options:self.options
                                   handler:^(IDPKVONotification *notification)
            {
                IDPStrongifyAndReturnIfNil(bindings);
                
                IDPKVONotificationMappingBlock block = self.notificationMappingBlock;
                
                notification = !block ? notification : block(notification);
                
                if (notification) {
                    [self.observer observeValueForKeyPath:keyPath
                                                 ofObject:bindings.bridge
                                                   change:notification.changesDictionary
                                                  context:self.context];
                }
            }];
}

@end
