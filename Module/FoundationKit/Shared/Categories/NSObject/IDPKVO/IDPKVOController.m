//
//  IDPKVOController.m
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "IDPKVOController.h"

#import "IDPKVONotification.h"

#import "IDPSafeKVOContext.h"

#import "NSObject+IDPKVOPrivate.h"

@interface IDPKVOController ()
@property (nonatomic, assign)   NSObject                    *object;
@property (nonatomic, copy)     NSArray                     *keyPaths;
@property (nonatomic, copy)     IDPKVONotificationBlock     handler;
@property (nonatomic, assign)   NSKeyValueObservingOptions  options;

@property (nonatomic, assign, getter = isValid) BOOL        valid;

@end

@implementation IDPKVOController

@synthesize observing   = _observing;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)controllerWithObject:(NSObject *)object
                            keyPaths:(NSArray *)keyPaths
                             handler:(IDPKVONotificationBlock)handler
{
    return [[self alloc] initWithObject:object
                               keyPaths:keyPaths
                                handler:handler];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self invalidate];
}

- (instancetype)init {
    return [self initWithObject:nil
                       keyPaths:nil
                        options:0
                        handler:nil];
}

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       handler:(IDPKVONotificationBlock)handler
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew
                                            | NSKeyValueObservingOptionOld
                                            | NSKeyValueObservingOptionInitial;
    
    return [self initWithObject:object
                       keyPaths:keyPaths
                        options:options
                        handler:handler];
}

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       options:(NSKeyValueObservingOptions)options
                       handler:(IDPKVONotificationBlock)handler
{
    if (!object
        || !keyPaths
        || 0 == [keyPaths count]
        || !handler
        || 0 == options)
    {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.object = object;
		self.keyPaths = keyPaths;
        self.handler = handler;
        self.options = options;
        self.valid = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isObserving {
    @synchronized (self) {
        return self.valid && _observing;
    }
}

- (void)setObserving:(BOOL)observing {
    @synchronized (self) {
        if (_observing != observing) {
            if (observing && self.valid) {
                [self startObserving];
            } else {
                [self stopObserving];
            }
            
            _observing = observing;
        }
    }
}

- (void)setObject:(NSObject *)object {
    if (object != _object) {
        if (_object) {
            [_object removeKVOController:self];
        }
        
        _object = object;
        
        if (_object) {
            [_object addKVOController:self];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)invalidate {
    @synchronized (self) {
        self.valid = NO;
        
        [self stopObserving];
        
        self.object = nil;
    }
}

#pragma mark -
#pragma mark Private

- (void)startObserving {
    NSObject *object = self.object;
    if (!object) {
        return;
    }

    NSKeyValueObservingOptions options = self.options;
    
    for (NSString *keyPath in self.keyPaths) {
        [object addObserver:self
                 forKeyPath:keyPath
                    options:options
                    context:NULL];
    }
    
    [IDPSafeKVOContext makeObjectSafe:object];
}

- (void)stopObserving {
    NSObject *object = self.object;
    if (!object) {
        return;
    }
    
    for (NSString *keyPath in self.keyPaths) {
        [object removeObserver:self
                    forKeyPath:keyPath];
    }
}

#pragma mark -
#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath 
					  ofObject:(id)object 
						change:(NSDictionary *)change 
					   context:(void *)context
{
    IDPKVONotification *notification = [IDPKVONotification notificationWithObject:self.object
                                                                          keyPath:keyPath
                                                                changesDictionary:change];
    
    IDPKVONotificationBlock handler = self.handler;
    handler(notification);
}


@end
