//
//  ACModel.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

@interface IDPModel ()
@property (nonatomic, strong)   NSOperationQueue    *queue;

@end

@implementation IDPModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)model {
    return nil;
}

+ (instancetype)modelWithQueue:(NSOperationQueue *)queue {
    return nil;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithQueue:(NSOperationQueue *)queue {
    return [self initWithQueue:queue target:self];
}

- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target {
    self = [super initWithTarget:self];
    
    return self;
}

- (instancetype)initWithTarget:(id<NSObject>)target {
    return [self initWithQueue:nil target:target];
}

#pragma mark -
#pragma mark Public

- (void)executeOperation:(NSOperation *)oepration {
    
}

- (NSBlockOperation *)executeBlock:(IDPModelBlock)block {
    return nil;
}

@end
