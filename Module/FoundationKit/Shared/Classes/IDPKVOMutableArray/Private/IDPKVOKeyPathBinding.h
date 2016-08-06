//
//  IDPKVOKeyPathBinding.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVONotification;
@class IDPKVOKeyPathBinding;
@class IDPKVOKeyPathBindings;

typedef void(^IDPKVOKeyPathBindingBlock)(IDPKVOKeyPathBinding *binding, IDPKVONotification *notification);
typedef IDPKVONotification *(^IDPKVONotificationMappingBlock)(IDPKVONotification *notification);

@interface IDPKVOKeyPathBinding : NSObject
@property (nonatomic, weak, readonly)   IDPKVOKeyPathBindings       *bindings;
@property (nonatomic, weak, readonly)   NSObject                    *observer;
@property (nonatomic, copy, readonly)   NSString                    *keyPath;
@property (nonatomic, readonly)         NSKeyValueObservingOptions  options;
@property (nonatomic, readonly)         void                        *context;

// the block is used to transform IDPKVONotification
// it should return nil, if you don't want the current notification to be performed
@property (nonatomic, copy)             IDPKVONotificationMappingBlock  notificationMappingBlock;

// if block == nil it forwards all notifications from object to bridge replacing the keypaths,
// you can setup processing of notifications in block,
// you are responsible for the notifications delivery to observer in block call.
- (instancetype)initWithBindings:(IDPKVOKeyPathBindings *)bindings
                         keyPath:(NSString *)keyPath
                        observer:(NSObject *)observer
                         options:(NSKeyValueObservingOptions)options
                         context:(void *)context NS_DESIGNATED_INITIALIZER;


- (BOOL)isEqual:(id)object;
- (BOOL)isEqualToBinding:(IDPKVOKeyPathBinding *)object;

@end
