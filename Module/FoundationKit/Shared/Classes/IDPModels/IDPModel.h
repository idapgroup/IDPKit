//
//  ACModel.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPModel;

typedef void(^IDPModelBlock)(IDPModel *model);

@interface IDPModel : IDPObservableObject

+ (instancetype)model;
+ (instancetype)modelWithQueue:(NSOperationQueue *)queue;

- (instancetype)initWithQueue:(NSOperationQueue *)queue NS_REPLACES_RECEIVER;
- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target NS_DESIGNATED_INITIALIZER NS_REPLACES_RECEIVER;

// you shouldn't call this method directly
// should be used for subclassing purposes
- (NSOperationQueue *)defaultQueue;

- (void)executeOperation:(NSOperation *)operation;

- (NSBlockOperation *)executeBlock:(IDPModelBlock)block;

@end
