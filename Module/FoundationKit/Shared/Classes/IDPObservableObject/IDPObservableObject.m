//
//  IDPObservableObject.m
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPWeakArray.h"

@interface IDPObservableObject ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservers;

@end

@implementation IDPObservableObject

@dynamic observers;
@dynamic target;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
	
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [IDPMutableWeakArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    return [[self.mutableObservers copy] autorelease];
}

#pragma mark -
#pragma mark Accessors

- (id)target {
    return self;
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    if (![self isObjectAnObserver:observer]) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    [self.mutableObservers removeObject:observer];
}

- (BOOL)isObjectAnObserver:(id)observer {
    return [self.mutableObservers containsObject:observer];
}

#pragma mark -
#pragma mark Private

- (void)notifyObserversWithSelector:(SEL)selector {
    for (id <NSObject> observer in self.observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self.target];
        }
    }
}

- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info {
    for (id<NSObject> observer in self.observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:info];
        }
    }
}

@end
