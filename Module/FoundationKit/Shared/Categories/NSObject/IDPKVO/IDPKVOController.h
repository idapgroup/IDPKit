//
//  IDPKVOController.h
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "IDPKVONotification.h"

@class IDPKVOController;

typedef void(^IDPKVONotificationBlock)(IDPKVONotification *notification);

@interface IDPKVOController : NSObject
@property (nonatomic, assign, readonly) NSObject    *object;
@property (nonatomic, copy, readonly)   NSArray     *keyPaths;

@property (nonatomic, readonly)         NSKeyValueObservingOptions      options;
@property (nonatomic, copy, readonly)	IDPKVONotificationBlock         handler;

@property (atomic, assign, getter = isObserving)    BOOL    observing;
@property (nonatomic, readonly, getter = isValid)   BOOL    valid;

+ (instancetype)controllerWithObject:(NSObject *)object
                            keyPaths:(NSArray *)keyPaths
                             handler:(IDPKVONotificationBlock)handler;

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       handler:(IDPKVONotificationBlock)handler;

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       options:(NSKeyValueObservingOptions)options
                       handler:(IDPKVONotificationBlock)handler;

/**
 *	Invalidates the object. It is unusable after invalidation.
 */
- (void)invalidate;

@end
