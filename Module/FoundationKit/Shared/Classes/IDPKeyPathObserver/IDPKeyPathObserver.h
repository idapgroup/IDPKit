//
//  IDPKeyPathObserver.h
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKeyPathObserver;

@protocol IDPKeyPathObserverDelegate<NSObject>
@required
- (void)keyPathObserver:(IDPKeyPathObserver *)observer
		didCatchChanges:(NSDictionary *)changes
			  inKeyPath:(NSString *)keyPath
			   ofObject:(id<NSObject>)observedObject;
@end

@interface IDPKeyPathObserver : NSObject

@property (nonatomic, readonly)	NSObject                        *objectToObserve;
@property (nonatomic, readonly)	id<IDPKeyPathObserverDelegate>	observer;

// if new keyPath array is set while observing, 
// observer stops observing the old keypaths
// and starts observing the new ones
@property (nonatomic, retain)	NSArray					*observedKeyPathsArray;

@property (nonatomic, readonly, getter = isObserving) BOOL observing;

// both the object and the observer aren't retained
// class user is expected to guarantee, that they both exist
// while the class isntance is alive
- (id)initWithObservedObject:(NSObject *)object
			  observerObject:(id<IDPKeyPathObserverDelegate>)observer;

- (BOOL)isKeyPathInObservedArray:(NSString *)keyPath;

// only the new value is provided in changes dictionary of the method
- (void)startObserving;

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options;
- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)stopObserving;

@end
