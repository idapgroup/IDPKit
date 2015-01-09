//
//  IDPObservableObject.h
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPObservableObject : NSObject
@property (nonatomic, readonly)	NSArray			*observers;

// Target is the object, that would be notified.
// Returns self by default.
@property (nonatomic, readonly) id <NSObject>   target;

// Observable object maintains weak links to its observers
// you are responsible to remove yourself as an observer,
// when you no longer need to observe the object
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (BOOL)isObjectAnObserver:(id)observer;

// These methods should only be called in child classes.
// Call these methods to notify the observers by calling
// their selectors.
- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector userInfo:(id)info;

@end
