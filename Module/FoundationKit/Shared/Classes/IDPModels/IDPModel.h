//
//  ACModel.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPModel;

typedef NSOperation IDPContext;

typedef void(^IDPModelBlock)(IDPModel *model);

@interface IDPModel : IDPObservableObject
@property (nonatomic, readonly) NSArray     *contexts;

+ (instancetype)model;
+ (instancetype)modelWithQueue:(NSOperationQueue *)queue;

- (instancetype)initWithQueue:(NSOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

- (void)executeContext:(IDPContext *)context;

- (NSBlockOperation *)executeBlock:(IDPModelBlock)block;

@end
