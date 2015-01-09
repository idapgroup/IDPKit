//
//  IDPKeyPathObserver.m
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "IDPKeyPathObserver.h"

#import "IDPPropertyMacros.h"

@interface IDPKeyPathObserver ()
@property (nonatomic, readwrite, assign) NSObject                       *objectToObserve;
@property (nonatomic, readwrite, assign) id<IDPKeyPathObserverDelegate> observer;
@property (nonatomic, readwrite, getter = isObserving, assign)  BOOL    observing;


@end

@implementation IDPKeyPathObserver

@synthesize objectToObserve			= _objectToObserve;
@synthesize observer				= _observer;
@synthesize observedKeyPathsArray	= _observedKeyPathsArray;
@synthesize observing				= _observing;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	[self stopObserving];
    self.objectToObserve = nil;
	self.observer = nil;
	self.observedKeyPathsArray = nil;
	
    [super dealloc];
}

- (id)initWithObservedObject:(NSObject *)object
			  observerObject:(id<IDPKeyPathObserverDelegate>)observer 
{
    self = [super init];
    if (self) {
        self.objectToObserve = object;
		self.observer = observer;
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setObservedKeyPathsArray:(NSArray *)theArray {
	BOOL temp = self.observing;
	
	if (self.observing) {
		[self stopObserving];
	}
	
	IDPNonatomicRetainPropertySynthesize(_observedKeyPathsArray, theArray);
	
	if (temp) {
		[self startObserving];
	}
}

#pragma mark -
#pragma mark Public

- (BOOL)isKeyPathInObservedArray:(NSString *)keyPath {
	for (NSString *arrayKeyPath in [self observedKeyPathsArray]) {
		if ([keyPath isEqualToString:arrayKeyPath]) {
			return YES;
		}
	}
	
	return NO;
}

- (void)startObserving {
	[self startObservingWithOptions:NSKeyValueObservingOptionNew];
}

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options {
	[self startObservingWithOptions:options context:NULL];
}

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options context:(void *)context {
    if (self.observing == YES) {
        return;
    }
    
	self.observing = YES;
	
	for (NSString *propertyKey in [self observedKeyPathsArray]) {
		[self.objectToObserve addObserver:self
                               forKeyPath:propertyKey
                                  options:options
                                  context:context];
	}
}

- (void)stopObserving {
    if (self.observing == NO) {
        return;
    }
    
	self.observing = NO;
	
	for (NSString *keyPath in [self observedKeyPathsArray]) {
		[self.objectToObserve removeObserver:self
                                  forKeyPath:keyPath];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
					  ofObject:(id)object 
						change:(NSDictionary *)change 
					   context:(void *)context
{
	if (object == self.objectToObserve && [self isKeyPathInObservedArray:keyPath]) {
		[self.observer keyPathObserver:self 
					   didCatchChanges:change 
							 inKeyPath:keyPath 
							  ofObject:self.objectToObserve];
	}
}


@end
