//
//  ACModel.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

#import "IDPModelProxy.h"

#import "IDPOwnershipMacros.h"
#import "IDPReturnMacros.h"

@interface IDPModel ()
@property (nonatomic, strong)   NSOperationQueue    *queue;

@end

@implementation IDPModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)model {
    return [self modelWithQueue:nil];
}

+ (instancetype)modelWithQueue:(NSOperationQueue *)queue {
    return [[self alloc] initWithQueue:queue];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    return [self initWithQueue:nil];
}

- (instancetype)initWithQueue:(NSOperationQueue *)queue {
    return [self initWithQueue:queue target:nil];
}

- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target {
    self = [super initWithTarget:target];
    self.queue = queue ? queue : [self defaultQueue];
    
    Class proxyClass = [self proxyClass];
    
    return proxyClass ? [proxyClass proxyWithTarget:self] : self;
}

- (instancetype)initWithTarget:(id<NSObject>)target {
    return [self initWithQueue:nil target:target];
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (queue != _queue) {
        [_queue cancelAllOperations];
        _queue = queue;
    }
}

#pragma mark -
#pragma mark Public

- (Class)proxyClass {
    return [IDPModelProxy class];
}

- (NSOperationQueue *)defaultQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 1;
    queue.qualityOfService = NSQualityOfServiceUtility;
    
    return queue;
}

- (void)executeOperation:(NSOperation *)operation {
    [self.queue addOperation:operation];
}

- (NSBlockOperation *)executeBlock:(IDPModelBlock)block {
    IDPReturnNilIfNil(block);

    IDPWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        IDPStrongify(self);
        
        block(self);
    }];
    
    [self executeOperation:operation];
    
    return operation;
}

@end
