//
//  IDPKVOObject.h
//  BudgetJar
//
//  Created by Oleksa Korin on 5/2/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVOObject;
@class IDPKVONotification;

typedef void(^IDPKVONotificationBlock)(IDPKVONotification *notification);

@interface IDPKVOObject : NSObject
@property (nonatomic, weak, readonly)   NSObject    *object;
@property (nonatomic, copy, readonly)   NSArray     *keyPaths;

@property (nonatomic, readonly)         NSKeyValueObservingOptions      options;
@property (nonatomic, copy, readonly)	IDPKVONotificationBlock         handler;

@property (atomic, assign, getter = isObserving)     BOOL    observing;

+ (instancetype)objectWithObject:(NSObject *)object
                        keyPaths:(NSArray *)keyPaths
                         handler:(IDPKVONotificationBlock)handler;

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       handler:(IDPKVONotificationBlock)handler;

- (instancetype)initWithObject:(NSObject *)object
                      keyPaths:(NSArray *)keyPaths
                       handler:(IDPKVONotificationBlock)handler
                       options:(NSKeyValueObservingOptions)options;

@end
