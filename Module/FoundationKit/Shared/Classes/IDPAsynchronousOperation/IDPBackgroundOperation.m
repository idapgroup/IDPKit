//
//  IDPBackgroundOperation.m
//  iOS
//
//  Created by Alexander Kradenkov on 4/19/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPBackgroundOperation.h"

static NSString * const kIDPBackgroundOperationIsExecutingKey   = @"isExecuting";
static NSString * const kIDPBackgroundOperationIsFinishedKey    = @"isFinished";

@interface IDPBackgroundOperation ()
@property (nonatomic, readwrite, getter = isExecuting)  BOOL    executing;
@property (nonatomic, readwrite, getter = isFinished)   BOOL    finished;

+ (BOOL)automaticallyNotifiesObserversOfExecuting;
+ (BOOL)automaticallyNotifiesObserversOfFinished;

@end


@implementation IDPBackgroundOperation

@dynamic asynchronous;

@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark -
#pragma mark Private Class Methods (KVO)

+ (BOOL)automaticallyNotifiesObserversOfExecuting {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfFinished {
    return NO;
}

#pragma mark -
#pragma mark Accessors

- (void)setExecuting:(BOOL)executing {
    if (_executing != executing) {
        [self willChangeValueForKey:kIDPBackgroundOperationIsExecutingKey];
        _executing = executing;
        [self didChangeValueForKey:kIDPBackgroundOperationIsExecutingKey];
    }
}

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:kIDPBackgroundOperationIsFinishedKey];
        _finished = finished;
        [self didChangeValueForKey:kIDPBackgroundOperationIsFinishedKey];
    }
}

- (BOOL)isAsynchronous {
    return YES;
}

#pragma mark -
#pragma mark Public Methods

- (void)complete {
    self.executing = NO;
    self.finished = YES;
}

#pragma mark -
#pragma mark NSOperation Methods

- (void)start {
    if (YES == self.isCancelled) {
        [self complete];
        
        return;
    }
    
    self.executing = YES;
    
    [self performSelectorInBackground:@selector(main) withObject:nil];
}

- (void)main {
    [self complete];
}

@end
