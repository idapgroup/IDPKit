//
//  IDPObservableObject.m
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import "IDPObservableObject.h"

@interface IDPObservableObject ()
@property (nonatomic, weak)     id<NSObject>    target;
@property (nonatomic, strong)   NSHashTable     *mutableObservers;

@end

@implementation IDPObservableObject

#pragma mark -
#pragma mark Class Methods


+ (instancetype)objectWithTarget:(id<NSObject>)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
}

- (id)init {
    return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id<NSObject>)target {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    return [self.mutableObservers setRepresentation];
}

- (id)target {
    return _target ? _target : self;
}

- (void)setState:(IDPObjectState)state object:(id)object {
    
}

#pragma mark -
#pragma mark Public

- (IDPObserver *)observerWithObject:(id)observer {
    return nil;
}

- (void)notifyObserversWithState:(IDPObjectState)state {
    
}

- (void)notifyObserversWithState:(IDPObjectState)state object:(id)object {
    
}

@end
