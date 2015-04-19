//
//  IDPAsynchronousOperation.m
//  iOS
//
//  Created by Alexander Kradenkov on 4/19/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPAsynchronousOperation.h"

static NSString * const kIDPAsynchronousOperationIsExecutingKey = @"isExecuting";
static NSString * const kIDPAsynchronousOperationIsFinishedKey  = @"isFinished";

@interface IDPAsynchronousOperation ()
@property (nonatomic, readwrite, getter = isExecuting)  BOOL    executing;
@property (nonatomic, readwrite, getter = isFinished)   BOOL    finished;

+ (BOOL)automaticallyNotifiesObserversOfExecuting;
+ (BOOL)automaticallyNotifiesObserversOfFinished;

@end


@implementation IDPAsynchronousOperation

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
        [self willChangeValueForKey:kIDPAsynchronousOperationIsExecutingKey];
        _executing = executing;
        [self didChangeValueForKey:kIDPAsynchronousOperationIsExecutingKey];
    }
}

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:kIDPAsynchronousOperationIsFinishedKey];
        _finished = finished;
        [self didChangeValueForKey:kIDPAsynchronousOperationIsFinishedKey];
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
