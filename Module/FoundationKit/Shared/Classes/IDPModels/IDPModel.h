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

- (instancetype)initWithQueue:(NSOperationQueue *)queue;
- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target NS_DESIGNATED_INITIALIZER;

- (void)executeOperation:(NSOperation *)operation;

- (NSBlockOperation *)executeBlock:(IDPModelBlock)block;

@end
