//
//  ACModel.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

@interface IDPModel ()
@property (nonatomic, assign, readwrite)    IDPModelState   state;

@end

@implementation IDPModel

@synthesize state               = _state;

@dynamic target;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cleanup];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if (IDPModelFinished == self.state) {
        [self notifyObserversOfSuccessfulLoad];
        return NO;
    }

    BOOL result = IDPModelLoading != self.state;
    self.state = IDPModelLoading;
    
    return result;
}

- (void)finishLoading {
    self.state = IDPModelFinished;
    [self notifyObserversOfSuccessfulLoad];
}

- (void)failLoading {
    self.state = IDPModelFailed;
    [self cleanup];
    [self notifyObserversOfFailedLoad];
}

- (void)cancel {
    if (IDPModelLoading != self.state) {
        return;
    }
    self.state = IDPModelCancelled;
    [self cleanup];
    [self notifyObserversOfCancelledLoad];
}

- (void)dump {
    if (IDPModelUnloaded == self.state) {
        return;
    }
    
    self.state = IDPModelUnloaded;
    [self cleanup];    
    [self notifyObserversOfUnload];
}

- (void)cleanup {
    
}

#pragma mark -
#pragma mark Private

- (void)notifyObserversOfSuccessfulLoad {
    [self notifyObserversWithSelector:@selector(modelDidLoad:)];
}

- (void)notifyObserversOfFailedLoad {
    [self notifyObserversWithSelector:@selector(modelDidFailToLoad:)];
}

- (void)notifyObserversOfCancelledLoad {
    [self notifyObserversWithSelector:@selector(modelDidCancelLoading:)];
}

- (void)notifyObserversOfChanges {
    [self notifyObserversWithSelector:@selector(modelDidChange:)];
}

- (void)notifyObserversOfChangesWithMessage:(NSDictionary *)message {
    SEL selector = @selector(modelDidChange:message:);

	[self notifyObserversWithSelector:selector
							 userInfo:message];
}

- (void)notifyObserversOfUnload {
    [self notifyObserversWithSelector:@selector(modelDidUnload:)];
}

@end
