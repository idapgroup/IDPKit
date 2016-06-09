//
//  IDPObservableObject.h
//  Location
//
//  Created by Oleksa Korin on 10/21/13.
//  Copyright (c) 2013 Oleksa Korin. All rights reserved.
//

#import "IDPObserver.h"

#import "IDPBlockTypes.h"

@interface IDPObservableObject : NSObject
@property (nonatomic, readonly)	NSSet               *observers;

// Target is the object, that notifies. It's weakly stored
// Returns self by default.
@property (nonatomic, weak, readonly) id  target;

@property (atomic, assign)  IDPObjectState	state;
- (void)setState:(IDPObjectState)state object:(id)object;


+ (instancetype)objectWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target NS_DESIGNATED_INITIALIZER;

- (IDPObserver *)observer;

- (void)notifyObserversWithState:(IDPObjectState)state;
- (void)notifyObserversWithState:(IDPObjectState)state object:(id)object;

- (void)performBlockWithNotifications:(IDPVoidBlock)block;
- (void)performBlockWithoutNotifications:(IDPVoidBlock)block;

@end
