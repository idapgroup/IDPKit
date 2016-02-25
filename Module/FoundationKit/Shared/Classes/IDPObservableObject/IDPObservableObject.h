//
//  IDPObservableObject.h
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObserver.h"

//IDPObservableObjectSpec
//  after being deallocated it should remove all observers
//  when observer starts observing
//      it should add observer into its observers
//      it should return IDPObserver object
//      multiple times it should return multiple unique observer objects
//  when observer stops observing it should remove observer from its observers
//  when object changes state
//      and sends changes in notification it should notify observers sending self and changes as parameters
//      and doesn't send changes in notification it should notify observers sending self and changes = nil as parameters
//      when observer pauses observation
//          it shouldn't send notifications to that observer
//          it should send notifications to other observers
//          when observer resumes observation it should send notifications to all unpaused observers

@interface IDPObservableObject : NSObject
@property (nonatomic, readonly)	NSSet   *observers;

// Target is the object, that notifies. It's weakly stored
// Returns self by default.
@property (nonatomic, readonly) id<NSObject>    target;

@property (nonatomic, assign)   IDPObjectState	state;

+ (instancetype)objectWithTarget:(id<NSObject>)target;

- (instancetype)initWithTarget:(id<NSObject>)target NS_DESIGNATED_INITIALIZER;

- (void)setState:(IDPObjectState)state object:(id)object;

- (IDPObserver *)observerWithObject:(id)observer;

- (void)notifyObserversWithState:(IDPObjectState)state;
- (void)notifyObserversWithState:(IDPObjectState)state object:(id)object;

@end
