//
//  ACModel.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPBlockTypes.h"

@interface IDPModel : IDPObservableObject

+ (instancetype)model;
+ (instancetype)modelWithQueue:(NSOperationQueue *)queue;

- (instancetype)initWithQueue:(NSOperationQueue *)queue NS_REPLACES_RECEIVER;
- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target NS_DESIGNATED_INITIALIZER NS_REPLACES_RECEIVER;

// you shouldn't call this method directly
// should be used for subclassing purposes
- (NSOperationQueue *)defaultQueue;

// you shouldn't call this method directly
// should be used for subclassing purposes
// should be descendant of IDPProxy
- (Class)proxyClass;

- (void)executeOperation:(NSOperation *)operation;

- (NSBlockOperation *)executeBlock:(IDPObjectBlock)block;
- (void)executeSyncBlock:(IDPObjectBlock)block;

@end
