//
//  IDPKVOObject.m
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "IDPKVOObject.h"

#import "IDPKVONotification.h"

@interface IDPKVOObject ()
@property (nonatomic, weak)     NSObject                    *object;
@property (nonatomic, copy)     NSArray                     *keyPaths;
@property (nonatomic, copy)     IDPKVONotificationBlock     handler;
@property (nonatomic, assign)   NSKeyValueObservingOptions  options;

@end

@implementation IDPKVOObject

@synthesize observing   = _observing;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithObject:(NSObject *)object
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
	[self stopObserving];
}

- (instancetype)init {
    return [self initWithObject:nil
                       keyPaths:nil
                        handler:nil
                        options:0];
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
                        handler:handler
                        options:options];
}

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       handler:(IDPKVONotificationBlock)handler
                       options:(NSKeyValueObservingOptions)options
{
    self = [super init];
    if (self) {
        self.object = object;
		self.keyPaths = keyPaths;
        self.handler = handler;
        self.options = options;
    }
    
    if (!self.object
        || !self.keyPaths
        || 0 == [self.keyPaths count]
        || !self.handler
        || 0 == self.options)
    {
        return nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isObserving {
    @synchronized (self) {
        return _observing;
    }
}

- (void)setObserving:(BOOL)observing {
    @synchronized (self) {
        if (_observing != observing) {
            if (observing) {
                [self startObserving];
            } else {
                [self stopObserving];
            }
            
            _observing = observing;
        }
    }
}

#pragma mark -
#pragma mark Private

- (void)startObserving {
    NSKeyValueObservingOptions options = self.options;
    
	for (NSString *keyPath in self.keyPaths) {
		[self.object addObserver:self
                      forKeyPath:keyPath
                         options:options
                         context:NULL];
	}
}

- (void)stopObserving {
	for (NSString *keyPath in self.keyPaths) {
		[self.object removeObserver:self
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
