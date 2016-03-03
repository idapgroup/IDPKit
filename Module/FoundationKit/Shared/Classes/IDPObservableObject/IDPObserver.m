//
//  IDPObserver.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPObserver.h"

@implementation IDPObserver

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObservingObject:(id)observingObject observableObject:(IDPObservableObject *)observableObject {
    return nil;
}

#pragma mark -
#pragma mark Public

- (void)setBlock:(IDPObserverCallback)block forState:(IDPObjectState)state {
    
}

- (IDPObserverCallback)blockForState:(IDPObjectState)state {
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)state {
    return nil;
}

- (void)setObject:(id)block atIndexedSubscript:(NSUInteger)state {
    
}

- (void)executeBlockForState:(IDPObjectState)state object:(id)object {
    
}

@end
